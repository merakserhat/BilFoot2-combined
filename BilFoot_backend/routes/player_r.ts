import express from "express";
import {
  answerToNotification,
  getHomeData,
  getPlayerModel,
  getPlayerNotifications,
  searchPlayers,
} from "../controllers/player_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.get("/get-home-data", isAuth, getHomeData);
router.get("/search-players", searchPlayers);
router.get("/get-player-notifications", isAuth, getPlayerNotifications);
router.get("/get-player-model", getPlayerModel);
router.post("/answer-to-notification", isAuth, answerToNotification);

export default router;
