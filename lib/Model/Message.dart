 class Message {
   String message ="";
       String type ="";
   bool seen;
   int timestamp;
   String from;
   String url;
   String voice;

   Message ({
    this.message ,
    this.type ,
    this.seen,
    this.timestamp ,
    this.from ,
    this.url ,
    this.voice ,
  });
   /*factory Message.fromDocument(DataSnapshot doc) {
     String aboutMe = "";
     String photoUrl = "";
     String nickname = "";
     try {
       aboutMe = doc.('aboutMe');
     } catch (e) {}
     try {
     photoUrl = doc.get('photoUrl');
     } catch (e) {}
     try {
     nickname = doc.get('nickname');
     } catch (e) {}
     return Message(
     id: doc.id,
     photoUrl: photoUrl,
     nickname: nickname,
     aboutMe: aboutMe,
     );
   }*/
   factory Message.fromJson(Map<dynamic,dynamic> parsedJson) {
     return Message(
       message:parsedJson['message'],
         type: parsedJson['type'],
         seen:parsedJson['false'],
         timestamp: parsedJson['timestamp'],
         from:parsedJson['from'],
         url: parsedJson['url'],
         voice:parsedJson['voice'],



     );
   }


   String get getVoice {
    return voice;
  }
   void set setVoice(String voice) {
    this.voice = voice;
  }

  String  get getMessage{
    return message;
  }
  void set setMessage(String message) {
    this.message = message;
  }

   String  get  getType {
    return type;
  }

  void set Type(String type) {
    this.type = type;
  }
  bool get getSeen {
    return seen;
  }
  void set Seen(bool seen) {
    this.seen = seen;
  }
   int  get getTimestamp{
    return timestamp;
  }

  void set Timestamp(int timestamp) {
    this.timestamp = timestamp;
  }

  String get  getFrom {
    return from;
  }

   void set From(String from) {
    this.from = from;
  }

   String get getUrl {
    return url;
  }

  void set Url(String url) {
    this.url = url;
  }
}
