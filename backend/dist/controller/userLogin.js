"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userLogin = userLogin;
function userLogin(c) {
    console.log("endpoint hit");
    return c.json({ message: "User login endpoint" });
}
