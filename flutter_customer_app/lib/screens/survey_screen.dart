import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customer_app/providers/answer_send.dart';
import 'package:flutter_customer_app/widgets/next_back_button.dart';
import '../providers/question_fetch.dart';
import 'package:provider/provider.dart';
import '../widgets/choice_buttons.dart';
import '../widgets/asked_questions.dart';
import '../screens/star_screen.dart';

class SurveyScreen extends StatefulWidget {
  static String route = '/survey';
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        },
      );
      await Provider.of<QuestionFetch>(context, listen: false)
          .fetchAndSetQuestions()
          .then((_) => Navigator.of(context).pop());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var qestionProvider = Provider.of<QuestionFetch>(context, listen: true);
    var answerProvider = Provider.of<AnswerSend>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                qestionProvider.makeEmptyQuestions();
                qestionProvider.index = 0;
                answerProvider.deleteAnswersFromBackend();
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              )),
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            'Survey',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Column(
          children: [
            if (qestionProvider.questions.isEmpty)
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  'Sual yüklənir...',
                  style: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
                ),
              ),
            if (qestionProvider.questions.isNotEmpty)
              AskedQuestions(i: qestionProvider.index),
            if (qestionProvider.questions.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            if (qestionProvider.questions.isNotEmpty)
              ChoiceButtons(
                  possibleAnswers: qestionProvider
                      .questions[qestionProvider.index].possibleAnswers,
                  idQuestion:
                      qestionProvider.questions[qestionProvider.index].id),
            if (qestionProvider.questions.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NextBackButton(
                        buttonLogic: qestionProvider.indexDecrease,
                        buttonBackgroundColor:
                            const Color.fromARGB(255, 241, 241, 241),
                        buttonTitle: 'Geriyə',
                        buttonIcon: const Icon(Icons.arrow_back),
                        buttonIconColor: Colors.black),
                    if (qestionProvider.index ==
                        qestionProvider.questions.length - 1)
                      NextBackButton(
                          buttonLogic: () {
                            Navigator.of(context)
                                .pushReplacementNamed(StarScreen.route);
                          }, //burada logici deyisecik...
                          buttonBackgroundColor:
                              const Color.fromARGB(255, 4, 170, 109),
                          buttonTitle: 'Təstiq et!',
                          buttonIcon: const Icon(Icons.save),
                          buttonIconColor: Colors.white),
                    if (qestionProvider.index !=
                        qestionProvider.questions.length - 1)
                      NextBackButton(
                          buttonLogic: qestionProvider.indexIncrement,
                          buttonBackgroundColor:
                              const Color.fromARGB(255, 4, 170, 109),
                          buttonTitle: 'Növbəti',
                          buttonIcon: const Icon(Icons.arrow_forward),
                          buttonIconColor: Colors.white),
                  ],
                ),
              ),
          ],
        ));
  }
}
