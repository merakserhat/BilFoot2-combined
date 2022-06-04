import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const matchAnnouncementSchema = new mongoose.Schema({
  announcer: { type: ObjectId, required: true },
  date: { type: Date, required: true },
});

export default mongoose.model("match_announcement", matchAnnouncementSchema);
