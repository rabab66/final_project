import 'package:finalproject/Views/BasketScreen.dart';
import 'package:finalproject/Views/Search.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'EditProfileScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});


  final String title;

  @override
  State<HomePageScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.6,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.pink),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const EditProfileScreen(title: "Edit Profile"),
                      ),
                    );
                  },
                  child: Icon(Icons.account_circle),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: GNav(
                    backgroundColor: Colors.white,
                    color: Colors.pinkAccent,
                    activeColor: Colors.pinkAccent,
                    tabBackgroundColor: Colors.grey.shade800,
                    padding: EdgeInsets.all(16),
                    gap: 8,
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: "Home",

                      ),
                      GButton(
                          icon: Icons.shopping_basket,
                          text: "My Basket",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BasketScreen(
                                      ),
                              )

                            );
                          }

                      ),
                      GButton(
                          icon: Icons.search,
                          text: "Search",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                  ),
                                )

                            );
                          }

                      )
                    ]
                )
            )
        )
    );
  }
  }