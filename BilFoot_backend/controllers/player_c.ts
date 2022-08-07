import { Request, Response, NextFunction } from "express";
import mongoose from "mongoose";
import Notification, { INotification } from "../models/notification";
import Player, { IPlayer } from "../models/player";
import Team from "../models/team";

interface IHomeDate {
  player: IPlayer;
}

type NotificationArray = (mongoose.Document<unknown, any, INotification> &
  INotification & {
    _id: mongoose.Types.ObjectId | undefined;
  })[];

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

export const getPlayerNotifications = async (
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

  const notifications = await Notification.find({ to: player._id })
    .populate("team_model player_model")
    .limit(10); //TODO: match_model

  if (!notifications) {
    return res.status(400).json({ error: "Notifications not found" });
  }

  return res.status(200).json({ notifications });
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

export const getPlayerModel = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { id } = req.query;

  if (typeof id !== "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const player_model = await Player.findById(new mongoose.Types.ObjectId(id));

  if (player_model == null) {
    return res.status(400).json({ error: "Player Model not found" });
  }

  return res.status(200).json({ player_model });
};
