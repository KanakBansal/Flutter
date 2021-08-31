import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_manager/SignupWithEmail.dart';


//final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterWithEmail extends StatefulWidget {
  const RegisterWithEmail({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  @override
  _RegisterWithEmailState createState() => _RegisterWithEmailState();
}

class _RegisterWithEmailState extends State<RegisterWithEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
    super.initState();
  }

  String? password;
  bool isPasswordVisible = true;
  bool _isloading = false;

  _registerWithEmailPassword() async {
    setState(() {
      _isloading = true;
    });

    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String name = _nameController.text;


      // print("Email is $email");
      // print("password is $password");
      // print("Name is $name");

      final credential = await widget.auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateDisplayName(name);

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      //or
      //print("Error is $e");
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        _isloading = false;
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
    _nameController.dispose();
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
                    "Register to Continue!!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Name",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.account_box),
                    suffixIcon: _nameController.text.isEmpty
                        ? null
                        : IconButton(
                      onPressed: () {
                        _nameController.clear();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  //validator: emailValidator,
                  //     (String? value) {
                  //   emailValidator
                  //   // if (emailValidator(value!) != null) {
                  //   //   return "Please enter value";
                  //   // }
                  // },
                  validator: (String? value) {
                    if (value != null && value.isEmpty)
                      return "Please enter value";
                  },
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
                _isloading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registerWithEmailPassword();
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignupWithEmail(auth: widget.auth,)));
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => SignupWithEmail(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "Already have an Account? Signup!!",
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