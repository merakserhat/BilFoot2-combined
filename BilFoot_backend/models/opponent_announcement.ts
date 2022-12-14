import { Types, Schema, model } from "mongoose";

interface IOpponentAnnouncement {
  announcer: Types.ObjectId;
  created_at: Date;
  team: Types.ObjectId;
  match: Types.ObjectId;
  isDeleted?: boolean;
}

const opponentAnnouncementSchema = new Schema<IOpponentAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true, ref: "player" },
  created_at: { type: Date, required: true },
  team: { type: Schema.Types.ObjectId, required: true, ref: "team" },
  match: { type: Schema.Types.ObjectId, required: true, ref: "match" },
  isDeleted: { type: Boolean, default: false },
});

export default model<IOpponentAnnouncement>(
  "opponent_announcement",
  opponentAnnouncementSchema
);
