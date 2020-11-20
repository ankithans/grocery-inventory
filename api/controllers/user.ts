import { Request, Response } from "express";
import { validationResult } from "express-validator";
import jwt from "jsonwebtoken";

import User from "../models/user";

export const authUser = async (req: Request, res: Response): Promise<any> => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      errors: errors.array(),
    });
  }

  const { email } = req.body;

  try {
    let user = await User.findOne({ email });
    if (!user) {
      user = new User({
        email,
      });
      await user.save();

      const payload = {
        user: {
          id: user.id,
        },
      };

      const secret: any = process.env.JWT_SECRET;

      jwt.sign(
        payload,
        secret.toString(),
        {
          expiresIn: 360000000,
        },
        (err, token) => {
          if (err) throw err;
          res.status(200).json({
            success: true,
            token: token,
            user: user,
          });
        }
      );
    } else {
      const payload = {
        user: {
          id: user.id,
        },
      };

      const secret: any = process.env.JWT_SECRET;

      jwt.sign(
        payload,
        secret.toString(),
        {
          expiresIn: 360000000,
        },
        (err, token) => {
          if (err) throw err;
          res.status(200).json({
            success: true,
            token: token,
            user: user,
          });
        }
      );
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      error: "Internal Server Error",
    });
  }
};
