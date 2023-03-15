import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentlyAddeddSeeMore extends StatelessWidget {
  RecentlyAddeddSeeMore(
      {super.key, required this.list, required this.onPressed});

  List<BookModel> list;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
        body: ListView.separated(
            controller: vm.infiniteScrollController,
            itemCount: list.length + 1,
            separatorBuilder: (context, i) {
              return SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, i) {
              if (i < list.length) {
                return Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(list[i].image1.url),
                          fit: BoxFit.cover)),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      );
    });
  }
}
