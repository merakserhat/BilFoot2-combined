import express from "express";
import { getHomeData, searchPlayers } from "../controllers/player_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.get("/get-home-data", isAuth, getHomeData);
router.get("/search-players", searchPlayers);

export default router;
