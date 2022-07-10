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

//run this before npm start
//export GOOGLE_APPLICATION_CREDENTIALS="/Users/serhatmerak/Documents/GitHub/BilFoot2/BilFoot_backend/firebase/serviceAccountKey.json"

// const __filename = fileURLToPath(import.meta.url);
// const __dirname = dirname(__filename);

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

initializeApp();

console.log(getApp().name); // '[DEFAULT]'

const serhat = 12;

// test post
app.post("/test", (req, res, next) => {
  console.log("test is successful");
  console.log(req.body);
  /*
  const message = {
    token:
      "dByrTNgARFyJkwVJ2ByMvb:APA91bE5bSuM4X_NUa6TYH_tnGRpYnLQlRVddkjH696HUCZDONon67U97N_f8c8dJ0pzYDTnQ_kDYnn1TVpOkdXtSAT7sMVNUo42tOM8_J9Bwlr0srioqX5ThZKutU3472ncQEfKViyC",
    data: {
      type: "warning",
      content: "A new weather warning has been created!",
    },
    notification: {
      title: "Sparky says hello!",
    },
    android: {
      notification: {
        imageUrl:
          "https://cdnuploads.aa.com.tr/uploads/Contents/2021/05/03/thumbs_b_c_2caf30695b13a2f55230e87eb172875a.jpg",
      },
    },
    apns: {
      payload: {
        aps: {
          "mutable-content": 1,
        },
      },
      fcm_options: {
        image:
          "https://cdnuploads.aa.com.tr/uploads/Contents/2021/05/03/thumbs_b_c_2caf30695b13a2f55230e87eb172875a.jpg",
      },
    },
    webpush: {
      headers: {
        image:
          "https://cdnuploads.aa.com.tr/uploads/Contents/2021/05/03/thumbs_b_c_2caf30695b13a2f55230e87eb172875a.jpg",
      },
    },
  };
*/

  const message = {
    topic: "general",
    data: {
      type: "warning",
      content: "A new weather warning has been created!",
    },
    notification: {
      title: "Glonera premium'u denediniz mi?",
      body: "Yeni gelen avantaj paketleriyle artık Glonera Premium hem daha hesaplı hem de daha zengin.",
      image:
        "https://toppng.com/uploads/preview/svg-free-download-onlinewebfonts-diamond-icon-transparent-11563649689plxqiody13.png",
    },
  };
  admin
    .messaging()
    .send(message)
    .then((response) => {
      console.log("Successfully sent message:", response);
    })
    .catch((error) => {
      console.log("Error sending message:", error);
    });

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
