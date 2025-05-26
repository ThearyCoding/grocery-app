import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/pages/mobile_number_page.dart';
import 'package:grocery_app/widgets/custom_button.dart';

class SelectedLocationPage extends StatefulWidget {
  const SelectedLocationPage({super.key});

  @override
  State<SelectedLocationPage> createState() => _SelectedLocationPageState();
}

class _SelectedLocationPageState extends State<SelectedLocationPage> {
  String? selectedZone = "Banasree";
  String? selectedArea;
  List<String> zones = ["Banasree", "Gulshan", "Dhanmondi", "Uttara"];
  List<String> areas = [
    "Residential",
    "Commercial",
    "Industrial",
    "Khmer",
    "English"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/location.png',
                  height: 250,
                )),
                Text(
                  "Select Your Location",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Switch on your location to stay in tune with what's happening in your area",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Zone",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButtonFormField(
                    value: selectedZone,
                    items: zones
                        .map((zone) => DropdownMenuItem(
                              value: zone,
                              child: Text(zone),
                            ))
                        .toList(),
                    onChanged: (value) {}),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Area",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButtonFormField(
                    value: selectedArea,
                    hint: Text("Types of your area"),
                    items: areas
                        .map((area) => DropdownMenuItem(
                              value: area,
                              child: Text(area),
                            ))
                        .toList(),
                    onChanged: (value) {}),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                    label: "Sumbit",
                    onPressed: () => Get.to(() => MobileNumberPage()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
