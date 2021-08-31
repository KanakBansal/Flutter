import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_expense_manager/SignupWithEmail.dart';
import 'package:my_expense_manager/screens/TermAndConditionScreen.dart';


//FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  _signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final userCredential =
      await widget.auth.signInWithCredential(googleAuthCredential);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Sign In with ${userCredential.user!.displayName}"),
        ),
      );
    } catch (e) {
      print(e.toString());
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Sign Up")),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Spacer(),
                //Center(child: FlutterLogo()),
                Spacer(),
                Text(
                  " Hi,\n Welcome to \n*Expense Manager App*",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  " Login to Continue",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: SignInButtonBuilder(
                        text: 'Sign in with Email',
                        //height: 50,
                        icon: Icons.email,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupWithEmail(auth : widget.auth),
                            ),
                          );
                        },
                        backgroundColor: Colors.blueGrey[700]!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SignInButton(
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () {
                          _signInWithGoogle();
                        },
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TermsAndCondition(),
                            ),
                          );
                        },
                        child: Text("Terms and Conditions Applied!!")))
                // child: Text.rich(
                //   TextSpan(
                //     text: "Terms and Conditions",
                //     children: [
                //       TextSpan(
                //         text: " Applied!!",
                //         style: TextStyle(
                //           color: Colors.purple,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 18,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}