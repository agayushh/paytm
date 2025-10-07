import { Hono } from "hono";
import prisma from "../db";
import { userLogin } from "../controller/userLogin";


const userRoute = new Hono();

userRoute.get("/login", userLogin)


export default userRoute;