import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProvider extends ChangeNotifier {
  late CollectionReference _feedbacks;

  FirestoreProvider() {
    _feedbacks = FirebaseFirestore.instance.collection('feedbacks');
  }

  Future<void> sendFeedback(String feedback) => _feedbacks.add({
        'text': feedback,
      });
}
