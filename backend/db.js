import mongoose from "mongoose";

export const connectToDb = async () => {
  try {
    const connectInstance = await mongoose.connect(
      `${process.env.MONGODB_URL}`/paytm
    );
    console.log(
      "Connection with mongo database done",
      connectInstance.connection.host
    );
  } catch (error) {
    console.log("Couldnt connect Database due to", error);
  }
};
