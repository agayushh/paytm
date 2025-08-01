import { User } from "../models/user.model";
import { asyncHandler } from "../utils/asyncHandler";

const generateAccessAndRefreshToken = async (userid) => {
  try {
    const user = await User.findById(userid);
    const accessToken = user.generateAccessToken();
    const refreshToken = user.generateRefreshToken();
    user.refreshToken = refreshToken;
    await user.save({ validateBeforeSave: false });
    return { accessToken, refreshToken };
  } catch (error) {
    console.log("Cannot generate access and refresh token due to", error);
    throw error;
  }
};

const signinUser = asyncHandler(async (req, res) => {
  //user data fetch from frontend
  //see if the data is not empty
  //see if there is not any multiple entries getting registered
  //if things are fine then store the entry in the database
  //return a token to the user
  //remove the password and refresh token

  const { username, firstname, lastname, password } = req.body;

  if (
    [username, firstname, lastname, password].some(
      (field) => !field || field.trim() === ""
    )
  ) {
    return res.status(409).json({ message: "All fields are required" });
  }

  const existingUser = await User.findOne({ username });
  if (existingUser) {
    return res
      .status(409)
      .json({ message: "User with that username already exists" });
  }

  const newUser = await User.create({
    username,
    firstName: firstname,
    lastName: lastname,
    password,
  });

  const { accessToken, refreshToken } = await generateAccessAndRefreshToken(
    newUser._id
  );

  const createdUser = await User.findById(newUser._id).select(
    "-password -refreshToken"
  );
  if (!createdUser) {
    return res.status(500).json({ message: "user not registered" });
  } else {
    return res.status(201).json({
      message: "User created successfully",
      user: createdUser,
      accessToken,
    });
  }
});

const loginUser = asyncHandler(async (req, res) => {
  //take the entries from the frontend
  //see if it is not empty
  //make db calls to check if it exist in the db or not
  //if it doesnt ask the user to register
  //if it does then compare the password with the hashed one
  //if password and username matches return a token
  //and they can view their site

  const { username, password } = req.body;

  if (username.trim() === "" || password.trim() === "") {
    return res.status(400).json({ message: "Need all credentials to login" });
  }
  const registeredUser = await User.findOne({ username });
  if (!registeredUser) {
    return res
      .status(401)
      .json({ message: `user with the username ${username} doesn't exist` });
  }

  const isPasswordValid = await registeredUser.isPasswordValid(password);
  if (!isPasswordValid) {
    return res.status(401).json({ message: "Invalid password" });
  }

  const { accessToken, refreshToken } = await generateAccessAndRefreshToken(
    registeredUser._id
  );

  const loggedInUser = await User.findById(registeredUser._id).select(
    "-password -refreshToken"
  );
  const options = {
    httpOnly: true,
    secure: true,
    sameSite: "strict",
  };
  return res
    .status(200)
    .cookie("accessToken", accessToken, options)
    .cookie("refreshToken", refreshToken, options)
    .json({
      message: "user logged in successfully",
      user: loggedInUser,
      accessToken,
      refreshToken,
    });
});

export { signinUser, loginUser };
