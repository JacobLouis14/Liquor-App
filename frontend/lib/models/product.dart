class ProductModel {
  String? pId;
  String? productName;
  String? productValue;
  int? productPrice;
  String? productCode;
  String? brandName;
  int? quantity;
  int? proof;
  double? eDP;
  String? category;
  List<ProductImageUrl>? productImageUrl;
  List<String>? productAvailableState;

  ProductModel(
      {this.pId,
      this.productName,
      this.productValue,
      this.productPrice,
      this.productCode,
      this.brandName,
      this.quantity,
      this.proof,
      this.eDP,
      this.category,
      this.productImageUrl,
      this.productAvailableState});

  ProductModel.fromJson(Map<String, dynamic> json) {
    pId = json['_id'];
    productName = json['ProductName'];
    productValue = json['ProductValue'];
    productPrice = json['ProductPrice'];
    productCode = json['ProductCode'];
    brandName = json['BrandName'];
    quantity = json['Quantity'];
    proof = json['Proof'];
    eDP = json['EDP'];
    category = json['Category'];
    if (json['ProductImageUrl'] != null) {
      productImageUrl = <ProductImageUrl>[];
      json['ProductImageUrl'].forEach((v) {
        productImageUrl!.add(new ProductImageUrl.fromJson(v));
      });
    }
    productAvailableState = json['ProductAvailableState'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.pId;
    data['ProductName'] = this.productName;
    data['ProductValue'] = this.productValue;
    data['ProductPrice'] = this.productPrice;
    data['ProductCode'] = this.productCode;
    data['BrandName'] = this.brandName;
    data['Quantity'] = this.quantity;
    data['Proof'] = this.proof;
    data['EDP'] = this.eDP;
    data['Category'] = this.category;
    if (this.productImageUrl != null) {
      data['ProductImageUrl'] =
          this.productImageUrl!.map((v) => v.toJson()).toList();
    }
    data['ProductAvailableState'] = this.productAvailableState;
    return data;
  }
}

class ProductImageUrl {
  String? name;
  String? url;

  ProductImageUrl({this.name, this.url});

  ProductImageUrl.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
