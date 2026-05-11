import 'package:flutter/material.dart';

import '../../../models/trip_model.dart';

import '../../../core/services/trip_service.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routes/route_names.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  bool isLoading = true;

  List<TripModel> trips = [];

  @override
  void initState() {
    super.initState();

    fetchTrips();
  }

  Future<void> fetchTrips() async {

    try {

      final response =
          await TripService()
              .getTrips();

      if (response["success"] == true) {

        final data =
            response["trips"] as List;

        trips = data
            .map(
              (trip) =>
                  TripModel.fromJson(
                trip,
              ),
            )
            .toList();
      }
    } catch (error) {

      print(error);

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Waypoint",
        ),
      ),

      floatingActionButton:
    FloatingActionButton(
  onPressed: () async {

    final result =
        await context.push(
      RouteNames.createTrip,
    );

    if (result == true) {

      setState(() {
        isLoading = true;
      });

      fetchTrips();
    }
  },

  child: const Icon(Icons.add),
),

      body:
          isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : trips.isEmpty

                  ? const Center(
                      child: Text(
                        "No Trips Yet",
                      ),
                    )

                  : ListView.builder(
                      padding:
                          const EdgeInsets.all(
                        16,
                      ),

                      itemCount:
                          trips.length,

                      itemBuilder:
                          (context, index) {

                        final trip =
                            trips[index];

                        return Container(
                          margin:
                              const EdgeInsets.only(
                            bottom: 16,
                          ),

                          padding:
                              const EdgeInsets.all(
                            18,
                          ),

                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFF1E293B,
                            ),

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                trip.title,

                                style:
                                    const TextStyle(
                                  fontSize: 22,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              Text(
                                trip.destination,
                              ),

                              const SizedBox(
                                height: 12,
                              ),

                              Row(
                                children: [

                                  const Icon(
                                    Icons.route,
                                    size: 18,
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Text(
                                    trip.travelMode,
                                  ),

                                  const Spacer(),

                                  const Icon(
                                    Icons.currency_rupee,
                                    size: 18,
                                  ),

                                  Text(
                                    trip.budget,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
    );
  }
}