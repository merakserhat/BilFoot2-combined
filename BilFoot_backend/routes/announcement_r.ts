import express from "express";
import {
  createAnnouncement,
  getAnnouncements,
  playerAnnouncementJoinRequest,
} from "../controllers/announcement_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-announcement", isAuth, createAnnouncement);
router.post(
  "/player-announcement-join-request",
  isAuth,
  playerAnnouncementJoinRequest
);

router.get("/get-announcements", isAuth, getAnnouncements);

export default router;
