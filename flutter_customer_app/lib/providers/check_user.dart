import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class CheckUser with ChangeNotifier {
  Future<bool> fetchAndCheckUser() async {
    try {
      final url = Uri.parse(
          'https://survey-app-96143-default-rtdb.firebaseio.com/stars/${FirebaseAuth.instance.currentUser!.uid}.json');
      var response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>?;

      if ( extractedData==null) {
      
        return false;
      } else {
        return true;
      }
    } catch (error) {
      throw error;
    }
  }
}
