import 'package:flutter/material.dart';

import '../../../core/services/trip_service.dart';

class CreateTripScreen
    extends StatefulWidget {

  const CreateTripScreen({
    super.key,
  });

  @override
  State<CreateTripScreen>
      createState() =>
          _CreateTripScreenState();
}

class _CreateTripScreenState
    extends State<CreateTripScreen> {

  final titleController =
      TextEditingController();

  final destinationController =
      TextEditingController();

  final startLocationController =
      TextEditingController();

  final budgetController =
      TextEditingController();

  final notesController =
      TextEditingController();

  String travelMode = "Bike";

  bool isSolo = true;

  bool isLoading = false;


  // =====================================================
  // CREATE TRIP
  // =====================================================

  Future<void> createTrip() async {

    setState(() {
      isLoading = true;
    });

    try {

      final response =
          await TripService()
              .createTrip(
        title:
            titleController.text.trim(),

        destination:
            destinationController.text
                .trim(),

        startLocation:
            startLocationController.text
                .trim(),

        travelMode: travelMode,

        budget:
            budgetController.text.trim(),

        isSolo: isSolo,

        notes:
            notesController.text.trim(),
      );

      if (response["success"] == true) {

        if (!mounted) return;

        Navigator.pop(context, true);

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
              response["message"],
            ),
          ),
        );
      }
    } catch (error) {

      print(error);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );

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
          "Create Trip",
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            // =====================================================
            // TRIP TITLE
            // =====================================================

            TextField(
              controller:
                  titleController,

              decoration:
                  const InputDecoration(
                hintText: "Trip Title",
              ),
            ),

            const SizedBox(height: 20),


            // =====================================================
            // DESTINATION
            // =====================================================

            TextField(
              controller:
                  destinationController,

              decoration:
                  const InputDecoration(
                hintText: "Destination",
              ),
            ),

            const SizedBox(height: 20),


            // =====================================================
            // START LOCATION
            // =====================================================

            TextField(
              controller:
                  startLocationController,

              decoration:
                  const InputDecoration(
                hintText:
                    "Start Location",
              ),
            ),

            const SizedBox(height: 20),


            // =====================================================
            // TRAVEL MODE
            // =====================================================

            DropdownButtonFormField(
              value: travelMode,

              items: const [

                DropdownMenuItem(
                  value: "Bike",
                  child: Text("Bike"),
                ),

                DropdownMenuItem(
                  value: "Car",
                  child: Text("Car"),
                ),

                DropdownMenuItem(
                  value: "Train",
                  child: Text("Train"),
                ),

                DropdownMenuItem(
                  value: "Flight",
                  child: Text("Flight"),
                ),
              ],

              onChanged: (value) {

                setState(() {
                  travelMode = value!;
                });
              },

              decoration:
                  const InputDecoration(
                hintText:
                    "Travel Mode",
              ),
            ),

            const SizedBox(height: 20),


            // =====================================================
            // BUDGET
            // =====================================================

            TextField(
              controller:
                  budgetController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                hintText: "Budget",
              ),
            ),

            const SizedBox(height: 20),


            // =====================================================
            // SOLO TRIP
            // =====================================================

            SwitchListTile(
              value: isSolo,

              onChanged: (value) {

                setState(() {
                  isSolo = value;
                });
              },

              title: const Text(
                "Solo Trip",
              ),
            ),

            const SizedBox(height: 20),


            // =====================================================
            // NOTES
            // =====================================================

            TextField(
              controller:
                  notesController,

              maxLines: 5,

              decoration:
                  const InputDecoration(
                hintText: "Notes",
              ),
            ),

            const SizedBox(height: 40),


            // =====================================================
            // CREATE BUTTON
            // =====================================================

            SizedBox(
              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                onPressed:
                    isLoading
                        ? null
                        : createTrip,

                child:
                    isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Create Trip",
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}