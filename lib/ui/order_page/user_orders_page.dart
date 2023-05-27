import 'package:bookmark/model/order_model.dart';
import 'package:bookmark/ui/order_page/order_details.dart';
import 'package:bookmark/ui/order_page/order_vm.dart';
import 'package:bookmark/utils/offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

class UserOrdersPage extends StatelessWidget {
  UserOrdersPage({super.key});
  OrderVM vm = Get.put(OrderVM());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('My Orders'),
            bottom: TabBar(
                // indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                // indicator: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50),
                //     color: Colors.white),
                controller: vm.tabController,
                tabs: vm.myTabs)),
        body: GetBuilder<OrderVM>(builder: (vm) {
          return vm.getUserOrderLoader
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: vm.tabController,
                  children: [
                    OfflineBuilder(
                      connectivityBuilder: (
                        BuildContext context,
                        ConnectivityResult connectivity,
                        Widget child,
                      ) {
                        final bool connected =
                            connectivity != ConnectivityResult.none;
                        if (connected) {
                          return ListView.separated(
                              itemBuilder: (context, i) {
                                return UserOrderWidget(
                                    order: vm.activeUserOrderList[i]);
                              },
                              separatorBuilder: (context, i) {
                                return const SizedBox(height: 10);
                              },
                              itemCount: vm.activeUserOrderList.length);
                        } else {
                          return offlineWidget();
                        }
                      },
                      child: Text(""),
                    ),
                    Container(
                      child: OfflineBuilder(
                        connectivityBuilder: (
                          BuildContext context,
                          ConnectivityResult connectivity,
                          Widget child,
                        ) {
                          final bool connected =
                              connectivity != ConnectivityResult.none;
                          if (connected) {
                            return ListView.separated(
                                itemBuilder: (context, i) {
                                  return UserOrderWidget(
                                      order: vm.userOrderList[i]);
                                },
                                separatorBuilder: (context, i) {
                                  return const SizedBox(height: 10);
                                },
                                itemCount: vm.userOrderList.length);
                          } else {
                            return offlineWidget();
                          }
                        },
                        child: Text(""),
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}

class UserOrderWidget extends StatelessWidget {
  UserOrderWidget({
    required this.order,
    Key? key,
  }) : super(key: key);
  OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderVM>(builder: (vm) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.09),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      orderDetailText(
                          name: "Order Id",
                          value: "${order.info.razorpayOrderId}"),
                      orderDetailText(
                          name: "",
                          value: "${order.info.createdAt.substring(0, 10)}"),
                    ]),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      orderDetailText(
                          name: "Payment Status",
                          value: "${order.info.paymentStatus}",
                          color: order.info.paymentStatus == "success"
                              ? Colors.green
                              : Colors.red),
                      orderDetailText(
                        value: "Items",
                        name: "${order.items.length} ",
                      )
                    ]),
                const SizedBox(height: 10),
                Row(
                  children: [
                    orderDetailText(
                        name: "Total ",
                        value: "₹${order.info.totalAmountAfterCharges}"),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(height: 2),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: orderDetailText(
                            fontWeight: FontWeight.bold,
                            name: "Order Status ",
                            value: "${order.info.status}",
                            color: order.info.status == "new"
                                ? Color.fromARGB(255, 214, 195, 23)
                                : Colors.red),
                      ),
                      // Text("Status ${order.status}",
                      // style: TextStyle(color: Colors.green)),
                      InkWell(
                        onTap: () {
                          Get.to(() => OrderDetails(order: order));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Details",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
              ],
            )),
      );
    });
  }
}

class orderDetailText extends StatelessWidget {
  const orderDetailText({
    Key? key,
    required this.name,
    required this.value,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  final String name;
  final FontWeight? fontWeight;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: '$name ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
          children: <TextSpan>[
            TextSpan(
                style: TextStyle(
                    fontWeight: fontWeight ?? FontWeight.normal,
                    color: color ?? Theme.of(context).primaryColor),
                text: value)
          ]),
    );
  }
}
