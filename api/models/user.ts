import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  email: string;
  groceries: [
    {
      image: string;
      quantity: Number;
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
      quantity: Number,
      finished: Boolean,
      tag: String,
    },
  ],
});

export default mongoose.model<IUser>("User", UserSchema);
