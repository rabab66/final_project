class User{
  User({
    this.userID = "",
    this.fullName = "",
    this.email = "",
    this.password = "",
});


  String userID;
  String password;
  String email;
  String fullName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userID: json["userID"],
    fullName: json["fullName"],
    password: json["password"],
    email: json["email"],
  );


  Map<String , dynamic> toJson() => {
    "userID": userID,
    "fullName": fullName,
    "email": email,
    "password": password,
  };







}