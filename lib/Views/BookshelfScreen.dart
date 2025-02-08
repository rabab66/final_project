import 'package:flutter/material.dart';
import 'package:finalproject/Views/HomePageScreen.dart';

class BookshelfScreen extends StatefulWidget {
  @override
  _BookshelfScreenState createState() => _BookshelfScreenState();
}

class _BookshelfScreenState extends State<BookshelfScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookshelf"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}, // Add search functionality later
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Book", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBookCard("What the Locusts Leave Behind", "assets/book1.png", 1.0),
                  _buildBookCard("The Modern Alphabet", "assets/book2.png", 0.8),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Wishlisted Books", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildWishlistBookCard("Book Title", "assets/sample_book.png");
                },
              ),
            ),
          ],
        ),
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
