import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziplike/Loading.dart';
import 'package:ziplike/Model/Message.dart';
import 'package:ziplike/Model/User.dart';
import '../Home.dart';
class Chatgruop extends StatelessWidget {

  final User user;

  Chatgruop({Key key,  this.user, }) : super(key: key);

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
        title: Text("${user.name}"),),


      body: ChatgruopScreen(
        user:user ,

      ),
    );
  }
}
class ChatgruopScreen extends StatefulWidget {
  final User user;

  ChatgruopScreen({Key key, this.user, }) : super(key: key);

  @override
  State createState() => ChatgrpScreenState(userdata: user );
}
class ChatgrpScreenState extends State<ChatgruopScreen> {
  ChatgrpScreenState({Key key,  this.userdata});
  User userdata;
  FlutterSoundRecorder _myRecorder;
  final audioPlayer = AssetsAudioPlayer();
  String filePath;
  bool _play = false;
  String _recorderTxt = '00:00:00';
  List<Message> listMessage = new List.from([]);
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";
  File mLocalFilePath;
  SharedPreferences prefs;
bool start=true;
bool stop=false;
bool upload =false;
  File imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";
  String audioUrl ="";
   DatabaseReference mRootRef;
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
Color primaryColor =Colors.white;
  Color greyColor =Colors.grey;
  Color greyColor2 =Colors.grey;
  Color colorAccent =Colors.grey;
  Color colorPrimaryDark =Colors.grey;
  String uid;
  String push_id;
  String person_placeholder ='assets/personfigma.png';

