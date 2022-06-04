import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const playerSchema = new mongoose.Schema({
  email: { type: String, required: true },
  full_name: { type: String, required: true },
  preferred_positions: [String],
  special_skills: [String],
  average_point: { type: Number, default: 0 },
  pointerNum: { type: Number, default: 0 },
  image_url: String,
  teams: [ObjectId],
});

export default mongoose.model("player", playerSchema);
