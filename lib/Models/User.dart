class User{
  User({

    this.id= "",
    this.name="",
    this.email="",
    this.password="",


});
  String id;
  String password;
  String email;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
  id: json["id"],
  name: json["name"],
    password: json["password"],
  email: json["email"],

  );


  Map<String , dynamic> toJson() => {

    "id":id,
    "name":name,
    "email":email,
    "password":password,



  };







}