import { ObjectId } from "mongodb";
import { Types, Schema, model } from "mongoose";

interface IPlayerAnnouncement {
  announcer: Types.ObjectId;
  created_at: Date;
  positions: string[];
  match: Types.ObjectId;
  candidates: Types.ObjectId[];
  accepted_players: Types.ObjectId[];
  refused_players: Types.ObjectId[];
  player_limit: Number;
  isDeleted?: boolean;
}

const playerAnnouncementSchema = new Schema<IPlayerAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true, ref: "player" },
  created_at: { type: Date, required: true },
  positions: [String],
  candidates: [ObjectId],
  accepted_players: [ObjectId],
  refused_players: [ObjectId],
  match: { type: Schema.Types.ObjectId, ref: "match" },
  player_limit: { type: Number },
  isDeleted: { type: Boolean, default: false },
});

export default model<IPlayerAnnouncement>(
  "player_announcement",
  playerAnnouncementSchema
);
