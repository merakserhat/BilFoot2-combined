import { Types, Schema, model, Document } from "mongoose";

export interface IPlayer {
  _id: Types.ObjectId;
  firebase_id: string;
  email: string;
  full_name: string;
  preferred_positions: string[];
  special_skills: string[];
  dominant_feet: string[];
  average_point: number;
  pointer_num: number;
  image_url?: string;
  teams: Types.ObjectId[];
}

const playerSchema = new Schema<IPlayer>({
  firebase_id: { type: String, required: true },
  email: { type: String, required: true },
  full_name: { type: String, required: true },
  preferred_positions: [String],
  dominant_feet: [String],
  special_skills: [String],
  average_point: { type: Number, default: 0 },
  pointer_num: { type: Number, default: 0 },
  image_url: String,
  teams: [{ type: Schema.Types.ObjectId, ref: "team" }],
});

export default model<IPlayer>("player", playerSchema);
