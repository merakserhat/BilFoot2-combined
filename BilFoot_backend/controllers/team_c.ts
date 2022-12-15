import { Request, Response, NextFunction } from "express";
import mongoose from "mongoose";
import Notification, { INotification } from "../models/notification";
import Player, { IPlayer } from "../models/player";
import Team, { ITeam } from "../models/team";
import { Types, Schema, model, Document } from "mongoose";
import { NotificationTypes } from "../utils/notification/notification_types";
import { ObjectId, ObjectIdLike } from "bson";
import { teamPopulateRule } from "../utils/populate_rules";

export const createTeam = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { name, short_name, main_color, accent_color } = req.body;

  if (
    name == undefined ||
    short_name == undefined ||
    main_color == undefined ||
    accent_color == undefined
  ) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user_email = (req as any).user_email;

  if (user_email == undefined) {
    return res.status(500).json({ error: "user_mail is not defined" });
  }

  const user = await Player.findOne({
    email: user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(400).json({ error: "User not found" });
  }

  const team = new Team({
    name,
    short_name,
    main_color,
    accent_color,
    creator: user._id,
    captain: user._id,
    players: [user._id],
  });

  const newTeam = await team.save();

  user.teams.push(newTeam._id);
  await user.save();

  return res.status(201).json({ team: newTeam });
};

export const inviteToTeam = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  //TODO: get team id and user id
  //TODO: get user from user email and check the authority
  //TODO: if authorized, create new mutual notification with correct type
  //TODO: send notification to to_user

  const { team_id, to_id } = req.body;

  if (typeof team_id != "string" || typeof to_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const team = await Team.findById(new mongoose.Types.ObjectId(team_id));

  if (team == null) {
    return res.status(404).json({ error: "team not found" });
  }

  if (!team.captain.equals(user._id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to invite people!" });
  }

  const invitation = new Notification<INotification>({
    from: user._id,
    to: new mongoose.Types.ObjectId(to_id),
    team_model: team._id,
    type: NotificationTypes.teamInvitation,
    status: "vending",
    interaction: "approval",
  });

  await invitation.save();

  //TODO: send notification to the user

  res.status(201).json({ status: "success" });
};

export const getTeamInvitation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { from_id, to_id, team_id } = req.query;

  if (
    typeof from_id != "string" ||
    typeof to_id != "string" ||
    typeof team_id != "string"
  ) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const invitation = await Notification.findOne({
    from: new mongoose.Types.ObjectId(from_id),
    to: new mongoose.Types.ObjectId(to_id),
    type: NotificationTypes.teamInvitation,
    status: "vending",
    team_model: new mongoose.Types.ObjectId(team_id),
    isDeleted: { $ne: true },
  });

  console.log(invitation);

  res.status(200).json({ invitation });
};
/*
export const answerToTeamInvitation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { invitation_id, is_accepted } = req.body;

  if (typeof invitation_id != "string" || typeof is_accepted != "boolean") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const invitation = await Notification.findById(
    new mongoose.Types.ObjectId(invitation_id)
  );

  if (invitation === null) {
    return res.status(404).json({ error: "invitation not found" });
  }

  const user = await Player.findOne({ email: (req as any).email });

  if (user === null) {
    return res.status(401).json({ error: "user not found" });
  }

  if (!invitation.from.equals(user._id)) {
    return res
      .status(401)
      .json({ error: "invitation is not belong to this user" });
  }

  const answer_notification = new Notification<INotification>({
    from: user._id,
    to: invitation.from,
    type: "",
    status: "vending",
    interaction: "static",
  });

  if (is_accepted) {
    invitation.status = "accepted";
    await invitation.save();
    //TODO send notification to to user
    const team = await Team.findById(invitation.team_model);
    team?.players.push(user._id);
    await team?.save();

    team && user.teams.push(team?._id);
    await user.save();

    answer_notification.status = "accepted";
    answer_notification.type = NotificationTypes.teamInvitationAccepted;
  } else {
    invitation.status = "refused";
    await invitation.save();
    answer_notification.status = "refused";
    answer_notification.type = NotificationTypes.teamInvitationRefused;
  }

  answer_notification.save();

  res.status(200).json({ status: "success" });
};
*/
export const makeCaptain = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { team_id, new_captain_id } = req.body;

  if (typeof team_id != "string" || typeof new_captain_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const team = await Team.findById(new mongoose.Types.ObjectId(team_id));

  if (team == null) {
    return res.status(404).json({ error: "team not found" });
  }

  if (!team.captain.equals(user._id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to make people captain!" });
  }

  if (!team.players.includes(new mongoose.Types.ObjectId(new_captain_id))) {
    return res.status(401).json({
      error:
        "You can not make select the person who is not in your team as a captain",
    });
  }

  team.captain = new mongoose.Types.ObjectId(new_captain_id);

  team.save();

  res.status(201).json({ status: "success" });
};

export const kickPlayer = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { team_id, kicked_player_id } = req.body;

  if (typeof team_id != "string" || typeof kicked_player_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const team = await Team.findById(new mongoose.Types.ObjectId(team_id));

  if (team == null) {
    return res.status(404).json({ error: "team not found" });
  }

  if (!team.captain.equals(user._id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to kick people!" });
  }

  if (!team.players.includes(new mongoose.Types.ObjectId(kicked_player_id))) {
    return res.status(401).json({
      error: "You can not kick the person who is not in your team",
    });
  }

  team.players = team.players.filter(
    (player) =>
      !player._id.equals(new mongoose.Types.ObjectId(kicked_player_id))
  );
  await team.save();

  res.status(201).json({ status: "success" });
};

export const getTeamModel = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { id } = req.query;

  if (typeof id !== "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const team_model = await Team.findById(
    new mongoose.Types.ObjectId(id)
  ).populate(teamPopulateRule);

  if (team_model == null) {
    return res.status(400).json({ error: "Team Model not found" });
  }

  return res.status(200).json({ team_model });
};

export const getTeamsWithIds = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { ids } = req.body;

  if (!Array.isArray(ids)) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const idObjectIds = ids.map((id) => new mongoose.Types.ObjectId(id));

  const teams = await Team.find({
    _id: idObjectIds,
    isDeleted: { $ne: true },
  }).populate(teamPopulateRule);

  return res.status(200).json({ teams });
};

