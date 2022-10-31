import mongoose from "mongoose";
import Notification, { INotification } from "../../../models/notification";
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
  if (answer === "accepted") {
    const match = await Match.findById(notification.match_model);
    if (match === null) {
      return console.log("match could not found at notification answer");
    }

    if (!match.players.includes(user._id)) {
      match.players.push(user._id);
    }

    if (!user.matches.includes(match._id)) {
      user.matches.push(match._id);
    }
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
};
