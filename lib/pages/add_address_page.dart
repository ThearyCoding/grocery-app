import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/core/app_colors.dart';
import 'package:grocery_app/pages/full_map_page.dart';
import 'package:grocery_app/widgets/custom_button.dart';
import 'package:geolocator/geolocator.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool _isDefaultAddress = false;
  String _selectedTitle = "MR";
  String _selectedTag = "Home";
  GoogleMapController? controller;

  LatLng? currentPosition;
  Stream<Position>? _streamPostion;

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
    }
    _streamPostion = Geolocator.getPositionStream();

    _streamPostion?.listen(
      (Position position) {
        setState(() {
          currentPosition = LatLng(position.latitude, position.longitude);
        });
      },
    );

    if (controller != null) {
      controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentPosition ?? LatLng(0, 0),
        zoom: 15,
      )));
    }
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: currentPosition == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withValues(alpha: .3),
                                offset: Offset(0, 3),
                                spreadRadius: 2,
                                blurRadius: 10)
                          ]),
                      width: double.infinity,
                      height: 200,
                      child: GoogleMap(
                          myLocationEnabled: true,
                          onMapCreated: (controller) {
                            setState(() {
                              this.controller = controller;
                            });
                          },
                          initialCameraPosition: CameraPosition(
                              zoom: 15,
                              target: currentPosition ?? LatLng(0, 0))),
                    ),
                    Text("Select your location on the map above"),
                    SizedBox(
                      height: 15,
                    ),
                    _buildHeader(title: "Contact"),
                    Row(
                      spacing: 10,
                      children: [
                        _buildTitleButton("MR",
                            isSelected: _selectedTag == "MR", isTag: true),
                        _buildTitleButton("MS",
                            isSelected: _selectedTag == "MS", isTag: true)
                      ],
                    ),
                    _buildTextField(
                        label: "Name",
                        hintText: "Enter your name",
                        prefixIcon: Icons.person),
                    _buildHeader(title: "Phone No."),
                    _buildTextField(
                        label: "Contact phone number",
                        hintText: "e.g. 588 12 345 678",
                        prefixIcon: Icons.phone),
                    _buildHeader(title: "Address"),
                    _buildTextField(
                        readOnly: true,
                        onTap: () {
                          Get.to(() => FullMapPage());
                        },
                        label: "Receiving Address",
                        hintText: "Select address from map",
                        prefixIcon: Icons.location_pin),
                    _buildTextField(
                        label: "Detail",
                        hintText: "House number, floor, room,etc",
                        prefixIcon: Icons.home),
                    _buildHeader(title: "Tag"),
                    Row(
                      spacing: 10,
                      children: [
                        _buildTitleButton("Home",
                            isSelected: _selectedTitle == "Home"),
                        _buildTitleButton("Office",
                            isSelected: _selectedTitle == "Office"),
                        _buildTitleButton("School",
                            isSelected: _selectedTitle == "School"),
                        _buildTitleButton("Other",
                            isSelected: _selectedTitle == "Other")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _isDefaultAddress,
                            onChanged: (value) {
                              setState(() {
                                _isDefaultAddress = value ?? false;
                              });
                            }),
                        Text("Set as default addresss")
                      ],
                    ),
                    Text("Address Photos (Up to 5)"),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Center(child: Icon(Icons.add_photo_alternate)),
                    ),
                    CustomButton(label: "Save Address", onPressed: () {})
                  ],
                ),
              ));
  }

  Text _buildHeader({required String title}) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }

  Widget _buildTitleButton(String title,
      {required bool isSelected, bool isTag = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isTag) {
            _selectedTag = title;
          } else {
            _selectedTitle = title;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.3)
                : Colors.grey.shade50,
            border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.grey.shade300)),
        child: Text(title),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hintText,
      required IconData prefixIcon,
      bool readOnly = false,
      VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        TextField(
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon),
              hintText: hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey)),
              contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16, vertical: 12)),
        ),
      ],
    );
  }
}
