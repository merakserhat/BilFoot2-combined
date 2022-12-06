import express from "express";
import {
  answerToNotification,
  getHomeData,
  getPlayerModel,
  getPlayerNotifications,
  getPlayerPhoneNumber,
  searchPlayers,
  updatePlayerPhoneNumber,
} from "../controllers/player_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.get("/get-home-data", isAuth, getHomeData);
router.get("/search-players", searchPlayers);
router.get("/get-player-notifications", isAuth, getPlayerNotifications);
router.get("/get-player-model", getPlayerModel);
router.post("/answer-to-notification", isAuth, answerToNotification);
router.post("/update-player-phone-number", isAuth, updatePlayerPhoneNumber);
router.get("/get-player-phone-number", isAuth, getPlayerPhoneNumber);

export default router;
