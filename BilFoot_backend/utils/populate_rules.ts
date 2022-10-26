import { PopulateOptions } from "mongoose";

export const notificationPopulateRule: (PopulateOptions | string)[] = [
  { path: "player_model from" },
  {
    path: "team_model",
    populate: { path: "players" },
  },
  {
    path: "match_model",
    populate: { path: "players creator" },
  },
];

export const teamPopulateRule: (PopulateOptions | string)[] = ["players"];

export const matchPopulateRule: (PopulateOptions | string)[] = [
  "players",
  "creator",
];

export const playerAnnouncementPopulateRule: (PopulateOptions | string)[] = [
  { path: "match", populate: "creator players" },
  "announcer",
];

export const opponentAnnouncementPopulateRule: (PopulateOptions | string)[] = [
  "announcer",
  { path: "match", populate: "creator players" },
  { path: "team", populate: "players" },
];
