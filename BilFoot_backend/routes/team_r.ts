import express from "express";
import {
  createTeam,
  getTeamInvitation,
  getTeamModel,
  inviteToTeam,
  kickPlayer,
  makeCaptain,
  quitTeam,
} from "../controllers/team_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-team", isAuth, createTeam);
router.post("/invite-to-team", isAuth, inviteToTeam);
router.get("/get-team-invitation", isAuth, getTeamInvitation);
router.get("/make-captain", isAuth, makeCaptain);
router.get("/kick-player", isAuth, kickPlayer);
router.get("/get-team-model", getTeamModel);
router.post("/quit-team", isAuth, quitTeam);

export default router;
