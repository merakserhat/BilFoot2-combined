import { Types, Schema, model } from "mongoose";

interface ITeam {
  name: string;
  short_name: string;
  main_color: string;
  accent_color: string;
  creator: Types.ObjectId;
  captain: Types.ObjectId;
  players: Types.ObjectId[];
}

const teamSchema = new Schema<ITeam>({
  name: { type: String, required: true },
  short_name: { type: String, required: true },
  main_color: { type: String, required: true },
  accent_color: { type: String, required: true },
  creator: Schema.Types.ObjectId,
  captain: Schema.Types.ObjectId,
  players: [Schema.Types.ObjectId],
});

export default model<ITeam>("team", teamSchema);
