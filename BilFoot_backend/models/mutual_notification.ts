import { Types, Schema, model } from "mongoose";

export interface IMutualNotification {
  _id?: Types.ObjectId;
  from: Types.ObjectId;
  to: Types.ObjectId;
  object?: Types.ObjectId;
  type: "team_invitation" | "match_invitation";
  status: "vending" | "accepted" | "refused";
}

const mutualNotificationSchema = new Schema<IMutualNotification>({
  from: { type: Schema.Types.ObjectId, ref: "player", required: true },
  to: { type: Schema.Types.ObjectId, ref: "player", required: true },
  object: { type: Schema.Types.ObjectId },
  type: { type: String, required: true },
  status: { type: String, required: true },
});

export default model<IMutualNotification>(
  "mutual_notification",
  mutualNotificationSchema
);
