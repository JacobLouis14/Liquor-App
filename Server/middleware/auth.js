const jwt = require("jsonwebtoken");

//Checking User with token
const userAuth = (req, res, next) => {
  try {
    let token = req.header("Authorization");

    if (!token || !token.startsWith("Bearer ", 0))
      res.status(401).json({ msg: "Access Denied, Authentication failed" });
    else {
      token = token.slice(7, token.length).trimLeft();

      //Checking token invalidity
      let verified;
      try {
        verified = jwt.verify(token, process.env.SECRET_KEY);
      } catch (error) {
        res.status(401).json({ msg: "Access Denied, Authentication failed" });
      }
      req.user = verified;
      next();
    }
  } catch (error) {
    console.log(error);
  }
};

//Check is Admin with token
const isAdmin = (req, res, next) => {
  try {
    let token = req.header("Authorization");

    if (!token || !token.startsWith("Bearer ", 0))
      res.status(401).json({ msg: "Access Denied, Authentication failed" });
    else {
      token = token.slice(7, token.length).trimLeft();

      //Checking token invalidity
      let verified;
      try {
        verified = jwt.verify(token, process.env.SECRET_KEY);
      } catch (error) {
        res.status(401).json({ msg: "Access Denied, Authentication failed" });
      }
      if (verified.IsAdmin) {
        req.user = verified;
        next();
      } else {
        res.status(401).json({ msg: "Access Denied, Authentication failed" });
      }
    }
  } catch (error) {
    console.log(error);
  }
};

module.exports = { userAuth, isAdmin };
