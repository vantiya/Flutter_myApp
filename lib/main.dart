// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "First Practice App!",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(
        title: "Welcome to My First Practice App",
        bodyText: "I'm now trying Firebase.",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.bodyText}) : super(key: key);

  final String title, bodyText;
  @override
  MyClassWidgetState createState() => MyClassWidgetState();
}

class MyClassWidgetState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential _authCred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final UserCredential authResult =
        await _auth.signInWithCredential(_authCred);

    final User user = authResult.user;
    if (user != null) {
      print("User Details: $user");
      return "$user";
    } else {
      print("Something Wrong!");
      return "";
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Signed Out!");
    // return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text("Login"),
              color: Colors.lightBlue,
              onPressed: signInWithGoogle,
            ),
            RaisedButton(
              child: Text("Logout"),
              color: Colors.lightBlue,
              onPressed: signOutGoogle,
            )
          ],
        ));
  }
}
