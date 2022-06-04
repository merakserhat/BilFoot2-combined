import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const teamSchema = new mongoose.Schema({
  name: { type: String, required: true },
  short_name: { type: String, required: true },
  main_color: { type: String, required: true },
  accent_color: { type: String, required: true },
  creator: ObjectId,
  captain: ObjectId,
  players: [ObjectId],
});

export default mongoose.model("team", teamSchema);
