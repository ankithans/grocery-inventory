import express, { Request, Response } from "express";
import dotenv from "dotenv";
import bodyParser from "body-parser";
import connectDB from "./services/database";

import userRoute from "./routes/user";
import imageRoute from "./routes/image";
import groceryRoute from "./routes/grocery";

const main = async () => {
  dotenv.config();
  const app = express();

  // connectDB
  connectDB();

  // Init Middleware
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: true }));

  // Define routes
  app.get("/", (_req: Request, res: Response) => {
    return res.json({
      message: "Server is up and running",
    });
  });

  app.use("/api/v1/auth", userRoute);
  app.use("/api/v1/image", imageRoute);
  app.use("/api/v1/grocery", groceryRoute);

  // port
  const PORT = process.env.PORT || 5000;

  app.listen(PORT, () => {
    console.log(`server started on http://localhost:${PORT}`);
  });
};

main().catch((err) => {
  console.log(err);
  process.exit(1);
});
