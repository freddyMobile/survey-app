import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionFetch with ChangeNotifier {
  int index = 0;

  void indexIncrement() {
    if (index < _questions.length - 1) {
      index += 1;
      notifyListeners();
    }
  }

  void indexDecrease() {
    if (index > 0) {
      index -= 1;
      notifyListeners();
    }
  }

  List<QuestionModel> _questions = [];

  List<QuestionModel> get questions {
    return [..._questions];
  }

  Future<void> fetchAndSetQuestions() async {
    try {
      final url = Uri.parse(
          'https://survey-app-96143-default-rtdb.firebaseio.com/questions.json');
      final response = await http.get(url);
      final jsonQuestions = json.decode(response.body) as Map<String, dynamic>;
      jsonQuestions.forEach((questionId, questionValue) {
        _questions.add(QuestionModel(questionId, questionValue['title'],
            questionValue['possibleAnswers']));
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  void makeEmptyQuestions() {
    _questions = [];
    notifyListeners(); // we use it in order to get rid of reinstalling problem
  }
}
