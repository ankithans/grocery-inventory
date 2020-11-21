import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import User from "../models/user";

export const getGroceries = async (
  req: Request,
  res: Response
): Promise<any> => {
  let userId;
  // auth
  const token = req.header("x-auth-token");
  if (!token) {
    return res.status(401).json({
      success: false,
      msg: "No token, authorization denied",
    });
  }

  try {
    const secret: any = process.env.JWT_SECRET;
    const decoded: any = jwt.verify(token, secret.toString());
    console.log(decoded.user);
    userId = decoded.user.id;

    // decoded.user
  } catch (err) {
    res.status(401).json({
      success: false,
      msg: "Token is not valid",
    });
  }

  // code
  let user = await User.findById(userId);
  if (!user) {
    return res.status(404).json({
      success: false,
      error: "no user found",
    });
  }

  const groceries = user.groceries;
  return res.json({
    success: true,
    grocery: groceries,
  });
};

export const markAsFinish = async (
  req: Request,
  res: Response
): Promise<any> => {
  let userId;
  // auth
  const token = req.header("x-auth-token");
  if (!token) {
    return res.status(401).json({
      success: false,
      msg: "No token, authorization denied",
    });
  }

  try {
    const secret: any = process.env.JWT_SECRET;
    const decoded: any = jwt.verify(token, secret.toString());
    // console.log(decoded.user);
    userId = decoded.user.id;

    // decoded.user
  } catch (err) {
    res.status(401).json({
      success: false,
      msg: "Token is not valid",
    });
  }

  // code
  let user = await User.findById(userId);
  if (!user) {
    return res.status(404).json({
      success: false,
      error: "no user found",
    });
  }

  const { gid } = req.body;

  // console.log(groceries[0]._id);

  for (var i = 0; i < user.groceries.length; i++) {
    if (user.groceries[i]._id.toString() == gid) {
      console.log(user.groceries[i]);
      user.groceries[i].finished = !user.groceries[i].finished;
      break;
    }
  }

  await user.save();
  return res.json({
    success: true,
    message: `finished set to opposite`,
  });
};
