import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/api_constants.dart';

class TripService {

  // =====================================================
  // GET ALL TRIPS
  // =====================================================

  Future<Map<String, dynamic>>
      getTrips() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final token =
        prefs.getString("token");

    final response = await http.get(
      Uri.parse(
        "${ApiConstants.baseUrl}/trips",
      ),

      headers: {
        "Authorization":
            "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }


  // =====================================================
  // CREATE TRIP
  // =====================================================

  Future<Map<String, dynamic>>
      createTrip({
    required String title,
    required String destination,
    required String startLocation,
    required String travelMode,
    required String budget,
    required bool isSolo,
    required String notes,
  }) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    final token =
        prefs.getString("token");

    final response = await http.post(
      Uri.parse(
        "${ApiConstants.baseUrl}/trips",
      ),

      headers: {
        "Content-Type":
            "application/json",

        "Authorization":
            "Bearer $token",
      },

      body: jsonEncode({
        "title": title,

        "destination":
            destination,

        "start_location":
            startLocation,

        "travel_mode":
            travelMode,

        "budget": budget,

        "is_solo": isSolo,

        "member_count": 1,

        "notes": notes,
      }),
    );

    return jsonDecode(response.body);
  }
}