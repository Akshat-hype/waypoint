const express = require("express");

const {
  createTrip,
  getTrips,
} = require(
  "../controllers/trips/trip.controller"
);

const authMiddleware = require(
  "../middleware/auth.middleware"
);

const router = express.Router();

router.post(
  "/",
  authMiddleware,
  createTrip
);

router.get(
  "/",
  authMiddleware,
  getTrips
);

module.exports = router;