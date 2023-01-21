import 'package:flutter/material.dart';
import 'package:flutter_customer_app/widgets/text_field.dart';
import '../screens/sign_in_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5, left: 10),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: const DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/shop_cart.jpg'))),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                'Xoş Gəlmişsiniz!',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                'Qeydiyyatdan keçin!',
                style:
                    TextStyle(fontSize: 20, color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextInput(ctx: context),
          ],
        ),
      )),
    );
  }
}
