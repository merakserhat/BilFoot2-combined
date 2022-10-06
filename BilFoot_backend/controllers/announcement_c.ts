import { Request, Response, NextFunction } from "express";
import mongoose from "mongoose";
import Match from "../models/match";
import Notification, { INotification } from "../models/notification";
import OpponentAnnouncement from "../models/opponent_announcement";
import Player from "../models/player";
import PlayerAnnouncement from "../models/player_announcement";
import Team from "../models/team";
import { NotificationTypes } from "../utils/notification_types";

/**
 *
 * @body announcement_type opponent player
 * @body match_id
 * @body team_id ?
 * @body player_limit ?
 * @body positions ?
 */
export const createAnnouncement = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { announcement_type, match_id, team_id, player_limit, positions } =
    req.body;

  if (announcement_type === undefined || match_id === undefined) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user_email = (req as any).user_email;

  if (user_email === undefined) {
    return res.status(500).json({ error: "user_mail is not defined" });
  }

  const user = await Player.findOne({ email: user_email });

  if (user === null) {
    return res.status(400).json({ error: "User not found" });
  }

  const match = await Match.findById(new mongoose.Types.ObjectId(match_id));
  if (match === null) {
    return res.status(400).json({ error: "Match not found" });
  }

  if (!match.players.includes(user.id)) {
    return res.status(401).json({ error: "You are not in this match" });
  }

  if (announcement_type === "player") {
    if (player_limit === undefined || positions === undefined) {
      return res.status(400).json({
        error:
          "Player limit and positions is required for new player announcement",
      });
    }

    const playerAnnouncement = new PlayerAnnouncement({
      announcer: user.id,
      created_at: new Date(Date.now()),
      positions,
      match: match.id,
      player_limit,
    });

    const result = await playerAnnouncement.save();

    res.status(201).json({ player_announcement: result });
  } else if (announcement_type == "opponent") {
    if (team_id === undefined) {
      return res.status(400).json({
        error: "Team id is required for new opponent announcement",
      });
    }

    const team = await Team.findById(new mongoose.Types.ObjectId(team_id));

    if (team === null) {
      return res.status(400).json({ error: "Match not found" });
    }

    if (!team.players.includes(user.id)) {
      return res.status(401).json({ error: "You are not in this team" });
    }

    const opponentAnnouncement = new OpponentAnnouncement({
      announcer: user.id,
      created_at: new Date(Date.now()),
      match: match.id,
      team: team.id,
    });

    const result = await opponentAnnouncement.save();

    res.status(201).json({ opponent_announcement: result });
  } else {
    return res.status(400).json({ error: "announcement type is invalid" });
  }
};
//example bodies
/*
 * player announcement
{
    "announcement_type": "player",
    "player_limit": 3,
    "positions": ["GK", "MD"],
    "match_id": "630fa6c89ea3cd6cdc1634b7"
}

* opponent announcement
{
    "announcement_type": "opponent",
    "match_id": "630fa6c89ea3cd6cdc1634b7"
    "team_id": "62f01e9681c097b01e4d777f"
}

*/

////////////////////////////
//Players click to join match button at player annaouncement
// is auth -> player
// annaouncement id
export const playerAnnouncementJoinRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { announcement_id } = req.body;

  if (announcement_id === undefined) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user_email = (req as any).user_email;

  if (user_email === undefined) {
    return res.status(500).json({ error: "user_mail is not defined" });
  }

  const user = await Player.findOne({ email: user_email });

  if (user === null) {
    return res.status(400).json({ error: "User not found" });
  }

  const playerAnnouncement = await PlayerAnnouncement.findById(
    new mongoose.Types.ObjectId(announcement_id)
  );

  if (!playerAnnouncement) {
    return res.status(400).json({ error: "playerAnnouncement not found" });
  }

  //Notification oluşturmamız gerekiyor
  const invitation = new Notification<INotification>({
    from: user._id,
    to: playerAnnouncement.announcer,
    type: NotificationTypes.playerAnnouncementJoinRequest,
    player_announcement_model: playerAnnouncement._id,
    status: "vending",
    interaction: "approval",
  });

  invitation.save();

  playerAnnouncement.candidates.push(user._id);
  playerAnnouncement.save();
};
