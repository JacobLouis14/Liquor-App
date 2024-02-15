const express = require("express");
const router = express.Router();

// controllers
const { signIn, signUp } = require("../controllers/auth");
const { userAuth } = require("../middleware/auth");
const {
  userData,
  getUserWishlist,
  createUserWishlist,
} = require("../controllers/user_controller");

/* user login route */
router.post("/login", signIn);

/* user SignUp route */
router.post("/signup", signUp);

/* User Data Route */
router.get("/userdata", userAuth, userData);

/* User Wishlist Route */
router.get("/wishlistdata", userAuth, getUserWishlist);

/**User wishlist creation */
router.patch("/createwishlist", userAuth, createUserWishlist);

module.exports = router;
