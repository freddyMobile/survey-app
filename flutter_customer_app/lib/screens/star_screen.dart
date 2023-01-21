import 'package:flutter/material.dart';
import 'package:flutter_customer_app/widgets/star_widget.dart';

class StarScreen extends StatelessWidget {
  static String route = '/starscreen';
  const StarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Sizin şərhiniz...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 250, 250, 250)),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 250, 250, 250),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/feedback.png'))),
                ),
                const StarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
