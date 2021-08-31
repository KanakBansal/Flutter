import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/register_screen.dart';

//final FirebaseAuth widget.auth = FirebaseAuth.instance;

class SignupWithEmail extends StatefulWidget {
  const SignupWithEmail({Key? key,required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  @override
  _SignupWithEmailState createState() => _SignupWithEmailState();
}

class _SignupWithEmailState extends State<SignupWithEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    super.initState();
  }

  String? password;
  bool isPasswordVisible = true;
  bool _loading = false;

  _signInWithEmailPassword() async {
    setState(() {
      _loading = true;
    });

    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      await widget.auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      //or
      //print("Error is $e");
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        _loading = false;
      });
    }
    await Future.delayed(Duration(seconds: 2));
  }

  String? emailValidator(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Please Enter valid Email';
    else
      return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign up"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Sign Up to Continue!!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.mail),
                    suffixIcon: _emailController.text.isEmpty
                        ? null
                        : IconButton(
                      onPressed: () {
                        _emailController.clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  validator: emailValidator,
                  //     (String? value) {
                  //   emailValidator
                  //   // if (emailValidator(value!) != null) {
                  //   //   return "Please enter value";
                  //   // }
                  // },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _passwordController,
                  autofocus: false,
                  obscureText: isPasswordVisible,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isPasswordVisible = !isPasswordVisible;
                        setState(() {});
                      },
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    // _passwordController.text.isEmpty
                    //     ? null
                    //     : IconButton(
                    //         onPressed: () {
                    //           _passwordController.clear();
                    //         },
                    //         icon: Icon(Icons.visibility_off),
                    //       ),
                  ),
                  //obscureText: true,
                  validator: (String? value) {
                    if (value != null && value.isEmpty)
                      return "Please enter value";
                  },
                ),
                SizedBox(height: 30),
                _loading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signInWithEmailPassword();
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => RegisterWithEmail(),
                    //   ),
                    // );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RegisterWithEmail(auth: widget.auth,)));
                  },
                  child: Text(
                    "Don't have Account? Register!!",
                    style: TextStyle(
                      fontSize: 15,
                      //color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}