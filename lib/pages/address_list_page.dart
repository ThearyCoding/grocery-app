import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/address_controller.dart';
import 'package:iconly/iconly.dart';

class AddressListPage extends StatelessWidget {
  AddressListPage({super.key});
  final AddressController controller = Get.isRegistered<AddressController>()
      ? Get.find<AddressController>()
      : Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Address'),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (controller.addressRes.value.data == null ||
              controller.addressRes.value.data!.isEmpty) {
            return Center(
                child: Text('No addresses found. Please add an address.'));
          }
          return ListView.builder(
              itemCount: controller.addressRes.value.data?.length,
              itemBuilder: (_, index) {
                final address = controller.addressRes.value.data?[index];
                return ListTile(
                  leading: Icon(IconlyBold.location),
                  title: Text(
                    address?.address ?? 'No Address',
                    maxLines: 1,
                  ),
                  subtitle: Text(address?.detail ?? ''),
                  onTap: () {
                    Get.back(result: {
                      "id": address?.id ?? "",
                      "address": address?.address ?? ""
                    });
                  },
                );
              });
        }));
  }
}
