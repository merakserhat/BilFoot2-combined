import { Request, Response, NextFunction } from "express";
import mongoose from "mongoose";
import Match from "../models/match";
import Notification, { INotification } from "../models/notification";
import Player from "../models/player";
import { NotificationTypes } from "../utils/notification/notification_types";
import { matchPopulateRule } from "../utils/populate_rules";

export const getMatches = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const past_matches = await Match.find({
    date: { $lt: new Date(Date.now()) },
    isDeleted: { $ne: true },
  })
    .populate(matchPopulateRule)
    .limit(10)
    .sort({ date: -1 });
  const upcoming_matches = await Match.find({
    date: { $gt: new Date(Date.now()) },
    isDeleted: { $ne: true },
  })
    .populate(matchPopulateRule)
    .limit(10)
    .sort({ date: -1 });

  console.log("past_matches", past_matches);

  res.status(200).json({ past_matches, upcoming_matches });
};

export const createMatch = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { date, hour, pitch, is_pitch_approved, show_on_table, people_limit } =
    req.body;

  if (
    date == undefined ||
    hour == undefined ||
    pitch == undefined ||
    is_pitch_approved == undefined ||
    show_on_table == undefined ||
    people_limit == undefined
  ) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user_email = (req as any).user_email;

  if (user_email == undefined) {
    return res.status(500).json({ error: "user_mail is not defined" });
  }

  const user = await Player.findOne({ email: user_email });

  if (user == null) {
    return res.status(400).json({ error: "User not found" });
  }

  const match = new Match({
    date: new Date(`${date}Z`),
    hour,
    pitch,
    is_pitch_approved,
    creator: user._id,
    players: [user._id],
    auth_players: [user._id],
    show_on_table,
    people_limit,
  });

  const newMatch = await match.save();
  const matchPopulated = await Match.findById(newMatch._id).populate(
    matchPopulateRule
  );

  user.matches.push(newMatch._id);
  await user.save();

  return res.status(201).json({ match: matchPopulated });
};

