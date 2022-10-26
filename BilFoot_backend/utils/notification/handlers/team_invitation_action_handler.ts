import mongoose from "mongoose";
import Notification, { INotification } from "../../../models/notification";
import Player, { IPlayer } from "../../../models/player";
import Match from "../../../models/match";
import { NotificationTypes } from "../notification_types";
import Team from "../../../models/team";

export const handleTeamInvitationAction = async (
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
};
