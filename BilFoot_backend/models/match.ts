import { Types, Schema, model } from "mongoose";

export interface IMatch {
  _id: Types.ObjectId;
  date: Date;
  hour: string;
  pitch: string;
  is_pitch_approved: boolean;
  creator: Types.ObjectId;
  players: Types.ObjectId[];
  auth_players: Types.ObjectId[];
  show_on_table: boolean;
  people_limit: number;
  isDeleted?: boolean;
}

const matchSchema = new Schema<IMatch>({
  date: { type: Date, required: true },
  hour: { type: String, required: true },
  pitch: { type: String, required: true },
  is_pitch_approved: { type: Boolean, required: true },
  creator: { type: Schema.Types.ObjectId, ref: "player" },
  auth_players: [{ type: Schema.Types.ObjectId, ref: "player" }],
  players: [{ type: Schema.Types.ObjectId, ref: "player" }],
  show_on_table: { type: Boolean, required: true },
  people_limit: { type: Number, required: true },
  isDeleted: { type: Boolean, default: false },
});

export default model<IMatch>("match", matchSchema);
