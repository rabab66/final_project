import 'package:finalproject/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/Utils/db.dart';
import '../Models/User.dart';
import '../Utils/Utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});

  final String title;

  @override
  State<RegisterScreen> createState() => RegisterscreenPageState();
}

class RegisterscreenPageState extends State<RegisterScreen> {
  final _txtUserName = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtEmail = TextEditingController();

  void insertUserFunc() {
    if (_txtUserName.text != "") {
      var us = new User();
      us.name = _txtUserName.text;
      us.email = _txtEmail.text;
      us.password = _txtPassword.text;
      insertUser(us);
      var uti = new Utils();
      uti.showMyDialog(context, "success", "You have registered successfully");
      _txtUserName.clear();
      _txtEmail.clear();
      _txtPassword.clear();
    } else {
      var uti = new Utils();
      uti.showMyDialog(context, "Required", "Please insert your username");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E7D32),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Username",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _txtUserName,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _txtEmail,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _txtPassword,
                  obscureText: true, // To hide the password text
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    insertUserFunc();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePageScreen(title: "HomePage")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor : Color(0xFF2E7D32), // Green color for the button
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
