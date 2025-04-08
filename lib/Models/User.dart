class User{
  User({
    this.userID= "",
    this.username="",
    this.email="",
    this.password="",
});
  String userID;
  String password;
  String email;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userID: json["userID"],
    username: json["username"],
    password: json["password"],
    email: json["email"],
  );


  Map<String , dynamic> toJson() => {

    "userID":userID,
    "username":username,
    "email":email,
    "password":password,



  };







}