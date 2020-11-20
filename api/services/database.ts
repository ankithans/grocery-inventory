import mongoose from "mongoose";

export default () => {
  const connect = async () => {
    try {
      await mongoose.connect(`${process.env.MONGO_URI}`, {
        useNewUrlParser: true,
        useCreateIndex: true,
        useFindAndModify: false,
        useUnifiedTopology: true,
      });

      console.log("MongoDB connected...");
    } catch (err) {
      console.error(err.message);
      process.exit(1);
    }
  };
  connect();
};
