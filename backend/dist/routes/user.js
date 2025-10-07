"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hono_1 = require("hono");
const userLogin_1 = require("../controller/userLogin");
const userRoute = new hono_1.Hono();
userRoute.get("/login", userLogin_1.userLogin);
exports.default = userRoute;
