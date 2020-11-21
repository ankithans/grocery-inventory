import uploadToBucket from "../services/cloud_storage";
import { Request, Response } from "express";
import jwt from "jsonwebtoken";
import User from "../models/user";
import googleVision from "../services/cloud_vision";
import mongoose from "mongoose";
var id = mongoose.Types.ObjectId();

export const uploadImage = async (
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

  const file = req.file;
  if (!file) {
    return res.status(400).json({
      success: false,
      error: "no file selected",
    });
  }
  const url = await uploadToBucket(file.path);
  var tags: any = await googleVision(file.path);
  const labels = tags.labelAnnotations;
  var displayTags: any = [];
  if (labels != null)
    labels.forEach((label: { description: any }) =>
      displayTags.push(label.description)
    );
  // console.log(displayTags);

  const availableGrocery: any = [];
  const availableTags: any = [];

  user.groceries.forEach((grocery) => availableGrocery.push(grocery));
  user.groceries.forEach((grocery) => availableTags.push(grocery.tag));

  // console.log(availableGrocery);

  var isInInventory = false;
  var index = 0;
  var t;

  for (var i = 0; i < displayTags.length; i++) {
    if (
      availableTags.find(function (element: any) {
        return displayTags[i] == element;
      })
    ) {
      isInInventory = true;
      index = i;
      t = displayTags[i];
      console.log(t);
      break;
    } else {
      isInInventory = false;
    }
    // console.log(isInInventory);
  }
  // if (availableGrocery[index] != undefined)
  for (var i = 0; i < availableGrocery.length; i++) {
    if (availableGrocery[i].tag == t) {
      index = i;
    }
  }
  console.log(index);

  // console.log(availableGrocery[index].finished);

  if (!isInInventory) {
    return res.json({
      success: true,
      url: url,
      tags: displayTags,
    });
  }
  if (availableGrocery[index] != undefined)
    if (availableGrocery[index].finished == true) {
      return res.json({
        success: true,
        url: url,
        tags: displayTags,
      });
    }

  return res.status(409).json({
    success: false,
    message: "already in you inventory",
  });
};

export const selectTags = async (req: Request, res: Response): Promise<any> => {
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

  const { tag, url } = req.body;

  const groceryObject: any = {
    _id: id,
    image: url,
    finished: false,
    tag: tag,
  };
  user.groceries.push(groceryObject);

  console.log(user.groceries);

  await user.save();

  return res.json({
    success: true,
    message: "item saved successfully",
  });
};
