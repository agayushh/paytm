import app from "./app.js";
import { connectToDb } from "./db.js";

connectToDb()
  .then(() => {
    app.on("Error", (err) => {
      console.log("Error in server", err);
    });
    app.listen(process.env.PORT || 3000, () => {
      console.log(`server is listening on port ${process.env.PORT}`);
    });
  })
  .catch((error) => {
    console.log("Error in connecting with database due to", error);
  });
