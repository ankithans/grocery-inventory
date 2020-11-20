import { Router } from "express";
import { check } from "express-validator";

const router: Router = Router();

// @route       POST /api/v1/auth
// @dsc         logins a user
// @access      Public
router.post("/auth", [check("email", "Please enter a valid email").isEmail()]);
