import 'package:flutter/material.dart';
import 'package:flutter_customer_app/screens/sign_up_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../providers/star_provider.dart';
import '../screens/start_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StarWidget extends StatefulWidget {
  const StarWidget({super.key});

  @override
  State<StarWidget> createState() => _StarWidgetState();
}

class _StarWidgetState extends State<StarWidget> {
  final _controller = TextEditingController();
  String _enteredOpinion = '';
  double starValue = 0;
  @override
  Widget build(BuildContext context) {
    var starProvider =
        Provider.of<StarAndOpinionSender>(context, listen: false);

    return Container(
      color: const Color.fromARGB(255, 250, 250, 250),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Bizə qiymət verin',
            style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 40),
          ),
          const Text(
            'Xidmətimizdən razısınız?',
            style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24),
          ),
          RatingBar.builder(
            itemSize: 45,
            tapOnlyMode: true,
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              size: 40,
              color: Color.fromARGB(255, 227, 21, 21),
            ),
            onRatingUpdate: (rating) {
              starValue = rating;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Təklif və iradlarınızı qeyd edə bilərsiniz',
            style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(
              width: 3,
              color: const Color.fromARGB(255, 227, 21, 21),
            )),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Center(child: Text('Yazmağa başlayın...')),
              ),
              cursorColor: const Color.fromARGB(255, 227, 21, 21),
              maxLines: 40,
              onChanged: (value) {
                setState(() {
                  _enteredOpinion = value.toString();
                });
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartScreen()));*/
                final user = FirebaseAuth.instance.currentUser;
                FirebaseFirestore.instance.collection('surveyedCustomers').add({
                  'createdAt': Timestamp.now(),
                  'userId': user!.uid,
                  'userMail': user.email,
                });

                starProvider.sendStarToBackend(starValue, _enteredOpinion);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        actions: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 4, 170, 109))),
                              onPressed: () {
                                FirebaseAuth.instance.signOut().then((value) =>
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()),
                                        (route) => false));
                              },
                              child: const Text(
                                'bitir',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        ],
                        content: Container(
                          height: 150,
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: AssetImage(
                                            'assets/images/success.png'))),
                              ),
                              const Center(
                                child: Text(
                                  'Success!',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 4, 170, 109),
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 227, 21, 21),
                ),
              ),
              child: const Text(
                'Təstiq et',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
