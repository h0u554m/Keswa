/* class JsonUser {
  String userId;
  String userPass;
  String userTypeCode;
  String userName;
  String genderCode;
  String birthDate;
  String email;
  String phoneNumber;
  String profilePhoto;

  JsonUser(
      {this.userId,
      this.userPass,
      this.userTypeCode,
      this.userName,
      this.genderCode,
      this.birthDate,
      this.email,
      this.phoneNumber,
      this.profilePhoto});

  factory JsonUser.fromJson(Map<String, dynamic> parsedJson) {
   Map json = parsedJson['user'];
    
    return JsonUser(
      userId = json['userId'],
      userPass = json['userPass'],
      userTypeCode = json['userTypeCode'],
      userName = json['userName'],
      genderCode = json['genderCode'],
      birthDate = json['birthDate'],
      email = json['email'],
      phoneNumber = json['phoneNumber'],
      profilePhoto = json['profilePhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userPass'] = this.userPass;
    data['userTypeCode'] = this.userTypeCode;
    data['userName'] = this.userName;
    data['genderCode'] = this.genderCode;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePhoto'] = this.profilePhoto;
    return data;
  }
}
 */
class JsonUser {
  int userProfileId;
  String userId;
  String userPass;
  String userTypeCode;
  String userName;
  String genderCode;
  String birthDate;
  String email;
  String phoneNumber;
  String profilePhoto;

  JsonUser(
      {this.userProfileId,this.userId,
      this.userPass,
      this.userTypeCode,
      this.userName,
      this.genderCode,
      this.birthDate,
      this.email,
      this.phoneNumber,
      this.profilePhoto});

  factory JsonUser.fromJson(Map<String, dynamic> parsedJson) {
    Map json = parsedJson['responseData'];
    return JsonUser(
      userProfileId:json['userProfileId'],
      userId: json['userId'],
      userPass: json['userPass'],
      userTypeCode: json['userTypeCode'],
      userName: json['userName'],
      genderCode: json['genderCode'],
      birthDate: json['birthDate'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profilePhoto: json['profilePhoto'],
    );
  }
}
