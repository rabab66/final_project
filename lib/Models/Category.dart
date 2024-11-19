class Category{
  Category({

    this.id= "",
    this.fiction="",
    this.scientific="",




});
  String id;
  String scientific;
  String fiction;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
  id: json["id"],
    fiction: json["fiction"],
    scientific: json["scientific"],


  );


  Map<String , dynamic> toJson() => {

    "id":id,
    "fiction":fiction,
    "scientific":scientific,




  };







}