import express, { Request, Response } from "express";
import cors from "cors";
import dotenv from "dotenv";
import helmet from "helmet";
import bodyParser from "body-parser";
import connectDB from "./services/database";

const main = async () => {
  dotenv.config();
  const app = express();

  // Using helmet and CORS to secure the application
  if (process.env.NODE_ENV === "production") app.use(helmet());
  app.use(cors());

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

  // port
  const PORT = process.env.PORT || 5000;

  app.listen(4000, () => {
    console.log(`server started on http://localhost:${PORT}`);
  });
};

main().catch((err) => {
  console.log(err);
  process.exit(1);
});
