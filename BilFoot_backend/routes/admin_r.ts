import express from "express";
import { isAuth } from "../utils/auth_service";

const router = express.Router();

router.get("/auth-test", isAuth);

export default router;
