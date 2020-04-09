import 'package:firebase_auth/firebase_auth.dart';
import 'package:permitappbw/models/settings.dart';
import 'package:permitappbw/models/user.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  User user;
  Settings settings;

  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
  });
}