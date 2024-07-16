const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const { authTokenSign } = require("../utils/authToken");

// USer Model
const userModel = require("../models/user");

////////////////////////////////// Sign In controller
const signIn = async (req, res) => {
  try {
    const { email, password } = req.body;

    //Check if it exists
    let isExists = await userModel.findOne({ Email: email });

    if (!isExists) {
      return res.status(404).json({ msg: "No account, in our history" });
    }

    //Checking password
    let isPasswordMatch = await bcrypt.compare(password, isExists.Password);
    if (!isPasswordMatch) {
      return res.status(401).json({ msg: "Invalid UserName/Password" });
    }

    //Token Generating
    const token = authTokenSign(isExists);

    const { Password, ...userDataToSend } = isExists._doc;
    res.status(200).json({ token, user: userDataToSend });
  } catch (error) {
    console.log(error);
  }
};

//////////////////////////////////////Sign Up Controller
const signUp = async (req, res) => {
  try {
    const { name, email, password, dateOfBirth } = req.body;

    //check if this acc exist
    let isExist = await userModel.findOne({ Email: email });

    if (!isExist) {
      const salt = await bcrypt.genSalt();
      const passwordHash = await bcrypt.hash(password, salt);

      const newUser = new userModel({
        Name: name,
        Email: email,
        Password: passwordHash,
        DateOfBirth: dateOfBirth,
      });

      const savedUser = await newUser.save();
      const { Password, ...userDataToSend } = savedUser._doc;

      //Token Generating
      const token = authTokenSign(savedUser);

      res.status(200).json({ token, user: userDataToSend });
    } else {
      res.status(401).json({ err: "User already Exists" });
    }
  } catch (error) {
    console.log(error);
  }
};

module.exports = { signIn, signUp };
