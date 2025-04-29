import 'package:flutter/material.dart';


class EditProfileScreen extends StatefulWidget {
  const  EditProfileScreen({super.key, required this.title});

  final String title;

  @override
  State<EditProfileScreen> createState() => EditProfileScreenPageState();
}

class EditProfileScreenPageState extends State<EditProfileScreen> {

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'username:',
                ),
              ),

              Text("email" ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'email:',
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                ),
                onPressed: () {

                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),


    );
  }
}
