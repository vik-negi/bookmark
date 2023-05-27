import 'package:bookmark/ui/animation/fade_animation.dart';
import 'package:bookmark/ui/main/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccess extends StatefulWidget {
  PaymentSuccess({Key? key, required this.paymentId, required this.orderId})
      : super(key: key);
  String orderId;
  String paymentId;

  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  void redirectToHome() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(() => HomeView());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(
            //   'https://ouch-cdn2.icons8.com/7fkWk5J2YcodnqGn62xOYYfkl6qhmsCfT2033W-FjaA/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMjU5/LzRkM2MyNzJlLWFh/MmQtNDA3Ni04YzU0/LTY0YjNiMzQ4NzQw/OS5zdmc.png',
            //   width: 250,
            // )
            Icon(Icons.check_circle_outline, size: 250, color: Colors.green),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              'Payment Success! 🥳',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Hooray! Your payment proccess has \n been completed successfully..',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 100.0),
            Text(
              'Here\'s your order details.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey.shade700),
            ),
            Divider(),
            // RichText(
            //     text: TextSpan(
            //         text: 'Order ID: ',
            //         style:
            //             TextStyle(fontSize: 16.0, color: Colors.grey.shade700),
            //         children: <TextSpan>[
            //       TextSpan(
            //           text: '${widget.orderId}',
            //           style: TextStyle(
            //               fontSize: 16.0,
            //               color: Colors.grey.shade700,
            //               fontWeight: FontWeight.bold))
            //     ])),
            // const SizedBox(height: 10.0),
            RichText(
                text: TextSpan(
                    text: 'Payment ID: ',
                    style:
                        TextStyle(fontSize: 16.0, color: Colors.grey.shade700),
                    children: <TextSpan>[
                  TextSpan(
                      text: '${widget.paymentId}',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold))
                ])),
            const SizedBox(height: 70.0),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeView()));
              },
              height: 50,
              elevation: 0,
              // splashColor: Colors.yellow[700],
              splashColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              // color: Colors.yellow[800],
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Thank you for shopping with us.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    ));
  }
}
