import 'dart:convert';

class Product {
  String responseCode;
  String responseMessage;
  ResponseData responseData;

  Product({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        responseData: ResponseData.fromMap(json["responseData"]),
      );

  Map<String, dynamic> toMap() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "responseData": responseData.toMap(),
      };
}

class ResponseData {
  String productId;
  String productName;
  String shareUrl;
  double retailPrice;
  double usdRetailPrice;
  double salePrice;
  double usdSalePrice;
  double egpFinalPrice;
  double unitDiscount;
  String categoryCode;
  String color;
  String thumbImageUrl;
  String mainImageUrl;
  List<String> imagesUrl;
  List<String> sizesStr;
  List<Map<String, int>> sizes;
  List<Property> properties;

  ResponseData({
    this.productId,
    this.productName,
    this.shareUrl,
    this.retailPrice,
    this.usdRetailPrice,
    this.salePrice,
    this.usdSalePrice,
    this.egpFinalPrice,
    this.unitDiscount,
    this.categoryCode,
    this.color,
    this.thumbImageUrl,
    this.mainImageUrl,
    this.imagesUrl,
    this.sizesStr,
    this.sizes,
    this.properties,
  });

  factory ResponseData.fromJson(String str) =>
      ResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseData.fromMap(Map<String, dynamic> json) => ResponseData(
        productId: json["productId"],
        productName: json["productName"],
        shareUrl: json["shareURL"],
        retailPrice: json["retailPrice"],
        usdRetailPrice: json["usdRetailPrice"].toDouble(),
        salePrice: json["salePrice"],
        usdSalePrice: json["usdSalePrice"].toDouble(),
        egpFinalPrice: json["egpFinalPrice"].toDouble(),
        unitDiscount: json["unitDiscount"],
        categoryCode: json["categoryCode"],
        color: json["color"],
        thumbImageUrl: json["thumbImageURL"],
        mainImageUrl: json["mainImageURL"],
        imagesUrl: List<String>.from(json["imagesURL"].map((x) => x)),
        sizesStr: List<String>.from(json["sizesStr"].map((x) => x)),
        properties: List<Property>.from(
            json["properties"].map((x) => Property.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productName": productName,
        "shareURL": shareUrl,
        "retailPrice": retailPrice,
        "usdRetailPrice": usdRetailPrice,
        "salePrice": salePrice,
        "usdSalePrice": usdSalePrice,
        "egpFinalPrice": egpFinalPrice,
        "unitDiscount": unitDiscount,
        "categoryCode": categoryCode,
        "color": color,
        "thumbImageURL": thumbImageUrl,
        "mainImageURL": mainImageUrl,
        "imagesURL": List<dynamic>.from(imagesUrl.map((x) => x)),
        "sizesStr": List<dynamic>.from(sizesStr.map((x) => x)),
        "properties": List<dynamic>.from(properties.map((x) => x.toMap())),
      };
}

class Property {
  String patternType;
  String outsoleMaterial;
  String type;
  String sizeFit;
  String color;
  String upperMaterial;
  String toe;
  String strapType;

  Property({
    this.patternType,
    this.outsoleMaterial,
    this.type,
    this.sizeFit,
    this.color,
    this.upperMaterial,
    this.toe,
    this.strapType,
  });

  factory Property.fromJson(String str) => Property.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        patternType: json["Pattern Type"] == null ? null : json["Pattern Type"],
        outsoleMaterial:
            json["Outsole Material"] == null ? null : json["Outsole Material"],
        type: json["Type"] == null ? null : json["Type"],
        sizeFit: json["Size Fit"] == null ? null : json["Size Fit"],
        color: json["Color"] == null ? null : json["Color"],
        upperMaterial:
            json["Upper Material"] == null ? null : json["Upper Material"],
        toe: json["Toe"] == null ? null : json["Toe"],
        strapType: json["Strap Type"] == null ? null : json["Strap Type"],
      );

  Map<String, dynamic> toMap() => {
        "Pattern Type": patternType == null ? null : patternType,
        "Outsole Material": outsoleMaterial == null ? null : outsoleMaterial,
        "Type": type == null ? null : type,
        "Size Fit": sizeFit == null ? null : sizeFit,
        "Color": color == null ? null : color,
        "Upper Material": upperMaterial == null ? null : upperMaterial,
        "Toe": toe == null ? null : toe,
        "Strap Type": strapType == null ? null : strapType,
      };
}
