import prisma from "../db";
import bcrypt from "bcrypt";

export async function userLogin({
  username,
  password,
}: {
  username: string;
  password: string;
}) {
  try {
    //check if the username and password is correct

    if (!username?.trim() || !password?.trim()) {
      return { status: "error", message: "Username and password is required" };
    }

    const user = await prisma.user.findFirst({
      where: {
        username,
      },
    });

    if (!user) {
      return { status: "error", message: "Invalid username" };
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return { status: "error", message: "Invalid password" };
    }

    return { status: "success", message: "Login successful", data: user };
  } catch (error) {
    return { status: "error", message: "Something went wrong" };
  }
}
