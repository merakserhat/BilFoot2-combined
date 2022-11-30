import express from "express";
import {
  createMatch,
  editMatch,
  removeMatch,
  getMatches,
  getMatchInvitation,
  giveAuth,
  inviteToMatch,
  kickPlayer,
  quitMatch,
  getPlayerMatches,
} from "../controllers/match_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-match", isAuth, createMatch);
router.post("/edit-match", isAuth, editMatch);
router.post("/remove-match", isAuth, removeMatch);
router.post("/invite-to-match", isAuth, inviteToMatch);
router.get("/get-match-invitation", isAuth, getMatchInvitation);
router.post("/give-auth", isAuth, giveAuth);
router.post("/kick-player", isAuth, kickPlayer);
router.get("/get-matches", getMatches);
router.get("/get-player-matches", isAuth, getPlayerMatches);
router.post("/quit-match", isAuth, quitMatch);

export default router;
