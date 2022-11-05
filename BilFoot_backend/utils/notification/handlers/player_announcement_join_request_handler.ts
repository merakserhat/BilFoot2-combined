import mongoose from "mongoose";
import Notification, { INotification } from "../../../models/notification";
import PlayerAnnouncement from "../../../models/player_announcement";
import Player, { IPlayer } from "../../../models/player";
import Match from "../../../models/match";
import { NotificationTypes } from "../notification_types";
import Team from "../../../models/team";

export const handlePlayerAnnouncementJoinRequest = async (
  notification: mongoose.Document<unknown, any, INotification> &
    INotification & {
      _id: mongoose.Types.ObjectId | undefined;
    },
  answer: string,
  user: mongoose.Document<unknown, any, IPlayer> &
    IPlayer & {
      _id: mongoose.Types.ObjectId;
    }
) => {
  const announcementModel = await PlayerAnnouncement.findById(
    notification.player_announcement_model
  );
  if (announcementModel === null) {
    return;
  }

  const fromUser = await Player.findById(notification.from);

  if (fromUser === null) {
    return;
  }

  announcementModel.candidates = announcementModel.candidates.filter(
    (id) => !id.equals(notification.from)
  );

  if (answer === "accepted") {
    const match = await Match.findById(notification.match_model);
    if (match === null) {
      return console.log("match could not found at notification answer");
    }

    if (!match.players.includes(notification.from)) {
      match.players.push(notification.from);
    }

    if (!fromUser.matches.includes(match._id)) {
      fromUser.matches.push(match._id);
    }

    fromUser.save();

    announcementModel.accepted_players.push(fromUser._id);
  } else {
    announcementModel.refused_players.push(fromUser._id);
  }

  const answerNotification = new Notification({
    from: notification.to,
    to: notification.from,
    player_model: user._id,
    team_model: notification.team_model,
    match_model: notification.match_model,
    interaction: "static",
    status: answer,
    type: NotificationTypes.playerAnnouncementJoinRequestAnswer,
  });

  answerNotification.save();
  announcementModel.save();
};
