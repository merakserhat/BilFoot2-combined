import { Types, Schema, model } from "mongoose";

export interface ITeam {
  _id: Types.ObjectId;
  name: string;
  short_name: string;
  main_color: string;
  accent_color: string;
  creator: Types.ObjectId;
  captain: Types.ObjectId;
  players: Types.ObjectId[];
  isDeleted?: boolean;
}

const teamSchema = new Schema<ITeam>({
  name: { type: String, required: true },
  short_name: { type: String, required: true },
  main_color: { type: String, required: true },
  accent_color: { type: String, required: true },
  creator: { type: Schema.Types.ObjectId, ref: "player" },
  captain: { type: Schema.Types.ObjectId, ref: "player" },
  players: [{ type: Schema.Types.ObjectId, ref: "player" }],
  isDeleted: { type: Boolean, default: false },
});

export default model<ITeam>("team", teamSchema);
