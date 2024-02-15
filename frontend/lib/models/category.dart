class CategoryModel {
  String? categoryName;
  String? categoryValue;
  String? categoryPhotoUrl;

  CategoryModel({this.categoryName, this.categoryValue, this.categoryPhotoUrl});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['CategoryName'];
    categoryValue = json['CategoryValue'];
    categoryPhotoUrl = json['CategoryPhotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryName'] = this.categoryName;
    data['CategoryValue'] = this.categoryValue;
    data['CategoryPhotoUrl'] = this.categoryPhotoUrl;
    return data;
  }
}
