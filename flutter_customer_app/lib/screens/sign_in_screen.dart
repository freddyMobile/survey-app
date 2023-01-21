import 'package:flutter/material.dart';
import '../widgets/text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  static String route = '/signIn';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            centerTitle: true,
            title: Container(
              margin: const EdgeInsets.only(top: 5, left: 10),
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: const DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/shop_cart.jpg'))),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close_outlined,
                  color: Theme.of(context).primaryColor,
                ))),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                  'Hesabınıza daxil olaraq sorğuda \niştirak edin!',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).hintColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/check-list.png'))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextInput(fullNameEnabled: false,ctx: context),
            ],
          ),
        ),
      ),
    );

    ;
  }
}
