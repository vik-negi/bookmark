import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentlyAddeddSeeMore extends StatelessWidget {
  RecentlyAddeddSeeMore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Recently Added"),
        ),
        body: ListView.separated(
            controller: vm.infiniteScrollController,
            itemCount: (vm.list.length ~/ 2).ceil() + 1,
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 20,
              );
            },
            itemBuilder: (context, i) {
              if (2 * i < vm.list.length) {
                print(vm.list.length);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    2 * i < vm.list.length
                        ? seeMoreBook(image: vm.list[2 * i].image1.url)
                        : SizedBox(),
                    2 * i + 1 < vm.list.length
                        ? seeMoreBook(image: vm.list[2 * i + 1].image1.url)
                        : SizedBox(),
                  ],
                );
              } else {
                return 2 * i > 8
                    ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox();
              }
            }),
      );
    });
  }
}

class seeMoreBook extends StatelessWidget {
  const seeMoreBook({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
