class base64info {
  String responseCode;
  String responseMessage;
  List<ResponseData> responseData;

  base64info({this.responseCode, this.responseMessage, this.responseData});

  base64info.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    if (json['responseData'] != null) {
      responseData = new List<ResponseData>();
      json['responseData'].forEach((v) {
        responseData.add(new ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.responseData != null) {
      data['responseData'] = this.responseData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  int configId;
  String configCode;
  String configValue;
  String configTypeCode;
  String configScopeCode;

  ResponseData(
      {this.configId,
      this.configCode,
      this.configValue,
      this.configTypeCode,
      this.configScopeCode});

  ResponseData.fromJson(Map<String, dynamic> json) {
    configId = json['configId'];
    configCode = json['configCode'];
    configValue = json['configValue'];
    configTypeCode = json['configTypeCode'];
    configScopeCode = json['configScopeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['configId'] = this.configId;
    data['configCode'] = this.configCode;
    data['configValue'] = this.configValue;
    data['configTypeCode'] = this.configTypeCode;
    data['configScopeCode'] = this.configScopeCode;
    return data;
  }
}