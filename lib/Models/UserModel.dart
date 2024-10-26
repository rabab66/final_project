class User{
  User({

    this.id= "",
    this.name="",
    this.phone="",
    this.note="",
    this.addres="",


});
  String id;
  String name;
  String phone;
  String note;
 String addres;
  factory User.fromJson(Map<String, dynamic> json) => User(
  id: json["id"],
  name: json["name"],
  phone: json["phone"],
  note: json["note"],
    addres:json["addres"],
  );


  Map<String , dynamic> toJson() => {

    "id":id,
    "name":name,
    "phone":phone,
    "note":note,
    "addres":addres,


  };







}