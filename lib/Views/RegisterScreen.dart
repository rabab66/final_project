import 'package:finalproject/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
  import '../Models/User.dart';
import '../Utils/Utils.dart';
import 'package:http/http.dart' as http;
import '../Utils/constants.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});
  final String title;
  @override
  State<RegisterScreen> createState() => RegisterscreenPageState();
}
class RegisterscreenPageState extends State<RegisterScreen> {
  final _txtFullName = TextEditingController();
  final _txtPassword = TextEditingController();
  final _txtEmail = TextEditingController();

  void insertUserFunc(BuildContext context, String UserName, String Email, String Password) {
    if (_txtFullName.text != "" && _txtEmail.text != "" &&  _txtPassword.text != "" ) {
      var us = new User();
      us.fullName = _txtFullName.text;
      us.email = _txtEmail.text;
      us.password = _txtPassword.text;
      insertUser(context, us);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePageScreen(title: "HomePage")),
      );
    }
    else {
      var uti = new Utils();
      uti.showMyDialog(context, "Required", "Please insert all the details");
    }
  }




  Future insertUser(BuildContext context, User us) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
    var url = "users/insertUser.php?fullName=" + us.fullName + "&email=" + us.email +
        "&password=" + us.password;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath+url);
    //setState(() { });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF64B5F6),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueAccent),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _txtFullName,
                  decoration: InputDecoration(
                    hintText: 'Enter your fullName',
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueAccent),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blueAccent),
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
                    insertUserFunc(
                      context,
                      _txtFullName.text,
                      _txtEmail.text,
                      _txtPassword.text
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor : Color(0xFF64B5F6), // Green color for the button
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
