import mongoose from "mongoose";
import Match from "../models/match";
import Notification, { INotification } from "../models/notification";
import Player, { IPlayer } from "../models/player";
import Team from "../models/team";
import { NotificationTypes } from "./notification_types";

export default async (
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
  switch (notification.type) {
    case NotificationTypes.teamInvitation:
      {
        if (answer === "accepted") {
          const team = await Team.findById(notification.team_model);
          if (team === null) {
            return console.log("team could not found at notification answer");
          }

          if (!team.players.includes(user._id)) {
            team.players.push(user._id);
          }

          if (!user.teams.includes(team._id)) {
            user.teams.push(team._id);
          }

          team.save();
          user.save();
        }

        const answerNotification = new Notification({
          from: notification.to,
          to: notification.from,
          player_model: user._id,
          team_model: notification.team_model,
          interaction: "static",
          status: answer,
          type: NotificationTypes.teamInvitationAnswer,
        });

        answerNotification.save();
      }
      break;
    case NotificationTypes.matchInvitation:
      {
        if (answer === "accepted") {
          const match = await Match.findById(notification.match_model);
          if (match === null) {
            return console.log("team could not found at notification answer");
          }

          if (!match.players.includes(user._id)) {
            match.players.push(user._id);
          }
          /*
          if (!user.teams.includes(team._id)) {
            user.teams.push(team._id);
          }
*/

          match.save();
          //user.save();
        }

        const answerNotification = new Notification({
          from: notification.to,
          to: notification.from,
          player_model: user._id,
          match_model: notification.match_model,
          interaction: "static",
          status: answer,
          type: NotificationTypes.matchInvitationAnswer,
        });

        answerNotification.save();
      }
      break;

    default:
      break;
  }
};
