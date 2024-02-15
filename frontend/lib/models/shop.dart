class ShopModel {
  String? name;
  String? nameLower;
  String? address;
  String? category;
  double? ariealDistance;
  double? latitude;
  double? longitude;

  ShopModel(
      {this.name,
      this.nameLower,
      this.address,
      this.category,
      this.latitude,
      this.longitude});

  ShopModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    nameLower = json['Name_Lower'];
    address = json['Address'];
    category = json['Category'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Name_Lower'] = this.nameLower;
    data['Address'] = this.address;
    data['Category'] = this.category;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }
}
