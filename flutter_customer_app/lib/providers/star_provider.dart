import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class StarAndOpinionSender with ChangeNotifier {
  void sendStarToBackend(double starValue, String customerOpinion) async {
    final url = Uri.parse(
        'https://survey-app-96143-default-rtdb.firebaseio.com/stars/${FirebaseAuth.instance.currentUser!.uid}.json');
    http.post(url,
        body: json.encode({
          'userEmail': FirebaseAuth.instance.currentUser!.email,
          'starValue': starValue,
          'customerOpinion': customerOpinion
        }));
  }
}
