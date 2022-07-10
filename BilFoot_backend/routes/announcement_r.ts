import express from "express";

const router = express.Router();

export default router;

let serhat;

serhat = {
  se: 12,
  // as: any : null;
};

const add = (a: number, b: number): number => {
  return a + b;
};

add(12, 12);
