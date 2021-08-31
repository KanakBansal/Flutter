//import 'package:firebasewidget.auth/firebasewidget.auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//  import 'package:fl_chart/fl_chart.dart';
import 'package:my_expense_manager/api/firebaseDatabase.dart';
import 'package:my_expense_manager/screens/EnterDataScreen.dart';
import 'package:my_expense_manager/screens/ProfileScreen.dart';
//import 'package:my_expense_manager/screens/ProfileScreen.dart';

//FirebaseAuth widget.auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  _signOut() async {
    await widget.auth.signOut();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final photoUrl = widget.auth.currentUser!.photoURL;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     _signOut();
          //   },
          //   child: Text(
          //     "Logout",
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // SizedBox(width: 10),
          // CircleAvatar(
          //   radius: 15,
          //   child: photoUrl == null
          //       ? Text(
          //           "${widget.auth.currentUser!.displayName!.substring(0, 1).toUpperCase()}",
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //           ),
          //         )
          //       : Image.network(photoUrl),
          // ),
          // SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(auth: widget.auth),
                ),
              );
            },
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 15,
                child: photoUrl == null
                    ? Text(
                        "${widget.auth.currentUser!.displayName!.substring(0, 1).toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(photoUrl),
                      ),
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (String value) {
              if (value == "logout") {
                _signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "logout", child: Text("Logout")),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database.read2(widget.auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          // if (snapshot.connectionState == ConnectionState.done) {
          //   final QuerySnapshot querySnapshot = snapshot.data;
          //   final List<DocumentSnapshot> documents = querySnapshot.docs;

          if (snapshot.hasData) {
            //snapshot.data!.docs;
            final QuerySnapshot querySnapshot = snapshot.data;
            final List<DocumentSnapshot> documents = querySnapshot.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                        child: ListTile(
                          //leading: Text("${doc['type']}"),
                          leading: Text("${doc['type']}"),
                          title: Text("Amount : ${doc['amount']}"),
                          subtitle: Text("${doc['date']}"),
                          trailing: Text("${doc['category']}"),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Expanded(
                          //       flex: 4,
                          //       child: Text("${doc['category']}"),
                          //     ),
                          //     // Expanded(
                          //     //   flex: 6,
                          //     //   child: TextButton(
                          //     //     onPressed: () {
                          //     //       Database.delete(widget.auth.currentUser!.uid);
                          //     //     },
                          //     //     child: Text("Delete"),
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
                        ),
                      ),
                    )
                    .toList());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterDataScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
