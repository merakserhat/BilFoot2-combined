import express from "express";
import { createTeam } from "../controllers/team_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-team", isAuth, createTeam);

export default router;
