const bcrypt = require("bcrypt");

const pool = require("../../config/database");

const generateToken = require("../../utils/jwt");


// ======================================================
// SIGNUP
// ======================================================

const signup = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Check existing user

    const existingUser = await pool.query(
      `
      SELECT * FROM users
      WHERE email = $1
      `,
      [email]
    );

    if (existingUser.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: "User already exists",
      });
    }

    // Hash password

    const hashedPassword = await bcrypt.hash(
      password,
      10
    );

    // Create user

    const newUser = await pool.query(
      `
      INSERT INTO users(name, email, password)
      VALUES($1, $2, $3)
      RETURNING *
      `,
      [name, email, hashedPassword]
    );

    const user = newUser.rows[0];

    // Remove password from response

    delete user.password;

    // Generate token

    const token = generateToken(user.id);

    res.status(201).json({
      success: true,
      token,
      user,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Signup failed",
    });
  }
};


// ======================================================
// LOGIN
// ======================================================

const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user

    const userResult = await pool.query(
      `
      SELECT * FROM users
      WHERE email = $1
      `,
      [email]
    );

    if (userResult.rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: "Invalid credentials",
      });
    }

    const user = userResult.rows[0];

    // Compare password

    const isMatch = await bcrypt.compare(
      password,
      user.password
    );

    if (!isMatch) {
      return res.status(400).json({
        success: false,
        message: "Invalid credentials",
      });
    }

    // Remove password from response

    delete user.password;

    // Generate token

    const token = generateToken(user.id);

    res.json({
      success: true,
      token,
      user,
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Login failed",
    });
  }
};


// ======================================================
// GET CURRENT USER
// ======================================================

const getCurrentUser = async (
  req,
  res
) => {
  try {
    const userId = req.user.id;

    const userResult = await pool.query(
      `
      SELECT
        id,
        name,
        email,
        profile_image,
        created_at
      FROM users
      WHERE id = $1
      `,
      [userId]
    );

    if (userResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    res.json({
      success: true,
      user: userResult.rows[0],
    });
  } catch (error) {
    console.log(error);

    res.status(500).json({
      success: false,
      message: "Failed to fetch user",
    });
  }
};


// ======================================================
// EXPORTS
// ======================================================

module.exports = {
  signup,
  login,
  getCurrentUser,
};