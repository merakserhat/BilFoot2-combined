import { Types, Schema, model } from "mongoose";

interface IPlayerAnnouncement {
  announcer: Types.ObjectId;
  date: Date;
  positions: string[];
  for_team: boolean;
  team: Types.ObjectId;
}

const playerAnnouncementSchema = new Schema<IPlayerAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true, ref: "player" },
  date: { type: Date, required: true },
  positions: [String],
  for_team: { type: Boolean, default: false },
  team: { type: Schema.Types.ObjectId, ref: "team" },
});

export default model<IPlayerAnnouncement>(
  "player_announcement",
  playerAnnouncementSchema
);
