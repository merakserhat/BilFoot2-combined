import { ObjectId } from "mongodb";
import { Types, Schema, model } from "mongoose";

interface IPlayerAnnouncement {
  announcer: Types.ObjectId;
  created_at: Date;
  positions: string[];
  match: Types.ObjectId;
  candidates: Types.ObjectId[];
  player_limit: Number;
}

const playerAnnouncementSchema = new Schema<IPlayerAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true, ref: "player" },
  created_at: { type: Date, required: true },
  positions: [String],
  candidates: [ObjectId],
  match: { type: Schema.Types.ObjectId, ref: "match" },
  player_limit: { type: Number },
});

export default model<IPlayerAnnouncement>(
  "player_announcement",
  playerAnnouncementSchema
);
