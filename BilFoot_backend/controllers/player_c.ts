import { Request, Response, NextFunction } from "express";
import mongoose from "mongoose";
import Notification, { INotification } from "../models/notification";
import Player, { IPlayer } from "../models/player";
import Team from "../models/team";
import answerNotificationActions from "../utils/notification/notification_answer_actions";
import { notificationPopulateRule } from "../utils/populate_rules";

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
    isDeleted: { $ne: true },
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
  const player = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (player == null) {
    return res.status(401).json({ error: "User not found" });
  }

  const notifications = await Notification.find({
    to: player._id,
    isDeleted: { $ne: true },
  })
    .sort({ $natural: -1 })
    .populate(notificationPopulateRule)
    .limit(10);

  if (!notifications) {
    return res.status(400).json({ error: "Notifications not found" });
  }

  return res.status(200).json({ notifications });
};

export const answerToNotification = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { notification_id, answer } = req.body;

  if (typeof notification_id !== "string" || typeof answer !== "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const answerTypes = ["vending", "accepted", "refused"];

  if (!answerTypes.includes(answer)) {
    return res.status(400).json({ error: "answer type is not valid" });
  }

  const player: IPlayer | null = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (player == null) {
    return res.status(401).json({ error: "User not found" });
  }

  const notification = await Notification.findById(
    new mongoose.Types.ObjectId(notification_id)
  );

  if (notification == null) {
    return res.status(401).json({ error: "notificarion not found" });
  }

  notification.status = answer as any;

  notification.save();

  (answerNotificationActions as any)(notification, answer, player);

  res.status(201).json({ message: "success" });
};

export const searchPlayers = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { value } = req.query;

  const players: IPlayer[] = await Player.find({
    full_name: new RegExp(value as string, "i"),
    isDeleted: { $ne: true },
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

export const updatePlayerPhoneNumber = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { phone_number } = req.body;

  if (typeof phone_number !== "string") {
    return res.status(400).json({ error: "missing parameters" });
  }

  const player = await Player.findOne({
    email: (req as any).user_email,
    isDeleted: { $ne: true },
  });

  if (player === null) {
    return res.status(401).json({ error: "User not found" });
  }

  player.phone_number = phone_number;
  await player.save();

  return res.status(201).json({ message: "success" });
};

export const getPlayerPhoneNumber = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { user_id } = req.query;

  if (typeof user_id !== "string") {
    const player = await Player.findOne({
      email: (req as any).user_email,
      isDeleted: { $ne: true },
    });

    if (!player) {
      return res.status(404).json({ error: "User not found" });
    }

    if (!player.phone_number) {
      return res.status(404).json({ error: "User's phone number found" });
    }

    return res
      .status(200)
      .json({ message: "success", phone_number: player.phone_number });
  } else {
    //TODO ileride be'de de validasyon yapılabilir
    const player = await Player.findById(new mongoose.Types.ObjectId(user_id!));

    if (!player) {
      return res.status(404).json({ error: "User not found" });
    }

    if (!player.phone_number) {
      return res.status(404).json({ error: "User's phone number found" });
    }

    return res
      .status(200)
      .json({ message: "success", phone_number: player.phone_number });
  }
};
