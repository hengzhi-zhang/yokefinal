import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settings_pages/preferences_page.dart';

class AuthScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            // The user is authenticated, navigate to the home page
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed('/home');
            });
            return SizedBox.shrink(); // Empty widget
          } else {
            // The user is not authenticated, show the SignInScreen
            final providers = [EmailAuthProvider()];

            return SignInScreen(
              providers: providers,
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) async {
                  // Check if the user's document exists in Firestore
                  final userDoc = await FirebaseFirestore.instance.collection('users').doc(state.user?.uid).get();
                  if (!userDoc.exists) {
                    // Ask for user name if the document doesn't exist
                    final name = await _getUserName(context);
                    if (name != null) {
                      // Add user's name to Firestore
                      await FirebaseFirestore.instance.collection('users').doc(state.user?.uid).set({
                        'name': name,
                      });

                      // Update the user's display name in Firebase Authentication
                      if (state.user != null) {
                        await state.user!.updateDisplayName(name);
                        await state.user!.reload();
                      }
                    }
                  }
                }),
              ],
            );
          }
        }
        // Show a progress indicator while the authentication state is being checked
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String?> _getUserName(BuildContext context) async {
    String? name;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter your name"),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return name;
  }

  // This function creates a new user in Firebase Authentication with the given email and password.
  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
}












// If you want a separate profile screen, you can define it here, or you can remove it if not needed.




