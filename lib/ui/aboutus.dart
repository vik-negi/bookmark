import 'package:flutter/material.dart';
import 'package:bookmark/widgets/my_drawer.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = '/about-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('About Us'),
      ),
      drawer: MyDrawer(),
      body: const Center(
        child: Text(
          'This is About page',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            // color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
