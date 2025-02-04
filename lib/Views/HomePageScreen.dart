import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:finalproject/Views/BasketScreen.dart';
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
    {"title": "Rich Dad Poor Dad", "image": "assets/rich_dad.png"},
    {"title": "The Lean Startup", "image": "assets/lean_startup.png"},
    {"title": "The 4-Hour Work Week", "image": "assets/4hour_workweek.png"},
    {"title": "The Subtle Art of Not Giving a F*ck", "image": "assets/subtle_art.png"},
    {"title": "The Modern Habit", "image": "assets/habit.png"},
    {"title": "Think and Grow Rich", "image": "assets/think_grow_rich.png"},
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          bottom: TabBar(
            isScrollable: true,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.search),
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
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Expanded(
                              child: Image.asset(filteredBooks[index]["image"]!, fit: BoxFit.cover),
                            ),
                            Text(filteredBooks[index]["title"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
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
                GButton(icon: Icons.home, text: "Home"),
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
