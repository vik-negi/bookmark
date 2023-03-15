import 'package:bookmark/model/order_model.dart';
import 'package:bookmark/ui/order_page/order_vm.dart';
import 'package:bookmark/ui/order_page/user_orders_page.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:bookmark/utils/cupertinoDialogBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key, required this.order});
  OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderVM>(builder: (vm) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Order Details'),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order",
                            style: TextStyle(
                                fontSize: 42, fontWeight: FontWeight.w400)),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            order.info.paymentStatus != null
                                ? order.info.paymentStatus.toUpperCase()
                                : "",
                            style: TextStyle(
                              fontSize: 20,
                              color: order.info.paymentStatus == "failed"
                                  ? Colors.red
                                  : Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  // fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor),
                              text: "status ",
                              children: [
                                TextSpan(
                                  text: order.info.status,
                                  style: TextStyle(
                                      // fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  // fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColor),
                              text: "ID : ",
                              children: [
                                TextSpan(text: order.info.razorpayOrderId)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnotherStepper(
                      activeIndex:
                          vm.activeIndexList.indexOf(order.info.status),
                      barThickness: 5,
                      activeBarColor: order.info.status == "cancelled"
                          ? Colors.red
                          : Color.fromARGB(255, 214, 195, 23),
                      inActiveBarColor: Colors.grey.shade300,
                      stepperList: [
                        stepperDataMethod("Order Placed", Icons.shopping_cart,
                            vm.activeIndexList.indexOf(order.info.status) < 0),
                        stepperDataMethod(
                            "Processing",
                            order.info.status == "cancelled"
                                ? CupertinoIcons.multiply
                                : Icons.precision_manufacturing,
                            vm.activeIndexList.indexOf(order.info.status) < 1),
                        stepperDataMethod(
                            "Dispatched",
                            order.info.status == "cancelled"
                                ? CupertinoIcons.multiply
                                : Icons.delivery_dining,
                            vm.activeIndexList.indexOf(order.info.status) < 2),
                        stepperDataMethod(
                            "Delivered",
                            order.info.status == "cancelled"
                                ? CupertinoIcons.multiply
                                : Icons.home,
                            vm.activeIndexList.indexOf(order.info.status) < 3),
                      ],
                      stepperDirection: Axis.horizontal,
                      iconWidth:
                          40, // Height that will be applied to all the stepper icons
                      iconHeight:
                          40, // Width that will be applied to all the stepper icons
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    const SizedBox(height: 50),
                    Text("Delivery Address",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      width: Get.width - 20,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              // fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor),
                          text:
                              "${order.address.addressLine1} ${order.address.addressLine2} ",
                          children: [
                            TextSpan(
                                text:
                                    "${order.address.city} ${order.address.state} ${order.address.zipCode}")
                          ],
                        ),
                      ),
                    ),
                    orderDetailText(
                        name: "Order Date ",
                        value: "${order.info.createdAt.substring(0, 10)}"),
                    const SizedBox(height: 10),
                    orderDetailText(name: "Payment Method ", value: "Razorpay"),
                    const SizedBox(height: 10),
                    orderDetailText(
                        name: "Payment Status ",
                        value: order.info.paymentStatus,
                        color: order.info.paymentStatus == "failed"
                            ? Colors.red
                            : Colors.blue),
                    const SizedBox(height: 10),
                    order.info.paymentStatus == "success"
                        ? orderDetailText(
                            name: "Payment Id ",
                            value: "${order.info.razorpayPaymentId}")
                        : Container(),
                    const SizedBox(height: 20),
                    //   ],
                    // ),
                    Text(
                      "Books",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 140.0 * order.items.length,
                      child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.all(5),
                                width: Get.width,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.09),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 75,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(order
                                              .items[index].books.image1.url),
                                        ),
                                      ),
                                      // child: NetworkImage.(
                                      //   child: Image.network(order
                                      //       .items[index].books.image1.url),
                                      // ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width - 150,
                                            child: RichText(
                                                maxLines: 2,
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    text:
                                                        "${order.items[index].books.bookName}")),
                                          ),
                                          SizedBox(
                                            width: Get.width - 150,
                                            child: RichText(
                                                maxLines: 2,
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    text: order.items[index]
                                                        .books.author)),
                                          ),
                                          orderDetailText(
                                              name: "Price ",
                                              value:
                                                  "₹${order.items[index].amount}")
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: order.items.length),
                    ),
                    // const SizedBox(height: 50),
                    Text(
                      "Payment Summary",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    OrderSummary("Sub-Total",
                        "₹${order.info.totalAmountBeforeCharges}", context),
                    OrderSummary("Delivery Charges",
                        "₹${order.info.deliveryFees}", context),
                    OrderSummary("Internet Handling Charges",
                        "₹${order.info.internetHandlingFees}", context),
                    OrderSummary("Service Charges",
                        "₹${order.info.serviceFees}", context),
                    Divider(height: 2),
                    OrderSummary("Total",
                        "₹${order.info.totalAmountAfterCharges}", context,
                        fontSize: 20, fontWeight: FontWeight.w400),

                    const SizedBox(height: 20),
                    order.info.courier == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  "Delivery Summary",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 20),
                                orderDetailText(
                                    name: "Delivery By",
                                    value:
                                        "${order.info.courier!.courierName}"),

                                // Text(
                                //   "Contact Details",
                                //   style: TextStyle(
                                //       fontSize: 18, fontWeight: FontWeight.bold),
                                // ),
                                // Row(
                                //   children: [
                                //     CircleAvatar(
                                //       child: Image.network(
                                //         order.info.courier!.image!.url ??
                                //             "https://res.cloudinary.com/dczd69z1w/image/upload/v1675174722/default_person_adsn2a.png",
                                //         width: 55,
                                //         height: 55,
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //     const SizedBox(width: 10),
                                //     Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           "${order.info.courier!.courierName}",
                                //           style: TextStyle(
                                //               fontSize: 15,
                                //               fontWeight: FontWeight.bold),
                                //         ),
                                //         Text(
                                //           "${order.info.courier!.email}",
                                //           style: TextStyle(
                                //               fontSize: 15,
                                //               fontWeight: FontWeight.normal,
                                //               color: Theme.of(context)
                                //                   .primaryColor),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () => vm.launchPhone("tel",
                                          order.info.courier!.phone.toString()),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: Get.width / 3,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.phone),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Call Now",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => vm.launchPhone(
                                        "mailto",
                                        order.info.courier!.email.toString(),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: Get.width / 3,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.mail),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Mail Now",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ])
                  ],
                )),
          ),
          bottomNavigationBar: Container(
            width: Get.width,
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            color: Colors.transparent,
            height: 50,
            child: order.info.status == "cancelled"
                ? BtnWidget(
                    onPressed: () {}, title: "Re-Order", width: Get.width - 45)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BtnWidget(
                          onPressed: () {
                            vm.cancelOrder(order.info.razorpayOrderId);
                            // CupertinoDialogBox(Get.context, () {
                            // }, "Cancel Order",
                            //     "Are you sure you want to cancel this order?");
                          },
                          title: "Cancel",
                          width: Get.width / 2 - 45),
                      BtnWidget(
                          onPressed: () {},
                          title: "Re-Order",
                          width: Get.width / 2 - 45),
                    ],
                  ),
          ));
    });
  }

  StepperData stepperDataMethod(
      String name, IconData icon, bool isIndexGreater) {
    return StepperData(
      title: StepperText(
        name,
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      iconWidget: CircleAvatar(
          backgroundColor: isIndexGreater
              ? Colors.grey.shade300
              : order.info.status == "cancelled"
                  ? Colors.red
                  : Colors.green.shade500,
          child: Icon(icon,
              color: isIndexGreater ? Colors.green.shade500 : Colors.white)),
    );
  }

  Padding OrderSummary(String name, String value, BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          name,
          style:
              TextStyle(fontSize: fontSize ?? 15, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: fontSize ?? 15,
              fontWeight: fontWeight ?? FontWeight.normal,
              color: Theme.of(context).primaryColor),
        ),
      ]),
    );
  }
}

class BtnWidget extends StatelessWidget {
  BtnWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.width,
  }) : super(key: key);

  void Function() onPressed;
  String title;
  double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: width ?? Get.width - 45,
        // width: Get.width < 550 ? Get.width - 45 : Get.width * 0.5,
        height: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFfae3e2).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
