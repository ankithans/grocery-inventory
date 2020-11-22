import { Router } from "express";
import multer from "multer";
import { selectTags, uploadImage } from "../controllers/image";
// import { check } from "express-validator";

const router: Router = Router();

var storage = multer.diskStorage({
  destination: function (_req, _file, cb) {
    cb(null, "./uploads");
  },
  filename: function (_req, file, cb) {
    cb(null, file.originalname);
  },
});
var upload = multer({ storage: storage, limits: { fileSize: 10000000000 } });

// @route       POST /api/v1/image
// @dsc         check the image
// @access      Private
router.post("/", upload.single("file"), uploadImage);

// @route       POST /api/v1/image/select
// @dsc         upload the image
// @access      Private
router.post("/selectTags", selectTags);

export default router;
