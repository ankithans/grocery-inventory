import mongoose, { Schema, Document } from "mongoose";

export interface IUser extends Document {
  name: string;
  groceries: {};
}

const UserSchema: Schema = new Schema({
  email: {
    type: String,
    required: true,
  },
  groceries: {},
});

export default mongoose.model<IUser>("User", UserSchema);
