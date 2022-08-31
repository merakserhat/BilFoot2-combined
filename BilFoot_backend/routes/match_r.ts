import express from "express";
import {
  createMatch,
  getMatches,
  getMatchInvitation,
  giveAuth,
  inviteToMatch,
  kickPlayer,
  quitMatch,
} from "../controllers/match_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-match", isAuth, createMatch);
router.post("/invite-to-match", isAuth, inviteToMatch);
router.get("/get-match-invitation", isAuth, getMatchInvitation);
router.post("/give-auth", isAuth, giveAuth);
router.post("/kick-player", isAuth, kickPlayer);
router.get("/get-matches", getMatches);
router.post("/quit-match", isAuth, quitMatch);

export default router;
