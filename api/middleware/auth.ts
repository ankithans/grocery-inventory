import jwt from "jsonwebtoken";
import { Request, Response, NextFunction } from "express";
import { IUser } from "../models/user";

export interface IGetUserAuthInfoRequest extends Request {
  user: IUser;
}

export default async (
  req: IGetUserAuthInfoRequest,
  res: Response,
  next: NextFunction
): Promise<any> => {
  console.log("abc");

  // Get the token form header
  const token = req.header("x-auth-token");

  // Check if not token
  if (!token) {
    return res.status(401).json({
      success: false,
      msg: "No token, authorization denied",
    });
  }

  try {
    const secret: any = process.env.JWT_SECRET;
    const decoded: any = jwt.verify(token, secret.toString());

    req.user = decoded.user;
    next();
  } catch (err) {
    res.status(401).json({
      success: false,
      msg: "Token is not valid",
    });
  }
};
