import mongoose from "mongoose";
import { lowercase, maxLength, minLength } from "zod";

const userSchema = new mongoose.Schema(
  {
    username: {
      typeof: String,
      require: true,
      unique: true,
      maxLength: 30,
      minLength: 3,
      trim: true,
      lowercase: true,
    },
    lastName: {
      typeof: String,
      required: true,
      trim: true,
      maxLength: 50,
    },
    firstName: {
      typeof: String,
      required: true,
      trim: true,
      maxLength: 50,
    },
    password: {
      typeof: String,
      required: true,
      minLength: 6,
    },
  },
  { timestamps: true }
);

export const User = mongoose.Model("User", userSchema);
