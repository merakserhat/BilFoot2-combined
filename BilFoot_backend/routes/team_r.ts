import express from "express";
import {
  createTeam,
  getTeamModel,
  inviteToTeam,
  kickPlayer,
  makeCaptain,
} from "../controllers/team_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-team", isAuth, createTeam);
router.get("/invite-to-team", isAuth, inviteToTeam);
router.get("/get-team-invitation", isAuth, createTeam);
router.get("/make-captain", isAuth, makeCaptain);
router.get("/kick-player", isAuth, kickPlayer);
router.get("/get-team-model", getTeamModel);

export default router;
