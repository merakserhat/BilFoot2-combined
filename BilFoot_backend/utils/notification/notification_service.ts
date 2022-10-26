/*
// test post
app.post("/test", (req, res, next) => {
  console.log("test is successful");
  console.log(req.body);

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

*/

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
