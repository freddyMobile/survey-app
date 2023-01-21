import 'package:flutter/material.dart';
import 'package:flutter_customer_app/screens/sign_up_screen.dart';
import 'package:flutter_customer_app/screens/start_screen.dart';
import 'package:flutter_customer_app/screens/survey_screen.dart';
import './screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './providers/question_fetch.dart';
import './providers/answer_send.dart';
import './screens/star_screen.dart';
import './providers/star_provider.dart';
import './providers/check_user.dart';

//import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: QuestionFetch(),
        ),
        ChangeNotifierProvider.value(value: AnswerSend()),
        ChangeNotifierProvider.value(value: StarAndOpinionSender()),
        ChangeNotifierProvider.value(value: CheckUser()),
      ],
      child: MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StartScreen();
            }
            return const SignUp();
          },
        ),
        routes: {
          //'/': (context) => const SignUp(),
          SignIn.route: (context) => StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return StartScreen();
                  }
                  return const SignIn();
                },
              ),

          SurveyScreen.route: (context) => const SurveyScreen(),
          StarScreen.route: (context) => const StarScreen(),
        },
        color: Theme.of(context).canvasColor,
        theme: ThemeData(
            fontFamily: 'RobotoCondensed-Italic',
            hintColor: const Color.fromARGB(255, 0, 0, 0),
            canvasColor: const Color.fromARGB(255, 255, 255, 255),
            primaryColor: const Color.fromARGB(255, 44, 187, 176),
            accentColor: const Color.fromARGB(255, 110, 110, 111)),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