export const quitTeam = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { team_id } = req.body;
  const { user_email } = req as any;

  if (typeof team_id !== "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const team_model = await Team.findById(new mongoose.Types.ObjectId(team_id));

  if (team_model == null) {
    return res.status(400).json({ error: "Team Model not found" });
  }

  const user_model = await Player.findOne({
    email: user_email,
    isDeleted: { $ne: true },
  });

  if (user_model == null) {
    return res.status(400).json({ error: "User Model not found" });
  }

  user_model.teams = user_model.teams.filter(
    (team_id) => !team_id.equals(team_model._id)
  );

  team_model.players = team_model.players.filter(
    (player_id) => !player_id.equals(user_model._id)
  );

  if (team_model.players.length === 0) {
    //if we remove the team, we should also remove the notifications those are related to this team
    const notifications = await Notification.find({
      team_model: team_model._id,
    });

    for (let i = 0; i < notifications.length; i++) {
      notifications[i].remove();
    }

    team_model.remove();
  } else if (team_model.captain.equals(user_model._id)) {
    team_model.captain = team_model.players[0];
    team_model.save();
  }

  user_model.save();

  console.log(user_model);

  return res.status(200).json({ message: "success" });
};

export const editTeam = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { name, short_name, main_color, accent_color, team_id } = req.body;

  if (typeof team_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user_email = (req as any).user_email;

  if (user_email == undefined) {
    return res.status(500).json({ error: "user_mail is not defined" });
  }

  const user = await Player.findOne({
    email: user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(400).json({ error: "User not found" });
  }

  const team_model = await Team.findById(new mongoose.Types.ObjectId(team_id));

  if (team_model == null) {
    return res.status(400).json({ error: "Team Model not found" });
  }

  team_model.name = name ?? team_model.name;
  team_model.short_name = short_name ?? team_model.short_name;
  team_model.main_color = main_color ?? team_model.main_color;
  team_model.accent_color = accent_color ?? team_model.accent_color;

  await team_model.save();

  res.status(201).json({ message: "successful" });
};

export const getPlayerTeams = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const matches = await Team.find({
    _id: user.teams,
    isDeleted: { $ne: true },
  }).populate(teamPopulateRule);

  return res.status(200).json({ matches });
};
