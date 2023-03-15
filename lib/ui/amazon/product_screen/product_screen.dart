import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookmark/ui/amazon/product_screen/product_vm.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductView vm = Get.put(ProductView());
    return GetBuilder<ProductView>(builder: (vm) {
      return Scaffold(
          appBar: AppBar(title: const Text("products")),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemBuilder: (context, i) {
                    return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 0.09,
                            ),
                          ],
                        ),
                        width: Get.width - 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                    image: Image.network(vm
                                                .mobileList[2 * i].thumbnail ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRG8ctV0Q7E3NvKthlB9191ZM42SSwy8lY7w&usqp=CAU")
                                        .image,
                                    fit: BoxFit.contain),
                              ),
                              width: 110,
                              // child: Container(
                              //   width: 150,
                              height: 150,
                              //   decoration: BoxDecoration(
                              //       image: DecorationImage(
                              //           image: Image.network(vm
                              //                       .mobileList[2 * i]
                              //                       .thumbnail ??
                              //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRG8ctV0Q7E3NvKthlB9191ZM42SSwy8lY7w&usqp=CAU")
                              //               .image)),
                              // ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: Get.width - 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: vm.mobileList[2 * i].title!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color:
                                              Color.fromARGB(255, 241, 205, 0)),
                                      const SizedBox(width: 5),
                                      Text(vm.mobileList[2 * i].reviews!.rating
                                          .toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                          "₹ ${((vm.mobileList[2 * i].price!.currentPrice!) * 79.0).round()}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const SizedBox(width: 5),
                                      Text(
                                          "₹ ${((vm.mobileList[2 * i].price!.currentPrice!) * 79.0 * 1.7).round()}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  vm.mobileList[i].price!.discounted!
                                      ? const Text("Limited Offer",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                          ))
                                      : Text("")
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 25);
                  },
                  itemCount: (vm.mobileList.length) ~/ 2));
    });
  }
}
