import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalproject/Models/Book.dart';
import 'package:finalproject/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:finalproject/Views/BasketScreen.dart';
import 'package:finalproject/Views/FavoritesScreen.dart';
import '../Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'BookDetailsScreen.dart';
import 'EditProfileScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageScreen> {
  int _selectedIndex = 0;
  List<Category> _categories = [];
  var _categoryID = 0;
  List<Book> _books = [];

  Future getMyTypes() async {
    var url = "books/getTypes.php";
    final response = await http.get(Uri.parse(serverPath + url));
    List<Category> arr = [];
    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Category.fromJson(i));
    }
    _categories = arr;
    _categoryID = arr[0].categoryID;
    getBooks();
    setState(() {});
    return arr;
  }

  Future getBooks() async {
    var url = "books/getBooks.php?categoryID=" + _categoryID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    List<Book> arr = [];
    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Book.fromJson(i));
    }
    _books = arr;
    setState(() {});
    return arr;
  }

  @override
  void initState() {
    super.initState();
    getMyTypes();
    getBooks();
  }

  void _onTabTapped(int index) {
    _categoryID = _categories[index].categoryID!;
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Color(0xFF64B5F6),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: _categories
                .map((category) => Tab(text: category.categoryName))
                .toList(),
            onTap: _onTabTapped,
          ),
        ),
        body: TabBarView(
          children: _categories.map((category) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: _books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // Adjust for card height
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(
                            book: _books[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10)
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
                            child: SizedBox(
                              height: 150,
                              child: CachedNetworkImage(
                                imageUrl: _books[index].imageURL,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _books[index].bookName!,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey,
              activeColor: Colors.white,
              tabBackgroundColor: Color(0xFF64B5F6),
              padding: EdgeInsets.all(16),
              gap: 8,
              tabs: [
                GButton(icon: Icons.home, text: "Home"),
                GButton(
                  icon: Icons.favorite,
                  text: "Favorites",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoritesScreen()),
                    );
                  },
                ),
                GButton(
                  icon: Icons.man,
                  text: "Profile",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
