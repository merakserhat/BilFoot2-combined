import { Types, Schema, model } from "mongoose";

interface IPlayer {
  email: string;
  full_name: string;
  preferred_positions: string[];
  special_skills: string[];
  average_point: number;
  pointer_num: number;
  image_url?: string;
  teams: Types.ObjectId[];
}

const playerSchema = new Schema<IPlayer>({
  email: { type: String, required: true },
  full_name: { type: String, required: true },
  preferred_positions: [String],
  special_skills: [String],
  average_point: { type: Number, default: 0 },
  pointer_num: { type: Number, default: 0 },
  image_url: String,
  teams: [Schema.Types.ObjectId],
});

export default model<IPlayer>("player", playerSchema);
