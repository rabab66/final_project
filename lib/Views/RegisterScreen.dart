import 'package:finalproject/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';


 /* @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _txtPhoneNumber=TextEditingController();
  final _txtEmail=TextEditingController();
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
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

              Text("phone number" ),
              TextField(
                controller: _txtPhoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'phone number:',
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
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('AlertDialog Title'),
                    content:  Text(_txtUserName.text+"-"+ _txtPhoneNumber.text+"-"+ _txtEmail.text),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Login'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                onPressed: () {
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
