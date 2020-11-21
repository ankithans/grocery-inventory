import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  name: string;
  groceries: [
    {
      image: string;
      finished: boolean;
      tags: [];
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
      tags: [],
    },
  ],
});

export default mongoose.model<IUser>("User", UserSchema);
