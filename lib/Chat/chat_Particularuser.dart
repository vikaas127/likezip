import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziplike/Loading.dart';
import '../Home.dart';


class Chatgruop extends StatelessWidget {
  static const routeName = '/Chatgruop-page-screen';
 // final List< ChatGruoplist.Memberlist> chatData;
  final String chatId;
  final String chatAvatar;
  final String chatName;
  final String chatTotalM;
  Chatgruop({Key key,  this.chatId, this.chatAvatar, this.chatName, this.chatTotalM,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black87,
      appBar:  AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
            Navigator.pop(context);
          },
        ),
        title: Text("Jyoti"),),


      body: ChatgruopScreen(
        chatgName:chatName ,
        chatTotalM:chatTotalM ,
        chatid: chatId,
        chatAvtr: chatAvatar,
      ),
    );
  }
}
class ChatgruopScreen extends StatefulWidget {
  final String chatid;
  final String chatAvtr;
  final String chatgName;
  final String chatTotalM;
  ChatgruopScreen({Key key, this.chatid, this.chatAvtr,this.chatgName, this.chatTotalM}) : super(key: key);

  @override
  State createState() => ChatgrpScreenState(chatID: chatid, chatAvatar: chatAvtr,chatName:chatgName ,chatTotalM:chatTotalM );
}
class ChatgrpScreenState extends State<ChatgruopScreen> {
  ChatgrpScreenState({Key key,  this.chatID,  this.chatAvatar, this.chatName,  this.chatTotalM});
  String chatName;
  String chatTotalM;
  String chatID;
  String chatAvatar;
  String id;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";
  SharedPreferences prefs;

  File imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';
  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }
Color primaryColor =Colors.grey;
  Color greyColor =Colors.grey;
  Color greyColor2 =Colors.grey;
  Color colorAccent =Colors.grey;

  Color colorPrimaryDark =Colors.grey;

  String person_placeholder ='assets/personfigma.png';
  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    readLocal();
  }
  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs?.getString('id') ?? '';
    nickname = prefs?.getString('nickname') ?? '';
    aboutMe = prefs?.getString('aboutMe') ?? '';
    photoUrl = prefs?.getString('photoUrl') ?? '';
    prefs = await SharedPreferences.getInstance();
    id = prefs?.getString('id') ?? '';
    if (id.hashCode <= chatID.hashCode) {
      groupChatId = '$id-$chatID';
    } else {
      groupChatId = '$chatID-$id';
    }

    FirebaseFirestore.instance.collection('users').doc(id).update({'chattingWith': chatID});

    setState(() {});
  }
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }
  Future getCamera() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }
  Future getvideo() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }
  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }
  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);

    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }
  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(chatID)
          .collection(chatID)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': chatID,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: Colors.black, textColor: Colors.red);
    }
  }
  Widget buildItem(int index, DocumentSnapshot document) {
    if (document != null) {
      if (document.get('idFrom') == id) {
        // Right (my message)
        return Row(
          children: <Widget>[
            document.get('type') == 0
            // Text
                ? Container(

              width: MediaQuery.of(context).size.width*.50,
              child: Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      document.get('content'), style: TextStyle(color: primaryColor),),
                  ],
                ),
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),

              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            ):Container(),

            isLastMessageLeft(index)
                ? Material(
              child: Image.network(
                photoUrl,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      value: loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, object, stackTrace) {
                  return Container(
                    width: 35,
                    height: 35,
                    //BoxDecoration Widget
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: colorPrimaryDark,
                      ), //Border.all
                      borderRadius: BorderRadius.circular(10),
                    ), //BoxDecoration
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        errorWidget: (context, _, error) =>
                            Image.asset(person_placeholder),
                        placeholder: (context, _) =>
                            Image.asset(person_placeholder),
                        imageUrl: chatAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),

                  );
                },
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              clipBehavior: Clip.hardEdge,
            )
                : Container(width: 35.0),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        );
      }
      else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                    child: Image.network(
                      chatAvatar,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                            value: loadingProgress.expectedTotalBytes != null &&
                                loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return Container(
                          width: 35,
                          height: 35,
                          //BoxDecoration Widget
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: colorPrimaryDark,
                            ), //Border.all
                            borderRadius: BorderRadius.circular(10),
                          ), //BoxDecoration
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              errorWidget: (context, _, error) =>
                                  Image.asset(person_placeholder),
                              placeholder: (context, _) =>
                                  Image.asset(person_placeholder),
                              imageUrl: chatAvatar,
                              fit: BoxFit.cover,
                            ),
                          ),

                        );
                      },
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                  )
                      : Container(width: 35.0),
                  document.get('type') == 0
                      ? Container(
                    child: Text(
                      document.get('content'),
                      style: TextStyle(color: Colors.black),
                    ),
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    width: 200.0,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.only(left: 10.0),
                  )

                      : Container(
                    child: Image.asset('images/${document.get('content')}.gif',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                    margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                  ),
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                child: Text(
                  DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.get('timestamp')))),
                  style: TextStyle(color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
                ),
                margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              )
                  : Container()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10.0),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }
  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage[index - 1].get('idFrom') == id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }
  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage[index - 1].get('idFrom') != id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      FirebaseFirestore.instance.collection('users').doc(id).update({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(

        children: <Widget>[
          Column(

            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              isShowSticker ? buildSticker() : Container(),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }
  Widget buildSticker() {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage('mimi1', 2),
                  child: Image.asset(
                    'images/mimi1.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi2', 2),
                  child: Image.asset(
                    'images/mimi2.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi3', 2),
                  child: Image.asset(
                    'images/mimi3.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage('mimi4', 2),
                  child: Image.asset(
                    'images/mimi4.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi5', 2),
                  child: Image.asset(
                    'images/mimi5.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi6', 2),
                  child: Image.asset(
                    'images/mimi6.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage('mimi7', 2),
                  child: Image.asset(
                    'images/mimi7.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi8', 2),
                  child: Image.asset(
                    'images/mimi8.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage('mimi9', 2),
                  child: Image.asset(
                    'images/mimi9.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
        padding: EdgeInsets.all(5.0),
        height: 180.0,
      ),
    );
  }
  Widget buildLoading() {
    return Positioned(
      child: isLoading ?  LoadingPage() : Container(),
    );
  }
  Widget buildInput() {
    return Container(

      child: Column(
        children: [
          Row(
            children: <Widget>[
              // Button send image

              IconButton(
                icon: Icon(Icons.mic,color: Colors.white,),
                onPressed: getSticker,
                color: primaryColor,
              ),

              // Edit text
              Flexible(
                child: Container(

                ),
              ),

              // Button send message

            ],
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  height: 44,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: TextField(
                      onSubmitted: (value) {
                        onSendMessage(textEditingController.text, 0);
                      },
                      style: TextStyle(color: primaryColor, fontSize: 15.0),
                      controller: textEditingController,

                      decoration: InputDecoration.collapsed(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: greyColor),
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send,color: Colors.white,),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ],
          ),
        ],
      ),
      width: double.infinity,
      height: 100.0,

      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                colorAccent,
                colorPrimaryDark,
              ]
          ),
          boxShadow: [
            new BoxShadow(
              // color: Colors.grey[500],
              blurRadius: 20.0,
              spreadRadius: 1.0,
            )
          ]
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(

      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages').doc('$chatID').collection('$chatID').
        orderBy('timestamp', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            listMessage.addAll(snapshot.data.docs);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(index, snapshot.data?.docs[index]),
              itemCount: snapshot.data?.docs.length,
              reverse: true,
              controller: listScrollController,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          }
        },
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ),
    );
  }
}
