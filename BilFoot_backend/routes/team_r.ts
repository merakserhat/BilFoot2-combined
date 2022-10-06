import express from "express";
import {
  createTeam,
  editTeam,
  getPlayerTeams,
  getTeamInvitation,
  getTeamModel,
  getTeamsWithIds,
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
router.post("/make-captain", isAuth, makeCaptain);
router.post("/kick-player", isAuth, kickPlayer);
router.get("/get-team-model", getTeamModel);
router.post("/get-teams-with-ids", getTeamsWithIds);
router.post("/get-player-teams", isAuth, getPlayerTeams);
router.post("/quit-team", isAuth, quitTeam);
router.post("/edit-team", isAuth, editTeam);

export default router;
