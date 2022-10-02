import { Types, Schema, model } from "mongoose";

interface IOpponentAnnouncement {
  announcer: Types.ObjectId;
  date: Date;
  team: Types.ObjectId;
  match: Types.ObjectId;
}

const opponentAnnouncementSchema = new Schema<IOpponentAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true },
  date: { type: Date, required: true },
  team: { type: Schema.Types.ObjectId, required: true, ref: "team" },
  match: { type: Schema.Types.ObjectId, required: true, ref: "match" },
});

export default model<IOpponentAnnouncement>(
  "opponent_announcement",
  opponentAnnouncementSchema
);
