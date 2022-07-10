import { Types, Schema, model } from "mongoose";

interface IMatchAnnouncement {
  announcer: Types.ObjectId;
  date: Date;
}

const matchAnnouncementSchema = new Schema<IMatchAnnouncement>({
  announcer: { type: Schema.Types.ObjectId, required: true },
  date: { type: Date, required: true },
});

export default model<IMatchAnnouncement>(
  "match_announcement",
  matchAnnouncementSchema
);
