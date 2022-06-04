import express from "express";
//import errorHandler from "./utils/error-handler.js";
import mongoose from "mongoose";
import path from "path";
import { fileURLToPath } from "url";
import { dirname } from "path";
// #region route imports
import authRoute from "./routes/auth_r.js";
import announcementRoute from "./routes/announcement_r.js";
import chatRoute from "./routes/chat_r.js";
import playerRoute from "./routes/player_r.js";
import teamRoute from "./routes/team_r.js";

// #endregion

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// test post
app.post("/test", (req, res, next) => {
  console.log("test is successful");
  console.log(req.body);
  res.status(200).json({ message: "Successfully aldın mesajı!" });
});

// #region route registers
app.use("/auth", authRoute);
app.use("/user", announcementRoute);
app.use("/product", chatRoute);
app.use("/page", playerRoute);
app.use("/test", teamRoute);
// #endregion

app.listen(8080);
/*
mongoose
    .connect(process.env.MONGODB_URI)
    .then((result) => {
        // console.log(result);
        console.log("server is active");
    })
    .catch((err) => {
        console.log("db error");
        // console.log(err);
    });
    */
