import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/question_fetch.dart';
import '../screens/survey_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/check_user.dart';

class StartScreen extends StatelessWidget {
  static String route = '/start';
  StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var question = Provider.of<QuestionFetch>(context);

    var userCheckProvider = Provider.of<CheckUser>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))
          ],
          title: Text(
            'Xoş gəlibsiniz',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/check-list.png'))),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text(
              'Sorğuda iştirak etmək üçün \nbaşla düyməsinə basın!',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              'Sorğu bitdikdən sonra,xidmətimizi necə\ndəyərləndirdiyinizi bizimlə bölüşün',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'RobotoCondensed',
                  //fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () async {
                  bool result =
                      await Provider.of<CheckUser>(context, listen: false)
                          .fetchAndCheckUser();
                  if (result == false) {
                    Navigator.of(context).pushNamed(SurveyScreen.route);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).errorColor,
                        content: const Text(
                          'Siz artıq sorğuda iştirak edibsiz...',
                          textAlign: TextAlign.center,
                        )));
                  }
                },
                child: const Text('Başla')),
          )
        ]));
  }
}
