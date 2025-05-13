import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:finalproject/Views/HomePageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Book.dart';
import '../Utils/constants.dart';
import 'BookDetailsScreen.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedIndex = 1; // Bookshelf is the second tab

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen(title: "Home")),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }






  Future getMyFavorites() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var url = "books/getMyFavorites.php?userID=" + token!;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Book> arr = [];
    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Book.fromJson(i));
    }
    return arr;
  }



  Future deleteFavorite( bookID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("token");
    var url = "books/deleteFavorite.php?bookID=" + bookID.toString() + "&userID=" + userID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath+url);
    //setState(() { });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}, // Add search functionality later
          ),
        ],
      ),

      body: FutureBuilder(
        future: getMyFavorites(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0)
            {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Align(
                    alignment: Alignment.center,
                    child: Text('No Favorites', style: TextStyle(fontSize: 23, color: Colors.black))
                ),
              );
            }
            else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                      child:ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Book favorite = projectSnap.data[index];

                          return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        BookDetailsScreen(
                                          book: Book(
                                            bookID: favorite.bookID,
                                            bookName: favorite.bookName,
                                            author: favorite.author,
                                            imageURL: favorite.imageURL,
                                            // description:
                                            // 'The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway\'s interactions with mysterious millionaire Jay Gatsby and Gatsby\'s obsession to reunite with his former lover, Daisy Buchanan.',
                                            // genre: 'Classic',
                                            // rating: 4.5,
                                            // totalPages: 180,
                                            pdfURL: favorite.pdfURL,
                                            // currentPage: 45,
                                          ),
                                        ),
                                    ),
                                  );
                                },
                                title: Text(favorite.bookName!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),), // Icon(Icons.timer),
                                subtitle: Text(favorite.author!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                trailing: IconButton(
                                  onPressed: () =>  deleteFavorite(favorite.bookID),
                                  icon: Icon(Icons.delete, color: Colors.red,),
                                ),
                                isThreeLine: false,
                              ));
                        },
                      )),
                ],
              );
            }
          }
          else if (projectSnap.hasError)
          {
            print("error:" + projectSnap.error.toString());
            return  Center(child: Text('Error, try again', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          }
          return Center(child: new CircularProgressIndicator(color: Colors.red,));
        },
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookshelf"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Bookstore"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBookCard(String title, String imagePath, double progress) {
    return Container(
      width: 120,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
          LinearProgressIndicator(value: progress, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildWishlistBookCard(String title, String imagePath) {
    return Column(
      children: [
        Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => Icon(Icons.star, color: Colors.orange, size: 16)),
        ),
      ],
    );
  }
}
