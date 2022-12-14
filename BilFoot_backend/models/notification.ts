import { Types, Schema, model } from "mongoose";

export interface INotification {
  _id?: Types.ObjectId;
  from: Types.ObjectId;
  to?: Types.ObjectId;
  player_model?: Types.ObjectId;
  match_model?: Types.ObjectId;
  team_model?: Types.ObjectId;
  player_announcement_model?: Types.ObjectId;
  opponent_announcement_model?: Types.ObjectId;
  interaction: "static" | "chat" | "approval";
  type: String;
  status: "vending" | "accepted" | "refused"; // also add to answerNotification
  isDeleted?: boolean;
}

const notificationSchema = new Schema<INotification>({
  from: { type: Schema.Types.ObjectId, ref: "player" },
  to: { type: Schema.Types.ObjectId, ref: "player" },
  match_model: { type: Schema.Types.ObjectId, ref: "match" },
  team_model: { type: Schema.Types.ObjectId, ref: "team" },
  player_model: { type: Schema.Types.ObjectId, ref: "player" },
  player_announcement_model: {
    type: Schema.Types.ObjectId,
    ref: "player_announcement",
  },
  opponent_announcement_model: {
    type: Schema.Types.ObjectId,
    ref: "opponent_announcement",
  },
  interaction: { type: String, required: true },
  type: { type: String, required: true },
  status: { type: String, required: true },
  isDeleted: { type: Boolean, default: false },
});

export default model<INotification>("notification", notificationSchema);
