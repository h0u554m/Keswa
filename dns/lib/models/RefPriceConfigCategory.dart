import 'dart:convert';

class RefPriceConfigCategory {
    String responseCode;
    String responseMessage;
    List<ResponseDatum> responseData;

    RefPriceConfigCategory({
        this.responseCode,
        this.responseMessage,
        this.responseData,
    });

    factory RefPriceConfigCategory.fromJson(String str) => RefPriceConfigCategory.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RefPriceConfigCategory.fromMap(Map<String, dynamic> json) => RefPriceConfigCategory(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        responseData: List<ResponseDatum>.from(json["responseData"].map((x) => ResponseDatum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "responseData": List<dynamic>.from(responseData.map((x) => x.toMap())),
    };
}

class ResponseDatum {
    String refCode;
    String refDescAr;
    String refDescEn;

    ResponseDatum({
        this.refCode,
        this.refDescAr,
        this.refDescEn,
    });

    factory ResponseDatum.fromJson(String str) => ResponseDatum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ResponseDatum.fromMap(Map<String, dynamic> json) => ResponseDatum(
        refCode: json["refCode"],
        refDescAr: json["refDescAr"],
        refDescEn: json["refDescEn"],
    );

    Map<String, dynamic> toMap() => {
        "refCode": refCode,
        "refDescAr": refDescAr,
        "refDescEn": refDescEn,
    };
}