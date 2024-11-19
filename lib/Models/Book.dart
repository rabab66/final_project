import 'dart:ffi';

class Book{
  Book({

    this.bookID= 0,
    this.bookName="",
    this.author="",
    this.price=0,



  });
  int bookID;
  String bookName;
  String author;
  double price;
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    bookID: json["bookID"],
    bookName: json["bookName"],
    author: json["author"],
    price: json["price"],

  );


  Map<String , dynamic> toJson() => {

    "bookID":bookID,
    "bookName":bookName,
    "author":author,
    "price":price,



  };







}