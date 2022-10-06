import express from "express";
import {
  createAnnouncement,
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

export default router;
