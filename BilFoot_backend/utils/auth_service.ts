import { NextFunction, Request, Response } from "express";
import admin from "firebase-admin";

export const isAuth = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const bearerToken = req.headers.authorization;

  if (typeof bearerToken === "string" && bearerToken.includes("Bearer")) {
    const saltToken = bearerToken.replace("Bearer ", "");

    admin
      .auth()
      .verifyIdToken(saltToken)
      .then((value) => {
        //Successfully signed in
        //TODO send user or email
        console.log(value);
      })
      .catch((error) => console.error(error));
  } else {
    //TODO error
    res.status(401).json({ error: "Token not found" });
  }
};
