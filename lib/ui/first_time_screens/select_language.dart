import 'package:bookmark/ui/first_time_screens/first_time_vm.dart';
import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLanguage extends StatelessWidget {
  SelectLanguage({super.key});

  FirstTimeVM vm =
      Get.isRegistered<FirstTimeVM>() ? Get.find() : Get.put(FirstTimeVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstTimeVM>(builder: (vm) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Select Language',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              vm.languageList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 100.0 * (vm.languageList.length ~/ 2),
                      child: ListView.builder(
                        itemCount: vm.languageList.length ~/ 2,
                        itemBuilder: (context, i) {
                          return Row(
                            children: [
                              SelectLanguageContainer(i: 2 * i),
                              const SizedBox(width: 20),
                              SelectLanguageContainer(i: 2 * i + 1),
                            ],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 140,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return Container(
                        height: 30,
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(Get.context!).primaryColor,
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Center(
                          child: Text(
                            vm.selectedLanguageList[i].language,
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                  },
                  itemCount: vm.selectedLanguageList.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('skip'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SelectLanguageContainer extends StatelessWidget {
  SelectLanguageContainer({
    Key? key,
    required this.i,
  }) : super(key: key);
  int i;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FirstTimeVM>(builder: (vm) {
      return Expanded(
        child: InkWell(
          onTap: () {
            vm.addAndRemoveLang(vm.languageList[i]);
            // vm.selectLanguage('en');
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                  color: vm.isLangSelected(vm.languageList[i])
                      ? Colors.blueAccent
                      : Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vm.languageList[i].language,
                  style: TextStyle(
                    fontWeight: vm.isLangSelected(vm.languageList[i])
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: vm.isLangSelected(vm.languageList[i])
                        ? Colors.blueAccent
                        : Colors.grey,
                  ),
                ),
                Icon(
                  Icons.check,
                  color: vm.isLangSelected(vm.languageList[i])
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
