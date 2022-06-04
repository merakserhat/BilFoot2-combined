import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const playerAnnouncementSchema = new mongoose.Schema({
  announcer: { type: ObjectId, required: true },
  date: { type: Date, required: true },
  positions: [String],
  for_team: { type: Boolean, default: false },
  team: ObjectId,
});

export default mongoose.model("player_announcement", playerAnnouncementSchema);
