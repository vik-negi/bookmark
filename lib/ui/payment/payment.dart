import 'dart:async';

import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/model/book.dart';
import 'package:bookmark/ui/animation/fade_animation.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/ui/main/order_page.dart';
import 'package:bookmark/ui/payment/payment_success.dart';
import 'package:bookmark/ui/payment/payment_viewmodel.dart';
import 'package:bookmark/ui/profile/address/user_address.dart';
import 'package:bookmark/ui/profile/profileVM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  double price;
  PaymentPage({Key? key, required this.price}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int activeCard = 0;
  bool _isLoading = false;
  bool _radioButton = false;
  late Timer _timer;
  TextEditingController _cardNoController = TextEditingController();
  TextEditingController _card1CVVController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  FocusNode _cardNoFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();

  // pay() {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   const oneSec = Duration(seconds: 2);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       setState(() {
  //         _isLoading = false;
  //         timer.cancel();
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => PaymentSuccess()));
  //       });
  //     },
  //   );
  // }

  void showSelectAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Date'),
            content: Text('Please select Dates to continue'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          );
        });
  }

  void showAlertDialog(BuildContext context, DiningVM HomeVM, address) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment'),
            content: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Please confirm your details'),
                  const SizedBox(height: 10),
                  Text(
                      // 'Total amount : ₹ ${vm.getDates(widget.price).toStringAsFixed(2)}'),
                      'Total amount : ₹ ${widget.price}'),
                  const SizedBox(height: 5),
                  Text('Address : $address'),
                  const SizedBox(height: 5),
                  // Text(
                  //     'days : ${vm.startAndEndDate[0].day}-${vm.startAndEndDate[0].month}-${vm.startAndEndDate[0].year} to ${vm.startAndEndDate[1].day}-${vm.startAndEndDate[1].month}-${vm.startAndEndDate[1].year}')
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    // vm.placeOrder();
                    // vm.razorpayPayment((widget.price * 100).toString());
                    // pay();
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }

  PaymentVM vm = Get.put(PaymentVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentVM>(builder: (vm) {
      return GetBuilder<DiningVM>(builder: (HomeVM) {
        return GestureDetector(
          onTap: () {
            if (_cardNoFocusNode.hasFocus) {
              _cardNoFocusNode.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  'Payment',
                ),
                leading: const BackButton(
                    // color: Colors.black,
                    ),
                bottom: PreferredSize(
                  preferredSize: Size(Get.width, 25),
                  child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      width: Get.width,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              text:
                                  // 'Total amount : ${vm.startAndEndDate.isEmpty ? "__________" : ""}',
                                  'Total amount : ${widget.price}',
                              style: TextStyle(
                                  // color: Colors.black,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              children: [
                                // TextSpan(
                                //     text: vm.startAndEndDate.isEmpty
                                //         ? ""
                                //         : "₹ ${vm.getDates(widget.price).toStringAsFixed(2)}",
                                //     style: const TextStyle(
                                //       fontSize: 22,
                                //     ))
                              ]),

                          // "₹ ${widget.price}",
                          // style: TextStyle(
                          //   fontSize: 22,
                          // ),
                        ),
                      )),
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Add Cards",
                            style: Theme.of(context).textTheme.headline6),
                        IconButton(
                            onPressed: () {
                              vm.addCard = !vm.addCard;
                              vm.update();
                            },
                            icon: Icon(Icons.add_circle_outline),
                            color: Theme.of(context).primaryColor)
                      ],
                    ),
                    const SizedBox(height: 20),
                    FadeAnimation(
                        1.2,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment Method",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                                child: Column(children: [
                              ListTile(
                                leading: Icon(Icons.branding_watermark),
                                title: const Text('Credit Card'),
                                trailing: Radio(
                                  value: PaymentModeEnum.creditCard.toString(),
                                  groupValue: vm.paymentOption,
                                  onChanged: (value) {
                                    vm.paymentOption = value as String;
                                    vm.update();
                                  },
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.branding_watermark),
                                title: const Text('Debit Card'),
                                trailing: Radio(
                                  value: PaymentModeEnum.debitCard.toString(),
                                  groupValue: vm.paymentOption,
                                  onChanged: (value) {
                                    vm.paymentOption = value as String;
                                    vm.update();
                                  },
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.monetization_on),
                                title: const Text('cod'),
                                trailing: Radio(
                                  value: PaymentModeEnum.cod.toString(),
                                  groupValue: vm.paymentOption,
                                  onChanged: (value) {
                                    vm.paymentOption = value as String;
                                    vm.update();
                                  },
                                ),
                              ),
                            ]))
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    vm.addCard
                        ? FadeAnimation(
                            1.3,
                            Row(children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    activeCard = 0;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: activeCard == 0
                                        ? Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1)
                                        : Border.all(
                                            color: Colors.grey.shade300
                                                .withOpacity(0),
                                            width: 1),
                                  ),
                                  child: Image.asset(
                                    'assets/images/mastercard-logo.png',
                                    height: 50,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    activeCard = 1;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: activeCard == 1
                                        ? Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1)
                                        : Border.all(
                                            color: Colors.grey.shade300
                                                .withOpacity(0),
                                            width: 1),
                                  ),
                                  child: Image.asset(
                                    'assets/images/apple-pay.png',
                                    height: 50,
                                  ),
                                ),
                              ),
                            ]))
                        : const SizedBox(),
                    // const SizedBox(height: 20),
                    vm.addCard
                        ? activeCard == 0
                            ? FadeAnimation(
                                1.2,
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: activeCard == 0 ? 1 : 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.yellow.shade800,
                                            Colors.yellow.shade900,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Credit Card",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: TextFormField(
                                                  controller: _cardNoController,
                                                  maxLength: 16,
                                                  focusNode: _cardNoFocusNode,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        "**** **** **** 1234",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                    counterText: '',
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // const Text(
                                                  //   "Vikram Negi",
                                                  //   style:
                                                  //       TextStyle(color: Colors.white),
                                                  // ),
                                                  SizedBox(
                                                    height: 45,
                                                    width: 75,
                                                    child: TextFormField(
                                                      controller:
                                                          _nameController,
                                                      maxLength: 16,
                                                      focusNode: _nameFocusNode,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                      decoration:
                                                          const InputDecoration(
                                                        counterText: '',
                                                        hintText: "name",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 45,
                                                        child: TextFormField(
                                                          maxLength: 3,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                          decoration:
                                                              const InputDecoration(
                                                            counterText: '',
                                                            hintText: "** ",
                                                            hintStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                            ),
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/mastercard-logo.png',
                                                        height: 50,
                                                        width: 75,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                ))
                            : FadeAnimation(
                                1.2,
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: activeCard == 1 ? 1 : 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    padding: const EdgeInsets.all(30.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        // color: Colors.grey.shade200
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.shade200,
                                            Colors.grey.shade100,
                                            Colors.grey.shade200,
                                            Colors.grey.shade300,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                  'assets/images/mac-os.png',
                                                  height: 50),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    "Vikram Negi",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  ),
                                                  Image.asset(
                                                    'assets/images/sim-card-chip.png',
                                                    height: 35,
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                ))
                        : const SizedBox(),
                    SizedBox(
                      height: vm.addCard ? 50 : 0,
                    ),
                    // FadeAnimation(
                    //     1.2,
                    //     const Text(
                    //       "Payment Method",
                    //       style:
                    //           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    //     )),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // FadeAnimation(
                    //     1.3,
                    //     Row(children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             activeCard = 0;
                    //           });
                    //         },
                    //         child: AnimatedContainer(
                    //           duration: const Duration(milliseconds: 300),
                    //           margin: const EdgeInsets.only(right: 10),
                    //           padding: const EdgeInsets.symmetric(horizontal: 20),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(18),
                    //             border: activeCard == 0
                    //                 ? Border.all(
                    //                     color: Colors.grey.shade300, width: 1)
                    //                 : Border.all(
                    //                     color: Colors.grey.shade300.withOpacity(0),
                    //                     width: 1),
                    //           ),
                    //           child: Image.network(
                    //             'https://img.icons8.com/color/2x/mastercard-logo.png',
                    //             height: 50,
                    //           ),
                    //         ),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             activeCard = 1;
                    //           });
                    //         },
                    //         child: AnimatedContainer(
                    //           duration: const Duration(milliseconds: 300),
                    //           margin: const EdgeInsets.only(right: 10),
                    //           padding: const EdgeInsets.symmetric(horizontal: 20),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(18),
                    //             border: activeCard == 1
                    //                 ? Border.all(
                    //                     color: Colors.grey.shade300, width: 1)
                    //                 : Border.all(
                    //                     color: Colors.grey.shade300.withOpacity(0),
                    //                     width: 1),
                    //           ),
                    //           child: Image.network(
                    //             'https://img.icons8.com/ios-filled/2x/apple-pay.png',
                    //             height: 50,
                    //           ),
                    //         ),
                    //       ),
                    //     ])),
                    // Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 5, horizontal: 10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25),
                    //         border: Border.all(
                    //             width: 2, color: Colors.grey.shade400)),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const Icon(Icons.timer),
                    //             const SizedBox(width: 25),
                    //             TextButton(
                    //               onPressed: () {
                    //                 // vm.pickDates(context);
                    //               },
                    //               child: Text('Select Date',
                    //                   style: TextStyle(
                    //                       fontSize: 18,
                    //                       color: Theme.of(context).primaryColor,
                    //                       fontWeight: FontWeight.bold)),
                    //             ),
                    //           ],
                    //         ),
                    //         vm.startAndEndDate.isNotEmpty
                    //             ? showPickedDates(
                    //                 context,
                    //                 vm.startAndEndDate[0],
                    //                 vm.startAndEndDate[1])
                    //             : const SizedBox(),
                    //       ],
                    //     )),
                    const SizedBox(
                      height: 30,
                    ),
                    vm.paymentOption == PaymentModeEnum.creditCard.toString() ||
                            vm.paymentOption ==
                                PaymentModeEnum.debitCard.toString()
                        ? Column(
                            children: [
                              PaymentMethodWidget(),
                              const SizedBox(height: 30),
                              CreditDebitCardWidget(
                                  radioButton: _radioButton,
                                  card1CVVController: _card1CVVController),
                            ],
                          )
                        : SizedBox(),

                    // const SizedBox(height: 20),
                    // CreditDebitCardWidget(
                    //     radioButton: _radioButton,
                    //     card1CVVController: _card1CVVController),

                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.5,
                        Container(
                          height: 82,
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              vm.addressLoader
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return AlertDialog(
                                        //       title:
                                        //           const Text("Select Address"),
                                        //       content: Container(
                                        //           height: 200,
                                        //           width: Get.width,
                                        //           child: Expanded(
                                        //             child: ListView.builder(
                                        //               itemCount:
                                        //                   vm.address.length,
                                        //               itemBuilder:
                                        //                   (context, i) {
                                        //                 return
                                        //                     // InkWell(
                                        //                     //   onTap: () {
                                        //                     //     vm.selectedAddress =
                                        //                     //         vm.address[i];
                                        //                     //     vm.update();
                                        //                     //     Get.back();
                                        //                     //   },
                                        //                     //   child:
                                        //                     AddressWidget(
                                        //                         i: i,
                                        //                         isPayment:
                                        //                             true);
                                        //                 // );
                                        //               },
                                        //             ),
                                        //           )),
                                        //     );
                                        //   },
                                        // );
                                      },
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: Get.width - 100,
                                                child: RichText(
                                                  maxLines: 2,
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  Get.context!)
                                                              .primaryColor,
                                                          fontSize: 12),
                                                      text: vm.selectedAddress!
                                                          .addressLine1),
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              SizedBox(
                                                width: Get.width - 100,
                                                child: RichText(
                                                  maxLines: 2,
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  Get.context!)
                                                              .primaryColor,
                                                          fontSize: 12),
                                                      text: vm.selectedAddress!
                                                          .addressLine2),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 20,
                                          )
                                        ],
                                      ))
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Payment",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                                // "₹ ${vm.getDates(widget.price).toStringAsFixed(2)}",
                                "₹ ${widget.price}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold))
                          ],
                        )),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: FadeAnimation(
              1.4,
              Container(
                height: 65,
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: InkWell(
                  onTap: _isLoading
                      ? null
                      : () {
                          // pay();
                          // if (vm.startAndEndDate.isEmpty) {
                          //   showSelectAlertDialog(context);
                          // } else {
                          showAlertDialog(context, HomeVM,
                              vm.selectedAddress!.addressLine1);
                          // }
                        },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      // Colors.yellow[700],
                      borderRadius: BorderRadius.circular(30),
                      // color: Colors.grey[900],
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: _isLoading
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                strokeWidth: 3,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              "Pay",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
    });
  }

  Widget showPickedDates(context, DateTime start, DateTime end) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: InkWell(
                onTap: () {
                  // vm.pickDates(context);
                },
                child: Column(
                  children: [
                    const Text(
                      "Start Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          // color: HexColor('#707070'),
                          color: Colors.green,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 120,
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: 5,
                                spreadRadius: -4,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.09, 0.02],
                                colors: [Colors.green, Colors.white]),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  start.day.toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                // Text(
                                //   "${vm.monthList[start.month - 1]} ${start.year}",
                                //   style: const TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     fontSize: 12,
                                //   ),
                                // ),
                                const Divider(),
                                Text(
                                  "${start.hour}:${start.minute}",
                                  style: const TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 120,
                child: Icon(
                  Icons.arrow_right_rounded,
                  size: 50,
                  color: AppColors.blackColor,
                ),
                // color: AppColors.accentColor,
              ),
            ),
            SizedBox(
              child: InkWell(
                onTap: () {
                  // vm.pickDates(context);
                },
                child: Column(
                  children: [
                    const Text(
                      "End Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          // color: HexColor('#707070'),
                          color: Colors.red,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(children: [
                      Container(
                        width: 80,
                        height: 120,
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 5,
                              spreadRadius: -4,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.09, 0.02],
                              colors: [Colors.red, Colors.white]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                end.day.toString(),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              // Text(
                              //   "${vm.monthList[end.month - 1]} ${end.year}",
                              //   style: const TextStyle(
                              //     fontWeight: FontWeight.w500,
                              //     fontSize: 12,
                              //   ),
                              // ),
                              const Divider(),
                              Text(
                                "${end.hour}:${end.minute}",
                                style: const TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          // color: AppColors.white,
          width: Get.width,
          height: 50,
          child: const Center(),
        )
      ]),
    );
  }
}

class CreditDebitCardWidget extends StatelessWidget {
  const CreditDebitCardWidget({
    Key? key,
    required bool radioButton,
    required TextEditingController card1CVVController,
  })  : _radioButton = radioButton,
        _card1CVVController = card1CVVController,
        super(key: key);

  final bool _radioButton;
  final TextEditingController _card1CVVController;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.4,
      Container(
          height: 100,
          width: Get.width - 20,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          child:
              // Container(
              // child:
              Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                      value: _radioButton,
                      onChanged: (val) {
                        // _radioButton = val!;
                        // setState(() {});
                      }),
                  // const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("**** **** **** 1234"),
                      // const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text("Enter CVV(?) : "),
                          // const SizedBox(height: 5),
                          SizedBox(
                            height: 30,
                            width: 50,
                            child: TextFormField(
                              controller: _card1CVVController,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                              decoration: const InputDecoration(
                                  hintText: "**** **** **** 1234",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  counterText: '',
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Image.asset(
                'assets/images/mastercard-logo.png',
                height: 50,
              ),
            ],
          )),
      // ),
    );
  }
}
