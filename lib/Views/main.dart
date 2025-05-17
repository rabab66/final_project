import 'dart:convert';
import 'dart:io';
import 'package:finalproject/Views/HomePageScreen.dart';
import 'package:finalproject/Views/RegisterScreen.dart';
import 'package:flutter/material.dart';
import '../Models/checkLoginModel.dart';
import '../Utils/Utils.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Login'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _txtEmail = TextEditingController();
  final _txtPassword = TextEditingController();


  Future checkLogin(BuildContext context) async {

    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String? token = prefs.getString("token");
    var url = "Login/CheckLogin.php?email=" + _txtEmail.text + "&password=" + _txtPassword.text;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    // setState(() { });
    // Navigator.pop(context);
    if(checkLoginModel.fromJson(jsonDecode(response.body)).userID == "0")
    {
      var uti = new Utils();
      uti.showMyDialog(context, "Error", "Email or password is wrong!!!");
    }
    else
    {
      // print("SharedPreferences 1");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', checkLoginModel.fromJson(jsonDecode(response.body)).userID!);
      await prefs.setString('email', _txtEmail.text);
      await prefs.setString('pass', _txtPassword.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePageScreen(title: "Home")),
      );
    }
  }



  checkConction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected to internet');// print(result);// return 1;
      }
    } on SocketException catch (_) {
      // print('not connected to internet');// print(result);
      var uti = new Utils();
      uti.showMyDialog(context, "אין אינטרנט", "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
      return;
    }
  }



  fillSavedPars()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _txtEmail.text = prefs.getString("email").toString();
    _txtPassword.text = prefs.get("pass").toString();
    if(_txtEmail.text != "" && _txtPassword.text != "" && _txtEmail.text != null)
    {
      // checkLogin(context);
    }
  }



  @override
  Widget build(BuildContext context) {

    checkConction();
    fillSavedPars();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF64B5F6),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(  // Make the body scrollable
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Email",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueAccent),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _txtEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:Colors.blueAccent),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _txtPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Handle login logic here
                    // For now, we will just navigate to the RegisterScreen
                    checkLogin(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF64B5F6), // Green color for the button
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: (


                  ) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen(title: "Register")),
                    );
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF2196F3)),
                  ),
                  child: Text(
                    'Create a new account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
