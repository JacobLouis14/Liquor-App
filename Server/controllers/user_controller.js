const mongoose = require("mongoose");

const UserModel = require("../models/user");
const productModel = require("../models/product");

//////////////////////////////UserData Retrival
const userData = async (req, res) => {
  try {
    const userId = req.user.id;

    const user = await UserModel.findById(userId, { Password: 0 });

    res.status(200).json(user);
  } catch (error) {
    console.log(error);
  }
};

///////////////////////////////User wishlist Retrival
const getUserWishlist = async (req, res) => {
  try {
    const userId = req.user.id;

    const userWishlist = await UserModel.findById(userId, {
      _id: 0,
      Wishlist: 1,
    });

    if (userWishlist.Wishlist.length == 0) {
      res.status(200).json(userWishlist);
    } else {
      const wishListProduct = [];
      for (let i = 0; i < userWishlist.Wishlist.length; i++) {
        const product = await productModel.findById(userWishlist.Wishlist[i]);
        wishListProduct.push(product);
      }
      res.status(200).json(wishListProduct);
    }
  } catch (error) {
    console.log(error);
  }
};

///////////////////////////////User wishlist Creation
const createUserWishlist = async (req, res) => {
  try {
    const wishlistData = req.body.wishlistData;
    const userId = req.user.id;

    const user = await UserModel.findById(userId);

    const updatedUser = {
      Name: user.Name,
      Email: user.Email,
      Password: user.Password,
      IsAdmin: user.IsAdmin,
      DateOfBirth: user.DateOfBirth,
      Wishlist: wishlistData,
    };

    const updateAck = await UserModel.updateOne(
      { _id: userId },
      { $set: updatedUser }
    );
    if (updateAck.modifiedCount === 1) {
      // let updatedData = await UserModel.findById(userId);
      // const { Password, ...updatedDtatatoSend } = updatedData._doc;
      res.status(200).json({ msg: "Wishlist added sucessfully" });
    } else {
      res.status(400).send(`Failed to update wishlist to database`);
    }
  } catch (error) {
    console.log(error);
  }
};
// ///////////////////////////////DASHBOARD CONTROLS///////////////////////////

///////////////////////////////User Full Data Retrival
const getFullUserData = async (req, res) => {
  try {
    const userList = await UserModel.find({});
    res.status(200).json(userList);
  } catch (error) {
    console.log(error);
  }
};

module.exports = {
  userData,
  getUserWishlist,
  createUserWishlist,
  getFullUserData,
};
