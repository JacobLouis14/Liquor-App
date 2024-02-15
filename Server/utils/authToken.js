const jwt = require("jsonwebtoken");

const authTokenSign = (user) => {
  const secretKey = process.env.SECRET_KEY;

  const token = jwt.sign(
    {
      id: user.id,
      email: user.Email,
      IsAdmin: user.IsAdmin,
    },
    secretKey
  );

  return token;
};

module.exports = { authTokenSign };
