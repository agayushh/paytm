import { Hono } from "hono";
import userRoute from "./routes/user";
import { serve } from "@hono/node-server";

const app = new Hono();


app.route("/api/users", userRoute)


serve({
  fetch: app.fetch,
  port: 3000,
})