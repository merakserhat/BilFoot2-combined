import e, { Request, Response, NextFunction } from "express";
import Player from "../models/player";
import { getNameFromMail } from "../utils/util_functions";

/**
 *
 * @body email
 * @body preferred_positions
 * @body special_skills
 */
export const registerUser = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const {
    email,
    preferred_positions,
    special_skills,
    firebase_id,
    dominant_feet,
  } = req.body;

  //serhat.merak@ug.bilkent.edu.tr ->  serhat merak
  const full_name = getNameFromMail(email);

  const player = new Player({
    email,
    full_name,
    preferred_positions,
    special_skills,
    firebase_id,
    dominant_feet,
  });

  await player.save();

  return res.status(201).json({ player });
};
