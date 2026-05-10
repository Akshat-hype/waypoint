const express = require("express");

const {
  signup,
  login,
  getCurrentUser,
} = require("../controllers/auth/auth.controller");

const authMiddleware = require(
  "../middleware/auth.middleware"
);

const router = express.Router();

router.post("/signup", signup);

router.post("/login", login);

router.get(
  "/me",
  authMiddleware,
  getCurrentUser
);

module.exports = router;