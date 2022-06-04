import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const opponentAnnouncementSchema = new mongoose.Schema({
  announcer: { type: ObjectId, required: true },
  date: { type: Date, required: true },
  team: { type: ObjectId, required: true },
});

export default mongoose.model(
  "opponent_announcement",
  opponentAnnouncementSchema
);
