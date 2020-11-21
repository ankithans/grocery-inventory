import { Router } from "express";
import { check } from "express-validator";
import { authUser } from "../controllers/user";

const router: Router = Router();

// @route       POST /api/v1/auth
// @dsc         logins a user
// @access      Public
router.post(
  "/",
  [check("email", "Please enter a valid email").isEmail()],
  authUser
);

export default router;
