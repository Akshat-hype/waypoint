const pool = require(
  "../../config/database"
);


// =====================================================
// CREATE TRIP
// =====================================================

const createTrip = async (
  req,
  res
) => {
  try {

    const userId = req.user.id;

    const {
      title,
      destination,
      start_location,
      start_date,
      end_date,
      travel_mode,
      budget,
      is_solo,
      member_count,
      notes,
    } = req.body;

    const result = await pool.query(
      `
      INSERT INTO trips(
        user_id,
        title,
        destination,
        start_location,
        start_date,
        end_date,
        travel_mode,
        budget,
        is_solo,
        member_count,
        notes
      )

      VALUES(
        $1,$2,$3,$4,$5,$6,
        $7,$8,$9,$10,$11
      )

      RETURNING *
      `,
      [
        userId,
        title,
        destination,
        start_location,
        start_date,
        end_date,
        travel_mode,
        budget,
        is_solo,
        member_count,
        notes,
      ]
    );

    res.status(201).json({
      success: true,
      trip: result.rows[0],
    });

  } catch (error) {

    console.log(error);

    res.status(500).json({
      success: false,
      message: "Failed to create trip",
    });
  }
};


// =====================================================
// GET ALL TRIPS
// =====================================================

const getTrips = async (
  req,
  res
) => {
  try {

    const userId = req.user.id;

    const result = await pool.query(
      `
      SELECT *
      FROM trips

      WHERE user_id = $1

      ORDER BY created_at DESC
      `,
      [userId]
    );

    res.json({
      success: true,
      trips: result.rows,
    });

  } catch (error) {

    console.log(error);

    res.status(500).json({
      success: false,
      message: "Failed to fetch trips",
    });
  }
};

module.exports = {
  createTrip,
  getTrips,
};