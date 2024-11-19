class Category{
  Category({

    this.caregoryID= 0,
    this.	cateroryName="",





});
  int caregoryID;
  String 	cateroryName;


  factory Category.fromJson(Map<String, dynamic> json) => Category(
    caregoryID: json["caregoryID"],
    cateroryName: json["cateroryName"],



  );


  Map<String , dynamic> toJson() => {

    "caregoryID":caregoryID,
    "	cateroryName":	cateroryName,





  };







}