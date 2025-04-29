
class Book{

  Book({
    this.bookID= 0,
    this.bookName="",
    this.author="",
    this.price=0,
    this.imageURL="",
    this.pdfURL="",
  });


  int bookID;
  String bookName;
  String author;
  double price;
  String imageURL;
  String pdfURL;


  factory Book.fromJson(Map<String, dynamic> json) => Book(
    bookID: json["bookID"],
    bookName: json["bookName"],
    author: json["author"],
    price: json["price"],
    imageURL: json["imageURL"],
    pdfURL: json["pdfURL"],

  );


  Map<String , dynamic> toJson() => {
    "bookID":bookID,
    "bookName":bookName,
    "author":author,
    "price":price,
    "imageURL":imageURL,
    "pdfURL":pdfURL,

  };







}