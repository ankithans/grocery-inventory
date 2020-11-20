// // multer testing
// var storage = multer.diskStorage({
//   destination: function (_req, _file, cb) {
//     cb(null, "./uploads");
//   },
//   filename: function (_req, file, cb) {
//     cb(null, file.filename + "-" + Date.now());
//   },
// });
// var upload = multer({ storage: storage, limits: { fileSize: 10000000000 } });

// app.post("/upload", upload.single("file"), (req: Request, res: Response) => {
//   // data.append("file", file);
//   const file = req.file;
//   if (!file) {
//     return res.status(400).json({
//       error: "no file selected!",
//     });
//   }
//   return res.json({ file });
// });