  @override
  void initState() {
    super.initState();
    uid="2w3jbz9DMFQsqhJRoPWiwqTPSUh1";
    // uid = FirebaseAuth.instance.currentUser.uid;
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    startIt();
   // readLocal();
  }
  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }
 /*  void loadMessage() {
   // Log.d("loadmessage", "load");

    //path of Database
    DatabaseReference messageRef = mRootRef.reference().child("message").child(uid).child(userdata.id);


    mRootRef.child("message").child(uid).child(userdata.id).limitToFirst(1)
        .addListenerForSingleValueEvent(new ValueEventListener() {
    @Override
    public void onDataChange(@NonNull DataSnapshot snapshot) {

    if (!snapshot.exists()) {

    Map messageMap = new HashMap();
    messageMap.put("message", "EMPTY");
    messageMap.put("seen", false);
    messageMap.put("type", "text");
    messageMap.put("timestamp", ServerValue.TIMESTAMP);
    messageMap.put("from", currentUserId);
    messageMap.put("url", imageMessageUrl);
    messageMap.put("voice", audioMessageUrl);
    mRootRef.child("message").child(currentUserId).child(mChatUser).push().setValue(messageMap);
    }

    }


    @Override
    public void onCancelled(@NonNull DatabaseError error) {

    }
    });
    //handle variable message ref
    messageRef.addChildEventListener(
        new ChildEventListener() {
    String sender_key;

    @Override
    public void onChildAdded(@NonNull DataSnapshot dataSnapshot, @Nullable String s) {
    Message message = dataSnapshot.getValue(Message.class);

    //use variable for test
    Log.d("frommessage", "onChildAdded:" + dataSnapshot);
    String key = dataSnapshot.getKey();
    Log.d("singlemessagekey", key);
    Log.d("frommessage", message.getMessage());
    Log.d("frommessage", message.getUrl());
    Log.d("frommessage", message.getVoice() + "");
    itemPos++;
    if (itemPos == 1) {
    mLastkey = dataSnapshot.getKey();
    mPrevKey = dataSnapshot.getKey();
    }
    messageList.add(message);

    messageAdapter.notifyDataSetChanged();
    mMessageList.smoothScrollToPosition(messageList.size() - 1);

//                        final Message message1 = message;
//                        new Handler().postDelayed(new Runnable() {
//                            @Override
//                            public void run() {
//                                if(!message1.getVoice().equals("") && System.currentTimeMillis()-message1.getTimestamp() < 60000){
//                                    MessageAdapter.ViewHolder viewHolder = (MessageAdapter.ViewHolder)mMessageList.findViewHolderForAdapterPosition(messageAdapter.getItemCount()-1);
//                                    if(viewHolder != null) {
//                                        new SetAudioTask(viewHolder.inVoicePlayerView, message1.getVoice()).execute();
//                                    }
//                                    else{
//                                        Toast.makeText(ChatActivity.this, "Could not autoplay!", Toast.LENGTH_SHORT).show();
//                                    }
//                                }
//                            }
//                        }, 1000);

    // mSwipeRefreshLayout.setRefreshing(false);

    }

    @Override
    public void onChildChanged(@NonNull DataSnapshot dataSnapshot, @Nullable String s) {

    }

    @Override
    public void onChildRemoved(@NonNull DataSnapshot dataSnapshot) {

    }

    @Override
    public void onChildMoved(@NonNull DataSnapshot dataSnapshot, @Nullable String s) {

    }

    @Override
    public void onCancelled(@NonNull DatabaseError databaseError) {

    }
    }
    );
//        Log.d("customadapterm",messageList.get(0).getMessage());

  }

   void sendMessage() {
    final String message = msg_enter.getText().toString();
    if (!TextUtils.isEmpty(message) || !imageMessageUrl.equals("") || !audioMessageUrl.equals("")) {
     // Log.d("Click", "Entered");
      String current_user_ref = "message/" + currentUserId + "/" + mChatUser;
      String chat_user_ref = "message/" + mChatUser + "/" + currentUserId;

    //  Log.d("messagesize", String.valueOf(messageList.size()));


      // Message single_message = new Message(message, "text", false, 0);

      Map messageMap = new Map();
      messageMap.put("message", message);
      messageMap.put("seen", false);
      messageMap.put("type", "text");
      messageMap.put("timestamp", ServerValue.TIMESTAMP);
      messageMap.put("from", currentUserId);
      messageMap.put("url", imageMessageUrl);
      messageMap.put("voice", audioMessageUrl);

      Map messageUserMap = new HashMap();
      messageUserMap.put(current_user_ref + "/" + push_id, messageMap);
      messageUserMap.put(chat_user_ref + "/" + push_id, messageMap);
      msg_enter.setText("");

      mRootRef.updateChildren(messageUserMap, new DatabaseReference.CompletionListener() {
      @Override
      public void onComplete(@Nullable DatabaseError databaseError, @NonNull DatabaseReference databaseReference) {
      FirebaseDatabase.getInstance().getReference("users").child(currentUserId).child("name").addListenerForSingleValueEvent(new ValueEventListener() {
      @Override
      public void onDataChange(@NonNull DataSnapshot snapshot) {
      if (snapshot.exists()) {
      String name = snapshot.getValue(String.class);
      DatabaseReference ref = FirebaseDatabase.getInstance().getReference("users").child(mChatUser).child("notifications");
      HashMap<String, String> notificationMap = new HashMap<>();
      notificationMap.put("userId", currentUserId);
      notificationMap.put("name", name);
      if (message.equals("")) {
      notificationMap.put("message", "Audio message");
      notificationMap.put("audioUrl", audioMessageUrl);
      } else {
      notificationMap.put("message", message);
      notificationMap.put("audioUrl", "");
      }
      ref.push().setValue(notificationMap);
      }
      }

      @Override
      public void onCancelled(@NonNull DatabaseError error) {

      }
      });

      }
      });

    }
  }
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
   // id = prefs?.getString('id') ?? '';
    nickname = prefs?.getString('nickname') ?? '';
    aboutMe = prefs?.getString('aboutMe') ?? '';
    photoUrl = prefs?.getString('photoUrl') ?? '';
    prefs = await SharedPreferences.getInstance();
   /* id = prefs?.getString('id') ?? '';
    if (id.hashCode <= chatID.hashCode) {
      groupChatId = '$id-$chatID';
    } else {
      groupChatId = '$chatID-$id';
    }*/

    FirebaseFirestore.instance.collection('users').doc(id).update({'chattingWith': chatID});

    setState(() {});
  }*/
  void startIt() async {
    filePath = '/audio/temp'+".3gp";
    _myRecorder = FlutterSoundRecorder();

    await _myRecorder.openAudioSession(
        focus: AudioFocus.requestFocusAndStopOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker);
    await _myRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();

    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }
  ElevatedButton buildElevatedButton({String text, Function f,Color bakgcolor}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(2.0),
        side: BorderSide(
          color: bakgcolor,
          width: 3.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        primary: Colors.white,
        elevation: 2.0,
      ),
      onPressed: f,

      child: Container(height: 40,width: 75,
          child: Center(child: Text(text,style: TextStyle(color: bakgcolor),))),
    );
  }

  Future<void> record() async {
    setState(() {
      start=false;
      stop=true;
      upload=false;
    });
    Directory dir = Directory(filePath);


    if (!dir.existsSync()) {
      dir.createSync();
    }
    _myRecorder.openAudioSession();
    await _myRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );

    StreamSubscription _recorderSubscription = _myRecorder.onProgress.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        print('vkaas');
        _recorderTxt = txt.substring(0, 8);
      });
    });
    _recorderSubscription.cancel();
  }

  Future<String> stopRecord() async {
    setState(() {
      start=false;
      stop=false;
      upload=true;
    });
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder();
  }
  Future<String> uploadRecord() async {
    setState(() {
      start=false;
      stop=false;
      upload=false;
    });
    _myRecorder.closeAudioSession();
    return await _myRecorder.stopRecorder();
  }
  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
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

  Future uploadFile() async {
    DatabaseReference user_message_push = mRootRef.child("message").child(uid).child(userdata.id).push();
    push_id = user_message_push.key;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(uid).child(push_id);
    UploadTask uploadTask = reference.putFile(imageFile);

    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage('','text',imageUrl,'');
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }
  void onSendMessage(String content, String type, String image,String voice) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseDatabase.instance.reference().child('message').child(uid).child('${userdata.id}').push().set(


        {'url':image.toString()??null,
          'voice':'',
          'seen':false,
          'from': uid,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'message': content,
          'type': type
        },

      );

       



      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    else {
      Fluttertoast.showToast(msg: 'Nothing to send', backgroundColor: Colors.black, textColor: Colors.red);
    }
  }
  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage[index - 1].from == userdata.id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }
  bool isLastMessageRight(int index) {
   if ((index > 0 && listMessage[index - 1].from != userdata.id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }
   void startRecording() {
    /*if (recognizer != null)
      recognizer.stop();
    try {
      mRecorder.prepare();
      mRecorder.start();
      recording = true;
      Toast.makeText(this, "Recording..!", Toast.LENGTH_SHORT).show();

    } catch (Exception e) {

    Log.e(LOG_TAG, "prepare() failed");
    }
*/
//        mRecorder.start();


  }
   bool flagchat=false;
  bool mic =false;
  //check if mic is available or not
    validateMicAvailability() {
    /*oolean available = true;
    AudioRecord recorder =
    new AudioRecord(MediaRecorder.AudioSource.MIC, 44100,
        AudioFormat.CHANNEL_IN_MONO,
        AudioFormat.ENCODING_DEFAULT, 44100);
    try {
      if (recorder.getRecordingState() != AudioRecord.RECORDSTATE_STOPPED) {
        available = false;

      }
      recorder.stop();
    } finally {
      recorder.release();
      recorder = null;
      available = true;
    }

    return available;*/
  }
   void stopRecording() {
  /*  if (autoStopHandler != null && autoStopRunnable != null)
      autoStopHandler.removeCallbacks(autoStopRunnable);

    if (mRecorder != null) {
      try {
        mRecorder.stop();
        isDispaly = true;
        recording = false;

        new Handler().postDelayed(new Runnable() {
        @Override
        public void run() {
        if (recognizer != null)
        switchSearch(KWS_SEARCH);
        }
        }, 1000);

//                uploadAudio();
      } catch (Exception e) {
    e.printStackTrace();
    }
    Toast.makeText(this, "Stopped..!", Toast.LENGTH_SHORT).show();
    }*/
  }
   void uploadAudio() async {
   // Toast.makeText(this, "sending..", Toast.LENGTH_SHORT).show();

    DatabaseReference user_message_push = mRootRef.child("message").child(uid).child(userdata.id.toString()).push();
    push_id = user_message_push.key;

    Reference reference = FirebaseStorage.instance.ref().child(uid).child(push_id);

    UploadTask uploadTask = reference.putFile(mLocalFilePath);

    try {
      TaskSnapshot snapshot = await uploadTask;
      audioUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        onSendMessage('','text',audioUrl,'');
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }
/*  Widget buildItem(int index, DocumentSnapshot document) {
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
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
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
  }*/
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


              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
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
            children: [
              IconButton(
                icon: Icon(Icons.add,color: Colors.black,),
                onPressed: getCamera,
                color: primaryColor,
              ),
              mic==true ? Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (start==true && stop ==false && upload==false)?
                      buildElevatedButton(bakgcolor: Colors.black,
                        text: 'Start',
                        f: record,
                      ):  buildElevatedButton(bakgcolor: Colors.grey,
                        text: 'Start',

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      (start==false && stop ==true && upload==false)?buildElevatedButton(bakgcolor: Colors.black,
                        text: 'Stop',
                        f: stopRecord,
                      ):buildElevatedButton(bakgcolor: Colors.grey,
                        text: 'Stop',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      (start==false && stop ==false && upload==true)?buildElevatedButton(bakgcolor: Colors.black,
                        text: 'Upload',
                        f: uploadRecord,
                      ):buildElevatedButton(bakgcolor: Colors.grey,
                        text: 'Upload',

                      ),
                    ],
                  ),
                ),
              ): Flexible(
                child: Container(
                  height: 44,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: TextField(
                      onSubmitted: (value) {
                        onSendMessage(textEditingController.text, 'text','','');
                      },
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                      controller: textEditingController,

onEditingComplete: (){  flagchat=false;},
onTap: (){
                        setState(() {
                          flagchat=true;
                        });

    },
                      decoration: InputDecoration.collapsed(

                        hintText: 'Say Hello Zap...',
                        hintStyle: TextStyle(color: greyColor),
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                ),
              ),
           flagchat==true  ?
           IconButton(
                icon: Icon(Icons.send,color: Colors.black,),
                onPressed: () {setState(() {
                  flagchat=false;
                });
                  onSendMessage(textEditingController.text, 'text','','');
                },
                color: primaryColor,
              ):  IconButton(
                icon: Icon(Icons.mic,color: Colors.black,),
                onPressed: () {setState(() {
                  start=true;
                  stop=false;
                  upload=false;
                  mic=!mic;
  //  onSendMessage(textEditingController.text, 'text','','');
                });},

                color: primaryColor,
              ),
            ],
          ),
        ],
      ),
      width: double.infinity,
      height: 70.0,

      decoration: new BoxDecoration(
        color: Colors.white,
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
  Widget buildItem(int index, Message document) {

    if (document != null) {
      if (document.from == uid) {
        // Right (my message)
        return Row(
          children: <Widget>[
            document.message != ''
            // Text
                ? Container(

              width: MediaQuery.of(context).size.width*.50,
              child: Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      document.message, style: TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),

              decoration: BoxDecoration(color: Colors.deepPurpleAccent, borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            )
                : document.url != ''
            // Image
                ? Container(
              child: OutlinedButton(
                child: Material(
                  child: Image.network(
                    document.url,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          color: greyColor2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        width: 200.0,
                        height: 200.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                            value: loadingProgress.expectedTotalBytes != null &&
                                loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return Material(
                        child: Image.asset(
                          'images/img_not_available.jpeg',
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      );
                    },
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                onPressed: () {

                },
                style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
              ),
              margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            )
            // Sticker
                : Container(
              child: Image.asset(
                'images/${document.voice}',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
            ),

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
                      userdata.photourl,
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
                              imageUrl: userdata.photourl,
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
                  document.type == 'text'
                      ? Container(
                    child: Text(
                      document.message,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    width: 150.0,
                    decoration: BoxDecoration(color: Color(0xFF272A36), borderRadius: BorderRadius.circular(8.0)),
                    margin: EdgeInsets.only(left: 10.0),
                  )
                      : document.type == 'text'
                      ? Container(
                    child: TextButton(
                      child: Material(
                        child: Image.network(
                          document.url,
                          loadingBuilder:
                              (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              decoration: BoxDecoration(
                                color: greyColor2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              width: 200.0,
                              height: 200.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  value: loadingProgress.expectedTotalBytes != null &&
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) => Material(
                            child: Image.asset(
                              'images/img_not_available.jpeg',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      onPressed: () {

                      },
                      style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
                    ),
                    margin: EdgeInsets.only(left: 10.0),
                  )
                      : Container(
                    child: Image.asset('images/${document.voice}',
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
                  DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(document.timestamp)),
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
  Widget buildListMessage() {
    return Flexible(

      child: userdata.id.isNotEmpty
          ? StreamBuilder<DataSnapshot>(
        stream: FirebaseDatabase.instance.reference().child("message").child(uid).child(userdata.id).once().asStream(),
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key,values) {
              Map<Object,Object> _values =values;
              print(values.toString());
              listMessage.add(Message.fromJson(_values));
              //  _userlist.add(User.User.fromJson(_values));
            });
            print('vkaaaaaaaaaaaaaaaaaaaaas');
     print(listMessage.length.toString());


            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => buildItem(index, listMessage[index]),
              itemCount: listMessage.length,
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
