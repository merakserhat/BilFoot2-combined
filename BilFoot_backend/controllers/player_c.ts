import { Request, Response, NextFunction } from "express";
import Player, { IPlayer } from "../models/player";

interface IHomeDate {
  player: IPlayer;
}

export const getHomeData = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const player: IPlayer | null = await Player.findOne({
    email: (req as any).user_email,
  });

  if (player == null) {
    return res.status(401).json({ error: "User not found" });
  }

  const homeData: IHomeDate = {
    player,
  };

  return res.status(200).json(homeData);
};

export const searchPlayers = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { value } = req.query;
  console.log(req.query);

  const players: IPlayer[] = await Player.find({
    full_name: new RegExp(value as string, "i"),
  });

  return res.status(200).json({ players });
};
