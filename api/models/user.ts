import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  name: string;
  groceries: [
    {
      image: string;
      finished: boolean;
      tag: string;
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
      image: String,
      finished: Boolean,
      tag: String,
    },
  ],
});

export default mongoose.model<IUser>("User", UserSchema);
