 import 'dart:core';
 class User {
  String photourl;
  String pass;
  String phone;
  String nickName;
  String name;
  String id;
  String signupTime;
  String email;

  User(
  {this.photourl,
  this.pass,
  this.phone,
  this.nickName,
  this.name,
  this.id,
  this.signupTime,
  this.email});

  factory User.fromJson(Map<dynamic,dynamic> parsedJson) {
    return User(photourl:parsedJson['photourl'],
        pass: parsedJson['pass'],
        phone:parsedJson['phone'],
        nickName: parsedJson['nickName'],
        name:parsedJson['name'],
      id: parsedJson['id'],
        signupTime:parsedJson['signupTime'],
        email:parsedJson['email']


    );
  }









   getPhotourl() {
    return photourl;
  }

  void set Photourl( photourl) {
    this.photourl = photourl;
  }

   get Phone {
    return phone;
  }

   void set Phone( phone) {
    this.phone = phone;
  }

   get NickName {
    return nickName;
  }

   void set NickName( nickName) {
    this.nickName = nickName;
  }

   get SignupTime {
    return signupTime;
  }

   void set SignupTime( signupTime) {
    this.signupTime = signupTime;
  }

   get Id {
    return id;
  }
  void set Id(String id) {
    this.id = id;
  }

    get Name {
    return name;
  }

   void set Name(String name) {
    this.name = name;
  }

   String get Email {
    return email;
  }

   void set Email(String email) {
    this.email = email;
  }


   String get Pass {
    return pass;
  }

   void set Pass(String pass) {
    this.pass = pass;
  }
}
