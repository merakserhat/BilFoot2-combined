import express from "express";
import { createAnnouncement } from "../controllers/announcement_c";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.post("/create-announcement", isAuth, createAnnouncement);

export default router;
