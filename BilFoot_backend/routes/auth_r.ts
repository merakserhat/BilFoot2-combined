import express from "express";
import { registerUser } from "../controllers/auth_c";

const router = express.Router();

router.post("/register-user", registerUser);

export default router;
