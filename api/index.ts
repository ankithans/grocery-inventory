import express, { Request, Response } from "express";
import dotenv from "dotenv";
import bodyParser from "body-parser";
import connectDB from "./services/database";

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
    console.log("server up");

    return res.json({
      message: "Server is up and running",
    });
  });

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
