import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:permitappbw/models/permit.dart';
import 'package:permitappbw/models/settings.dart';
import 'package:permitappbw/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<DocumentSnapshot> getUserData(String useId);
  Future<void> addData(User user);
  Future<void> addPermit(Permit permit);
  Future<void> addSpecialPermit(Permit permit);
  Future<void> sendEmailVerification();
  Future<void> forgotPasswordEmail(String email);
  Future<void> signOut();
  Future<bool> isEmailVerified();
  String getExceptionText(Exception e);
}

class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

   Future<String> signUp(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
   Future<void> signOut() async {
     return _firebaseAuth.signOut();
   }
   Future<void> sendEmailVerification() async {
     FirebaseUser user = await _firebaseAuth.currentUser();
     user.sendEmailVerification();
   }

   void addUserSettingsDB(User user) async {
    checkUserExist(user.id).then((value) {
      if (!value) {
        print("user ${user.fullName} ${user.email} added");
        Firestore.instance
            .document("users/${user.id}")
            .setData(user.toJson());
        _addSettings(new Settings(
          settingsId: user.id,
        ));
      } else {
        print("user ${user.fullName} ${user.email} exists");
      }
    });
  }

   Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("applicants/$userId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

   void _addSettings(Settings settings) async {
    Firestore.instance
        .document("settings/${settings.settingsId}")
        .setData(settings.toJson());
  }

   Future<String> signIn(String email, String password) async {
    AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

   Future<User> getUserFirestore(String userId) async {
    if (userId != null) {
      return Firestore.instance
          .collection('users')
          .document(userId)
          .get()
          .then((documentSnapshot) => User.fromDocument(documentSnapshot));
    } else {
      print('firestore userId can not be null');
      return null;
    }
  }

   Future<Settings> getSettingsFirestore(String settingsId) async {
    if (settingsId != null) {
      return Firestore.instance
          .collection('settings')
          .document(settingsId)
          .get()
          .then((documentSnapshot) => Settings.fromDocument(documentSnapshot));
    } else {
      print('no firestore settings available');
      return null;
    }
  }

   Future<String> storeUserLocal(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(user);
    await prefs.setString('user', storeUser);
    return user.id;
  }

   Future<String> storeSettingsLocal(Settings settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeSettings = settingsToJson(settings);
    await prefs.setString('settings', storeSettings);
    return settings.settingsId;
  }

   Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

   Future<User> getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      User user = userFromJson(prefs.getString('user'));
      //print('USER: $user');
      return user;
    } else {
      return null;
    }
  }

   Future<Settings> getSettingsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('settings') != null) {
      Settings settings = settingsFromJson(prefs.getString('settings'));
      //print('SETTINGS: $settings');
      return settings;
    } else {
      return null;
    }
  }
   Future<void> addData(User user) async{
    getCurrentUser().then((value){
      if(value != null){
        print("applicants ${user.fullName} ${user.email} added");
        Firestore.instance
            .collection("applicants")
            .document(value.uid).setData(
          {
            "fullname": user.fullName,
            "location": user.location,
            "gender": user.gender,
            "identificationNum": user.identificationNum,
            "nationality": user.nationality,
            "dateOfBirth": user.dateOfBirth,
            "physicalAddress": user.physicalAddress,
            //"email": user.email,
            "phone": user.phone,
          }
        );
      }
    }
    );
  }

//  Future<void> addEssentialPermit(Permit permit) async{
//    getCurrentUser().then((value){
//      if(value!= null){
//        Firestore.instance
//            .collection('users')
//            .document(value.uid)
//            .collection('permits')
//            .document().setData(permit.toEssential());
//      }
//    });
//  }
  Future<void> addPermit(Permit permit) async{
    getCurrentUser().then((value){
      if(value!= null){
        Firestore.instance
            .collection('permits')
            .document().setData(permit.toJSON());
      }
    }
    );
  }
  Future<void> addSpecialPermit(Permit permit) async{
    getCurrentUser().then((value){
      if(value!= null){
        Firestore.instance
            .collection('permits')
            .document().setData(permit.toJSONSpecial());
      }
    }
    );
  }

  Future<DocumentSnapshot> getUserData(String userId) async{
     return Firestore.instance.collection("users").document(userId).get();
  }

//  CreateListofCourses(QuerySnapshot snapshot)async
//  {
//    var docs = snapshot.documents;
//    for (var Doc in docs)
//    {
//      FinalUserInfo.add(User.fromDocument(Doc));
//    }
//  }

   void addUser(User user) async {
    checkUserExist(user.id).then((value) {
      if (!value) {
        print("user ${user.fullName} ${user.email} added");
        Firestore.instance
            .document("users/${user.id}")
            .setData(user.toJson());
      } else {
        print("user ${user.fullName} ${user.email} exists");
      }
    });
  }

   Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

   String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

/*static Stream<User> getUserFirestore(String userId) {
    print("...getUserFirestore...");
    if (userId != null) {
      //try firestore
      return Firestore.instance
          .collection("users")
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.documents.map((doc) {
          return User.fromDocument(doc);
        }).first;
      });
    } else {
      print('firestore user not found');
      return null;
    }
  }*/

/*static Stream<Settings> getSettingsFirestore(String settingsId) {
    print("...getSettingsFirestore...");
    if (settingsId != null) {
      //try firestore
      return Firestore.instance
          .collection("settings")
          .where("settingsId", isEqualTo: settingsId)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.documents.map((doc) {
          return Settings.fromDocument(doc);
        }).first;
      });
    } else {
      print('no firestore settings available');
      return null;
    }
  }*/
}