import prisma from "../db";
import bcrypt from "bcrypt";

export async function registerUser({
  username,
  email,
  password,
  accountNumber,
}: {
  username: string;
  email: string;
  password: string;
  accountNumber: number;
}) {
  try {
    if (
      !username?.trim() ||
      !email?.trim() ||
      !password?.trim() ||
      !accountNumber
    ) {
      return { status: "error", message: "All fields are required" };
    }

    const existingUser = await prisma.user.findFirst({
      where: {
        OR: [{ username }, { email }, { accountNum: accountNumber }],
      },
    });
    if (existingUser) {
      return { status: "error", message: "User already exists" };
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = await prisma.user.create({
      data: {
        username,
        email,
        password: hashedPassword,
        accountNum: accountNumber,
      },
    });

    return {
      status: "success",
      message: "User registered successfully",
      data: newUser,
    };
  } catch (error) {
    return { status: "error", message: "Something went wrong" };
  }
}

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
