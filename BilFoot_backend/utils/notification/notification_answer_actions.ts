import mongoose from "mongoose";
import Notification, { INotification } from "../../models/notification";
import Player, { IPlayer } from "../../models/player";
import { handleMatchInvitationAction } from "./handlers/match_invitation_action_handler";
import { handlePlayerAnnouncementJoinRequest } from "./handlers/player_announcement_join_request_handler";
import { handleTeamInvitationAction } from "./handlers/team_invitation_action_handler";
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
      handleTeamInvitationAction(notification, answer, user);
      break;
    case NotificationTypes.matchInvitation:
      handleMatchInvitationAction(notification, answer, user);
      break;
    case NotificationTypes.playerAnnouncementJoinRequest:
      handlePlayerAnnouncementJoinRequest(notification, answer, user);
      break;
    default:
      break;
  }
};
