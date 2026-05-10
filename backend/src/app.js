const express = require("express");

const cors = require("cors");

const pool = require("./config/database");

const authRoutes = require("./routes/auth.routes");

const app = express();

app.use(cors());

app.use(express.json());

app.get("/", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT NOW()"
    );

    res.json({
      success: true,
      message: "Database connected",
      time: result.rows[0],
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Database failed",
    });
  }
});



app.use("/api/auth", authRoutes);

module.exports = app;