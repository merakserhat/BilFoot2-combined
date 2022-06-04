import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const conversationSchema = new mongoose.Schema({
  members: [ObjectId],
  messages: {
    from_email: { type: String, required: true },
    content: { type: String, required: true },
    date: { type: Date, required: true },
  },
});

export default mongoose.model("conversation", conversationSchema);
