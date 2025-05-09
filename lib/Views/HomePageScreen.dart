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
  // String searchQuery = "";
  // final List<String> categories = ["Business", "Design", "Education", "History", "Literature"];
  List<Category> _categories = [];
  // List<Map<String, String>> filteredBooks = [];
  var _categoryID = 0;
  List<Book> _books = [];

  // final List<Map<String, String>> books = [
  //   {"title": "Harry Potter", "image": "assets/photos/harrypotter.jpg"},
  //   {"title": "The Fault in Our Stars", "image": "assets/photos/Ourstar.jpg"},
  //   {"title": "Rich Dad Poor Dad", "image": "assets/photos/richdad.jpg"},
  //   {"title": "Wonder", "image": "assets/photos/wonder.jpg"},
  // ];



  Future getMyTypes() async {
    var url = "books/getTypes.php";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Category> arr = [];
    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Category.fromJson(i));
    }
    _categories = arr;
    _categoryID = arr[0].categoryID;
    getBooks();
    return arr;
  }



  Future getBooks() async {
    var url = "books/getBooks.php?categoryID=" + _categoryID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Book> arr = [];
    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Book.fromJson(i));
    }
    _books = arr;
    setState(() {

    });
    return arr;
  }





  @override
  void initState() {
    super.initState();
    // filteredBooks = books; // Show all books initially
    getMyTypes();
    getBooks();
  }

  // void _searchBooks(String query) {
  //   setState(() {
  //     searchQuery = query;
  //     filteredBooks = books
  //         .where((book) => book["title"]!.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   });
  // }


  void _onTabTapped(int index) {
    print('Tab $index tapped');
    _categoryID = _categories[index].categoryID!;
    getBooks();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        backgroundColor: Color(0xFFC8E6C9),
        appBar: AppBar(
          backgroundColor: Color(0xFF2E7D32),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: _categories.map((category) => Tab(text: category.categoryName)).toList(),
            onTap: _onTabTapped,
          ),
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     onChanged: _searchBooks,
            //     decoration: InputDecoration(
            //       labelText: "Search Books",
            //       hintText: "Enter book title...",
            //       filled: true,
            //       fillColor: Colors.white,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(30),
            //         borderSide: BorderSide.none,
            //       ),
            //       prefixIcon: Icon(Icons.search, color: Color(0xFF2E7D32)),
            //       contentPadding: EdgeInsets.symmetric(vertical: 10),
            //     ),
            //   ),
            // ),
            Expanded(
              child: TabBarView(
                children: _categories.map((category) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: _books.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return
                          GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    BookDetailsScreen(
                                      book: Book(
                                        bookID: _books[index].bookID,
                                        bookName: _books[index].bookName,
                                        author: _books[index].author,
                                        imageURL: _books[index].imageURL,
                                        // description:
                                        // 'The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway\'s interactions with mysterious millionaire Jay Gatsby and Gatsby\'s obsession to reunite with his former lover, Daisy Buchanan.',
                                        // genre: 'Classic',
                                        // rating: 4.5,
                                        // totalPages: 180,
                                        pdfURL: _books[index].pdfURL,
                                        // currentPage: 45,
                                      ),
                                  ),
                                ),
                              );

                          print('Container tapped!');
                          // Add your logic here
                        },
                        child:

                          Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)], // Optional shadow for the cards
                          ),
                          child: Column(



                            children: [
                              // Adjust the image size here
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child:
                                  CachedNetworkImage(
                                    imageUrl: _books[index].imageURL,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  )

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _books[index].bookName!,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
            ),
          ],
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
              tabBackgroundColor: Color(0xFF2E7D32),
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
                      MaterialPageRoute(builder: (context) => FavoritesScreen()),
                    );
                  },
                ),
                GButton(
                  icon: Icons.man,
                  text: "Profile",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
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
