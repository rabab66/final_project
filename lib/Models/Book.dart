import 'dart:ffi';

class Book{
  Book({

    this.id= 0,
    this.bookname="",
    this.author="",
    this.price=0,



  });
  int id;
  String bookname;
  String author;
  double price;
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    bookname: json["bookname"],
    author: json["author"],
    price: json["price"],

  );


  Map<String , dynamic> toJson() => {

    "id":id,
    "bookname":bookname,
    "author":author,
    "price":price,



  };







}