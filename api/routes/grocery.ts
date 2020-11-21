import {
  getGroceries,
  markAsFinish,
  updateQuantity,
} from "../controllers/grocery";
import { Router } from "express";

const router: Router = Router();

// @route       GET /api/v1/grocery/get
// @dsc         get all groceries of user
// @access      Private
router.get("/get", getGroceries);

// @route       GET /api/v1/grocery/finish
// @dsc         mark item as finished
// @access      Private
router.post("/finish", markAsFinish);

// @route       GET /api/v1/grocery/quantity
// @dsc         update quantity
// @access      Private
router.post("/quantity", updateQuantity);

export default router;
