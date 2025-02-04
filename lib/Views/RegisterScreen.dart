import 'package:finalproject/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/Utils/db.dart';
import '../Models/User.dart';
import '../Utils/Utils.dart';


 /* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyC:\Users\omare\Downloads\flutterdart --version
HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}*/

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});


  final String title;

  @override
  State<RegisterScreen> createState() => RegisterscreenPageState();
}

class RegisterscreenPageState extends State<RegisterScreen> {
  int _counter = 0;

  final _txtUserName=TextEditingController();
  final _txtPassword=TextEditingController();
  final _txtEmail=TextEditingController();
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }


  void insertUserFunc() {
    if (_txtUserName.text != "") {
      var us = new User();
      us.name = _txtUserName.text;
      us.email = _txtEmail.text;
      us.password = _txtPassword.text;
      insertUser(us);
      var uti = new Utils();
      uti.showMyDialog(context, "success", "you registed successfully");
      _txtUserName.text = "";
      _txtEmail.text = "";
      _txtPassword.text = "";
      _txtPassword.text="";
    }
    else {
      var uti = new Utils();
      uti.showMyDialog(context, "Required", "Please insert First name");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text("username" ),
              TextField(
                controller: _txtUserName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'username:',
                ),
              ),

              Text("email" ),
              TextField(
                controller: _txtEmail,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'email:',
                ),
              ),
              Text("password" ),
              TextField(
                controller: _txtPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'phone number:',
                ),
              ),


              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                onPressed: () {
                  insertUserFunc();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePageScreen(title: "HomePage")),
                  );


                },
                child: Text('Next'),
              )
            ],
          ),
        ),
      ),


    );
   }
}
