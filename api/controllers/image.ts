// import listBuckets from "../services/cloud_storage";
import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import googleVision from "../services/cloud_vision";

export const uploadImage = async (
  req: Request,
  res: Response
): Promise<any> => {
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

    // decoded.user
  } catch (err) {
    res.status(401).json({
      success: false,
      msg: "Token is not valid",
    });
  }

  // listBuckets();

  // code
  const file = req.file;
  if (!file) {
    return res.status(400).json({
      success: false,
      error: "no file selected",
    });
  }
  var result: any = await googleVision(file.path);

  return res.json({
    success: true,
    result: result,
    file: file,
  });
};
