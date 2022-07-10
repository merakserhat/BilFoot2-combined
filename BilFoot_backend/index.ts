import express from "express";
//import errorHandler from "./utils/error-handler.js";
import mongoose from "mongoose";
import path from "path";
import { fileURLToPath } from "url";
import { dirname } from "path";
// #region route imports
import authRoute from "./routes/auth_r";
import announcementRoute from "./routes/announcement_r";
import chatRoute from "./routes/chat_r";
import playerRoute from "./routes/player_r";
import teamRoute from "./routes/team_r";
import { getApp, initializeApp } from "firebase-admin/app";
import admin from "firebase-admin";

require("dotenv").config();

//run this before npm start
//export GOOGLE_APPLICATION_CREDENTIALS="/Users/serhatmerak/Documents/GitHub/BilFoot2/BilFoot_backend/firebase/serviceAccountKey.json"

// const __filename = fileURLToPath(import.meta.url);
// const __dirname = dirname(__filename);

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

initializeApp();

// #region route registers
app.use("/auth", authRoute);
app.use("/user", announcementRoute);
app.use("/product", chatRoute);
app.use("/page", playerRoute);
app.use("/test", teamRoute);
// #endregion<

// app.listen(8080);

console.log(process.env.MONGODB_URI);

mongoose
  .connect(process.env.MONGODB_URI || "error")
  .then((result) => {
    // console.log(result);
    console.log("server is active");
  })
  .catch((err) => {
    console.log("db error");
    console.log(err);
  });
