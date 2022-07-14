import { Request, Response, NextFunction } from "express";
import Player, { IPlayer } from "../models/player";
import Team, { ITeam } from "../models/team";

export const createTeam = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { name, short_name, main_color, accent_color } = req.body;

  if (
    name == undefined ||
    short_name == undefined ||
    main_color == undefined ||
    accent_color == undefined
  ) {
    return res.status(400).json({ error: "missing parameters" });
  }

  const user_email = (req as any).user_email;

  if (user_email == undefined) {
    return res.status(500).json({ error: "user_mail is not defined" });
  }

  const user: IPlayer | null = await Player.findOne({ email: user_email });

  if (user == null) {
    return res.status(400).json({ error: "User not found" });
  }

  const team = new Team({
    name,
    short_name,
    main_color,
    accent_color,
    creator: user._id,
    captain: user._id,
    players: [user._id],
  });

  const newTeam: ITeam = await team.save();

  return res.status(201).json({ team: newTeam });
};
