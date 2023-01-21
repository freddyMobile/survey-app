import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class AnswerSend with ChangeNotifier {
  List<Map> _userAnswers = [];

  List<Map> get userAnswers {
    return [..._userAnswers];
  }

  putAnswersToBackend(String questionId, String answer) async {
    try {
      final url = Uri.parse(
          'https://survey-app-96143-default-rtdb.firebaseio.com/answers/${FirebaseAuth.instance.currentUser!.uid}/$questionId.json');
      http.patch(url,
          body: json.encode({
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'userEmail': FirebaseAuth.instance.currentUser!.email,
            'questionId': questionId,
            'answer': answer,
          }));
    } catch (error) {
      throw error;
    }
  }

  deleteAnswersFromBackend() async {
    final url = Uri.parse(
        'https://survey-app-c0d8a-default-rtdb.firebaseio.com/answers/${FirebaseAuth.instance.currentUser!.uid}.json');
    http.delete(url);
  }
}
