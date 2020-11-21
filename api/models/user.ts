import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  name: string;
  groceries: [
    {
      image: string;
      finished: boolean;
      tag: string;
      _id: mongoose.Types.ObjectId;
    }
  ];
}

const UserSchema: Schema = new Schema({
  email: {
    type: String,
    required: true,
  },
  groceries: [
    {
      _id: mongoose.Types.ObjectId,
      image: String,
      finished: Boolean,
      tag: String,
    },
  ],
});

export default mongoose.model<IUser>("User", UserSchema);