export const removeMatch = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { match_id } = req.body;

  if (match_id == undefined) {
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

  let match = await Match.findById(new mongoose.Types.ObjectId(match_id));

  if (match == null) {
    return res.status(400).json({ error: "Match not found" });
  }

  //check if the player has auth to remove match
  if (!match.auth_players.includes(user.id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to edit match" });
  }

  await match.remove();

  res.status(200).json({ message: "success" });
};

export const editMatch = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let {
    match_id,
    date,
    hour,
    pitch,
    is_pitch_approved,
    show_on_table,
    people_limit,
  } = req.body;

  if (match_id == undefined) {
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

  let match = await Match.findById(new mongoose.Types.ObjectId(match_id));

  if (match == null) {
    return res.status(400).json({ error: "Match not found" });
  }

  //check if the player has auth to edit match
  if (!match.auth_players.includes(user.id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to edit match" });
  }

  if (!date.includes("Z")) {
    date = `${date}Z`;
  }

  match.hour = hour || match.hour;
  match.pitch = pitch || match.pitch;
  match.is_pitch_approved = is_pitch_approved || match.is_pitch_approved;
  match.show_on_table = show_on_table || match.show_on_table;
  match.people_limit = people_limit || match.people_limit;
  match.date = date ? new Date(date) : match.date;

  const newMatch = await match.save();
  const matchPopulated = await Match.findById(newMatch._id).populate(
    matchPopulateRule
  );

  //   user.matches.push(newTeam._id);
  //   await user.save();

  return res.status(201).json({ match: matchPopulated });
};

export const kickPlayer = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { match_id, kicked_player_id } = req.body;

  if (typeof match_id != "string" || typeof kicked_player_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const kickPlayerObjectId = new mongoose.Types.ObjectId(kicked_player_id);

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const match = await Match.findById(new mongoose.Types.ObjectId(match_id));

  if (match == null) {
    return res.status(404).json({ error: "team not found" });
  }

  if (!match.auth_players.includes(user._id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to kick people!" });
  }

  if (!match.players.includes(kickPlayerObjectId)) {
    return res.status(401).json({
      error: "You can not kick the person who is not in your team",
    });
  }

  match.players = match.players.filter(
    (player) => !player._id.equals(kickPlayerObjectId)
  );
  if (match.auth_players.includes(kickPlayerObjectId)) {
    match.auth_players = match.auth_players.filter(
      (auth_player) => !auth_player._id.equals(kickPlayerObjectId)
    );
  }
  await match.save();

  res.status(201).json({ status: "success" });

  //remove match id from kicked player
  const kickedPlayer = await Player.findById(kickPlayerObjectId);

  if (kickedPlayer) {
    kickedPlayer.matches = kickedPlayer?.matches.filter(
      (matchId) => !matchId.equals(match.id)
    );

    kickedPlayer.save();
  }
};

export const quitMatch = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { match_id } = req.body;
  const { user_email } = req as any;

  if (typeof match_id !== "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const match_model = await Match.findById(
    new mongoose.Types.ObjectId(match_id)
  );

  if (match_model == null) {
    return res.status(400).json({ error: "Match Model not found" });
  }

  const user_model = await Player.findOne({
    email: user_email,
    isDeleted: { $ne: true },
  });

  if (user_model == null) {
    return res.status(400).json({ error: "User Model not found" });
  }

  //remove match id when we quit
  user_model.matches = user_model.matches.filter(
    (matchId) => !matchId.equals(match_model._id)
  );

  match_model.players = match_model.players.filter(
    (player_id) => !player_id.equals(user_model._id)
  );

  if (match_model.auth_players.includes(user_model._id)) {
    match_model.auth_players = match_model.auth_players.filter(
      (auth_player) => !auth_player._id.equals(user_model._id)
    );
  }

  if (match_model.players.length === 0) {
    //if we remove the team, we should also remove the notifications those are related to this team
    const notifications = await Notification.find({
      match_model: match_model._id,
    });

    for (let i = 0; i < notifications.length; i++) {
      notifications[i].remove();
    }

    match_model.remove();
  } else if (match_model.auth_players.length == 0) {
    match_model.auth_players = [match_model.players[0]];
    match_model.save();
  } else {
    match_model.save();
  }

  user_model.save();

  return res.status(200).json({ message: "success" });
};

export const giveAuth = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { match_id, auth_player_id } = req.body;

  if (typeof match_id != "string" || typeof auth_player_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const match = await Match.findById(new mongoose.Types.ObjectId(match_id));

  if (match == null) {
    return res.status(404).json({ error: "team not found" });
  }

  if (!match.auth_players.includes(user._id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to make people captain!" });
  }

  if (!match.players.includes(new mongoose.Types.ObjectId(auth_player_id))) {
    return res.status(401).json({
      error: "You can not give auth to the person who is not in your match",
    });
  }

  match.auth_players = [
    ...match.auth_players,
    new mongoose.Types.ObjectId(auth_player_id),
  ];

  match.save();

  res.status(201).json({ status: "success" });
};

//TODO: multiple "to" at notification
export const requestToJoin = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { match_id } = req.body;

  if (typeof match_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const match = await Match.findById(new mongoose.Types.ObjectId(match_id));

  if (match == null) {
    return res.status(404).json({ error: "team not found" });
  }
};

export const getMatchInvitation = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { from_id, to_id, match_id } = req.query;

  if (
    typeof from_id != "string" ||
    typeof to_id != "string" ||
    typeof match_id != "string"
  ) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const invitation = await Notification.findOne({
    from: new mongoose.Types.ObjectId(from_id),
    to: new mongoose.Types.ObjectId(to_id),
    type: NotificationTypes.matchInvitation,
    status: "vending",
    match_model: new mongoose.Types.ObjectId(match_id),
    isDeleted: { $ne: true },
  });

  console.log(invitation);

  res.status(200).json({ invitation });
};

export const inviteToMatch = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  //TODO: get team id and user id
  //TODO: get user from user email and check the authority
  //TODO: if authorized, create new mutual notification with correct type
  //TODO: send notification to to_user

  const { match_id, to_id } = req.body;

  if (typeof match_id != "string" || typeof to_id != "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  const match = await Match.findById(new mongoose.Types.ObjectId(match_id));

  if (match == null) {
    return res.status(404).json({ error: "team not found" });
  }

  if (!match.auth_players.includes(user._id)) {
    return res
      .status(401)
      .json({ error: "You are not authorized to invite people!" });
  }

  const invitation = new Notification<INotification>({
    from: user._id,
    to: new mongoose.Types.ObjectId(to_id),
    match_model: match._id,
    type: NotificationTypes.matchInvitation,
    status: "vending",
    interaction: "approval",
  });

  await invitation.save();

  //TODO: send notification to the user

  res.status(201).json({ status: "success" });
};

export const getPlayerMatches = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { show_only_upcoming } = req.query;

  const user = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (user == null) {
    return res.status(401).json({ error: "user not found" });
  }

  let filter = { _id: user.matches, date: {} };

  if (show_only_upcoming) {
    filter.date = { $gt: new Date(Date.now()) };
  }

  const matches = await Match.find(filter).populate(matchPopulateRule);

  return res.status(200).json({ matches });
};
