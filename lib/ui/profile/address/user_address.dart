import 'package:bookmark/ui/payment/payment.dart';
import 'package:bookmark/ui/payment/payment_viewmodel.dart';
import 'package:bookmark/ui/profile/address/add_address.dart';
import 'package:bookmark/ui/profile/cart_total_with_address.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddress extends StatelessWidget {
  UserAddress({super.key, required this.isPayment, this.total = 0.0});
  bool isPayment;
  double total;

  ProfileVM vm =
      Get.isRegistered<ProfileVM>() ? Get.find() : Get.put(ProfileVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
      body: GetBuilder<ProfileVM>(builder: (vm) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      // vm.addAddressOpen = true;
                      // Get.to(() => AddAddress());
                      vm.clearControllerAndAddAddress();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        const SizedBox(width: 10),
                        Text('Add Address'),
                      ],
                    )),
                const SizedBox(height: 10),
                vm.addressLoading
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: vm.address.length,
                          itemBuilder: (context, i) {
                            return AddressWidget(
                                i: i, isPayment: isPayment, total: total);
                          },
                          separatorBuilder: (context, i) {
                            return const SizedBox(height: 5);
                          },
                        ),
                      )
              ],
            ));
      }),
    );
  }
}

class AddressWidget extends StatelessWidget {
  AddressWidget({
    Key? key,
    required this.i,
    this.total = 0.0,
    required this.isPayment,
  }) : super(key: key);
  int i;
  bool isPayment;
  double total;
  PaymentVM paymentVM =
      Get.isRegistered<PaymentVM>() ? Get.find() : Get.put(PaymentVM());

  @override
  Widget build(BuildContext context) {
    print("isPayment: $isPayment");
    return GetBuilder<ProfileVM>(builder: (vm) {
      return GetBuilder<PaymentVM>(builder: (paymentVM) {
        return InkWell(
          onTap: () {
            if (isPayment) {
              paymentVM.selectedAddress = vm.address[i];
              paymentVM.update();
              // Get.back();
              // Get.to(()=> A)
              paymentVM.getBills();
              Get.to(() => CartWithFullPaymentDetails());
            }
          },
          child: Container(
              child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: isPayment ? Get.width - 165 : Get.width - 110,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Theme.of(Get.context!).primaryColor,
                                  fontSize: 12),
                              text: vm.address[i].addressLine1,
                              children: <TextSpan>[
                                TextSpan(
                                    style: TextStyle(
                                        color:
                                            Theme.of(Get.context!).primaryColor,
                                        fontSize: 12),
                                    text: "${vm.address[i].addressLine2}"),
                              ]),
                        ),
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        width: isPayment ? Get.width - 165 : Get.width - 110,
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                              style: TextStyle(
                                  color: Theme.of(Get.context!).primaryColor,
                                  fontSize: 12),
                              text:
                                  "${vm.address[i].city}, ${vm.address[i].state} - ${vm.address[i].zipCode}"),
                        ),
                      ),
                    ],
                  ),
                  isPayment
                      ? const SizedBox()
                      : const SizedBox(
                          width: 10,
                        ),
                  isPayment
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    height: 120,
                                    width: Get.width - 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.edit,
                                              color: Colors.blue),
                                          title: Text('Edit'),
                                          onTap: () {
                                            vm.addAddressOpen = false;
                                            vm.updateController(vm.address[i]);
                                            // Get.to(() => AddAddress());
                                            vm.update();
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.delete,
                                              color: Colors.red),
                                          title: Text('Delete'),
                                          onTap: () {
                                            vm.deleteUserAddress(
                                                vm.address[i].id);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Icon(Icons.more_vert),
                        )
                ],
              ),
              const SizedBox(height: 10),
            ],
          )),
        );
      });
    });
  }
}
