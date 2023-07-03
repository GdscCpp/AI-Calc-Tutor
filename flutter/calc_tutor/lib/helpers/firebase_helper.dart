import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Helper functions for using Firebase. Most functions are async and require
/// the use of await.
class FirebaseHelpers {
  /// Returns all documents from a given [collectionName].When using this
  /// function, be sure to use await in order to get the data,
  /// otherwise an instance of '_Future<List<Object?>>' will be returned
  static Future<List<Object?>> getAllDocsFromCollection(
      String collectionName) async {
    //get a reference to the collection
    
    var ref = FirebaseFirestore.instance.collection(collectionName);

    //grab a snapshot of the collection
    QuerySnapshot qs = await ref.get();

    //map the data to a list that can be used
    final allData = qs.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  /// Short function for checking whether a user is signed in, returns true
  /// or false depending on the current auth state
  static bool checkAuthState() {
    bool authState = false;
    if (FirebaseAuth.instance.currentUser != null) {
      authState = true;
    }

    return authState;
  }

  /// Function for signing-in a user using firebase
  static Future<bool> authUser(String email, String password) async {
    bool state = true;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      //this can be replaced with text code, Text() elements, etc and return a
      // dynamic type
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      state = false;
    }

    return state;
  }

  /// Helper function for creating a new user in firebase using [email] and
  /// [pass]
  static Future<String> createUser(
      String fName, String lName, String email, String pass) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    }
    //error handling
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Password too weak";
      } else if (e.code == 'email-already-in-use') {
        return "Email already taken";
      }
    } catch (e) {
      return e.toString();
    }

    //update display name in firebase
    FirebaseAuth.instance.currentUser?.updateDisplayName(fName + lName);

    return 'success';
  }
}
