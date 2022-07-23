import { Types, Schema, model } from "mongoose";

export interface INotification {
  _id?: Types.ObjectId;
  from: Types.ObjectId;
  to?: Types.ObjectId;
  object?: Types.ObjectId;
  type: "team_invitation" | "match_invitation";
  status: "vending" | "accepted" | "refused";
}

const notificationSchema = new Schema<INotification>({
  from: { type: Schema.Types.ObjectId, ref: "player" },
  to: { type: Schema.Types.ObjectId, ref: "player" },
  object: { type: Schema.Types.ObjectId },
  type: { type: String, required: true },
  status: { type: String, required: true },
});

export default model<INotification>("notification", notificationSchema);
