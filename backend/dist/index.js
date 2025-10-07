"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const hono_1 = require("hono");
const user_1 = __importDefault(require("./routes/user"));
const node_server_1 = require("@hono/node-server");
const app = new hono_1.Hono();
app.route("/api/users", user_1.default);
(0, node_server_1.serve)({
    fetch: app.fetch,
    port: 3000,
});
