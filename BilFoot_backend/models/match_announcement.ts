import { Types, Schema, model } from "mongoose";

interface IMatchAnnouncement {
  announcer: Types.ObjectId;
  date: Date;
  isDeleted?: boolean;
}

const matchAnnouncementSchema = new Schema<IMatchAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true },
  date: { type: Date, required: true },
  isDeleted: { type: Boolean, default: false },
});

export default model<IMatchAnnouncement>(
  "match_announcement",
  matchAnnouncementSchema
);
