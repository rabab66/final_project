import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:finalproject/Views/BasketScreen.dart';
import 'package:finalproject/Views/BookshelfScreen.dart';
import 'EditProfileScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key, required this.title});

  final String title;

  @override
  State<HomePageScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageScreen> {
  int _selectedIndex = 0;
  String searchQuery = "";
  final List<String> categories = ["Business", "Design", "Education", "History", "Literature"];

  final List<Map<String, String>> books = [
    {"title": "Harry Potter", "image": "assets/photos/harrypotter.jpg"},
    {"title": "The Fault in Our Stars", "image": "assets/photos/Ourstar.jpg"},
    {"title": "Rich Dad Poor Dad", "image": "assets/photos/richdad.jpg"},
    {"title": "Wonder", "image": "assets/photos/wonder.jpg"},
  ];


  List<Map<String, String>> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = books; // Show all books initially
  }

  void _searchBooks(String query) {
    setState(() {
      searchQuery = query;
      filteredBooks = books
          .where((book) => book["title"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
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
            tabs: categories.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _searchBooks,
                decoration: InputDecoration(
                  labelText: "Search Books",
                  hintText: "Enter book title...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF2E7D32)),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)], // Optional shadow for the cards
                          ),
                          child: Column(
                            children: [
                              // Adjust the image size here
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.asset(
                                  filteredBooks[index]["image"]!,
                                  width: 100,  // Set a fixed width
                                  height: 150, // Set a fixed height
                                  fit: BoxFit.cover,  // Ensure the image is scaled correctly
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  filteredBooks[index]["title"]!,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
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
                  icon: Icons.library_books,
                  text: "Book Shelf",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookshelfScreen()),
                    );
                  },
                ),
                GButton(
                  icon: Icons.shopping_basket,
                  text: "My Basket",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BasketScreen()),
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
