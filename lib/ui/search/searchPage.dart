import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DiningVM vm = Get.isRegistered<DiningVM>() ? Get.find() : Get.put(DiningVM());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: GetBuilder<DiningVM>(builder: (vm) {
        return Container(
            child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: vm.searchController,
                    onChanged: (value) => vm.runSearch(value),
                    decoration: InputDecoration(
                      fillColor:
                          Theme.of(context).backgroundColor.withOpacity(0.4),
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            Divider(thickness: 2),
            Expanded(
              child: ListView.builder(
                itemCount: vm.tempSearchList.length > 15
                    ? 15
                    : vm.tempSearchList.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      vm.searchController.text = vm.tempSearchList[i];
                      vm.userTapOnSearch(vm.tempSearchList[i]);
                    },
                    child: ListTile(
                      title: Text(vm.tempSearchList[i]),
                      leading: Icon(vm.searchController.text.isEmpty
                          ? Icons.history
                          : Icons.search),
                      trailing: const Icon(CupertinoIcons.arrow_up_left),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
      }),
    ));
  }
}
