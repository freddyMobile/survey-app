import 'package:flutter/material.dart';
import 'package:flutter_customer_app/models/question_model.dart';
import 'package:provider/provider.dart';
import '../providers/answer_send.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChoiceButtons extends StatefulWidget {
  List<dynamic> possibleAnswers;
  String idQuestion;
  int? tappedIndexButton = 0;
  bool _isTapped = false;
  ChoiceButtons(
      {super.key, required this.possibleAnswers, required this.idQuestion});

  @override
  State<ChoiceButtons> createState() => _ChoiceButtonsState();
}

class _ChoiceButtonsState extends State<ChoiceButtons> {
  @override
  Widget build(BuildContext context) {
    var answerSendProvider = Provider.of<AnswerSend>(context);
    return Expanded(
      flex: 2,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: Theme.of(context).primaryColor,
              onTap: () {
                setState(() {
                  widget._isTapped = !widget._isTapped;
                  widget.tappedIndexButton = index;
                });
                answerSendProvider.putAnswersToBackend(
                    widget.idQuestion, widget.possibleAnswers[index]);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: widget._isTapped == true &&
                            widget.tappedIndexButton == index
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 3, color: Theme.of(context).primaryColor)),
                child: Center(
                  child: Text(
                    widget.possibleAnswers[index],
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
          itemCount: widget.possibleAnswers.length),
    );
  }
}
