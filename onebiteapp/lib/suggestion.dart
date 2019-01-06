// // 건의사항
// // 버그신고



// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
// import 'platform_adaptive.dart';
// import 'type_meme.dart';

// class SuggestionPage extends StatelessWidget {
//   final FirebaseUser user;
//   SuggestionPage({this.user});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'chat',
//       theme: defaultTargetPlatform == TargetPlatform.iOS
//           ? kIOSTheme
//           : kDefaultTheme,
//       home: ChatScreen(user),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   final FirebaseUser user;
//   ChatScreen(this.user);
//   @override
//   ChatScreenState createState() => ChatScreenState(user : this.user);
// }

// class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
//   final FirebaseUser user;
//   ChatScreenState({this.user});
//   List<ChatMessage> _messages = [];
//   DatabaseReference _messagesReference = FirebaseDatabase.instance.reference();
//   TextEditingController _textController = TextEditingController();
//   bool _isComposing = false;
//   GoogleSignIn _googleSignIn = GoogleSignIn();
//   var fireBaseSubscription;


//   @override
//   void initState() {
//     print('here');
//     print('${this.user.displayName}');
//     super.initState();
//     // _googleSignIn.signInSilently();
//     FirebaseAuth.instance.signInAnonymously().then((user) {
//       fireBaseSubscription =
//           _messagesReference.onChildAdded.listen((Event event) {
//         var val = event.snapshot.value;
//         _addMessage(
//             name: val['sender']['name'],
//             senderImageUrl: val['sender']['imageUrl'],
//             text: val['text'],
//             imageUrl: val['imageUrl'],
//             textOverlay: val['textOverlay']);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     for (ChatMessage message in _messages) {
//       message.animationController.dispose();
//     }
//     fireBaseSubscription.cancel();
//     super.dispose();
//   }

//   void _handleMessageChanged(String text) {
//     setState(() {
//       _isComposing = text.length > 0;
//     });
//   }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     _googleSignIn.signIn().then((user) {
//       var message = {
//         'sender': {'name': this.user.displayName, 'imageUrl': this.user.photoUrl},
//         'text': text,
//       };
//       _messagesReference.push().set(message);
//     });
//     setState(() {
//       _isComposing = false;
//     });
//   }

//   void _addMessage({String name, String text, String imageUrl, String textOverlay, String senderImageUrl}) {
//     var animationController = AnimationController(
//       duration: Duration(milliseconds: 700),
//       vsync: this,
//     );
//     var sender = ChatUser(name: name, imageUrl: senderImageUrl);
//     var message = ChatMessage(
//         sender: sender,
//         text: text,
//         imageUrl: imageUrl,
//         textOverlay: textOverlay,
//         animationController: animationController);
//     setState(() {
//       _messages.insert(0, message);
//     });
//     if (imageUrl != null) {
//       NetworkImage image = NetworkImage(imageUrl);
//       image
//           .resolve(createLocalImageConfiguration(context))
//           .addListener((_, __) {
//         animationController?.forward();
//       });
//     } else {
//       animationController?.forward();
//     }
//   }

//   Future<Null> _handlePhotoButtonPressed() async {
//     // var account = await _googleSignIn.signIn();
//     var account = this.user;
//     var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//     var random = Random().nextInt(10000);
//     var ref = FirebaseStorage.instance.ref().child('image_$random.jpg');
//     ref.putFile(imageFile);
//     var textOverlay = await Navigator.push(context, TypeMemeRoute(imageFile));
//     if (textOverlay == null) return;
//     String downloadUrl = await ref.getDownloadURL();
//     var message = {
//       'sender': {'name': account.displayName, 'imageUrl': account.photoUrl},
//       'imageUrl': downloadUrl.toString(),
//       'textOverlay': textOverlay,
//     };
//     _messagesReference.push().set(message);
//   }

//   Widget _buildTextComposer() {
//     return IconTheme(
//         data: IconThemeData(color: Theme.of(context).accentColor),
//         child: PlatformAdaptiveContainer(
//             margin: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 4.0),
//                 child: IconButton(
//                   icon: Icon(Icons.photo),
//                   onPressed: _handlePhotoButtonPressed,
//                 ),
//               ),
//               Flexible(
//                 child: TextField(
//                   controller: _textController,
//                   onSubmitted: _handleSubmitted,
//                   onChanged: _handleMessageChanged,
//                   decoration:
//                       InputDecoration.collapsed(hintText: 'Send a message'),
//                 ),
//               ),
//               Container(
//                   margin: EdgeInsets.symmetric(horizontal: 4.0),
//                   child: PlatformAdaptiveButton(
//                     icon: Icon(Icons.send),
//                     onPressed: _isComposing
//                         ? () => _handleSubmitted(_textController.text)
//                         : null,
//                     child: Text('Send'),
//                   )),
//             ])));
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PlatformAdaptiveAppBar(
//           // title: Text('chat!!'),
//           title: Text('${this.user.displayName}'),
//           platform: Theme.of(context).platform,
//         ),
//         body: Column(children: [
//           Flexible(
//               child: ListView.builder(
//             padding: EdgeInsets.all(8.0),
//             reverse: true,
//             itemBuilder: (_, int index) =>
//                 ChatMessageListItem(_messages[index]),
//             itemCount: _messages.length,
//           )),
//           Divider(height: 1.0),
//           Container(
//               decoration: BoxDecoration(color: Theme.of(context).cardColor),
//               child: _buildTextComposer()),
//         ]));
//   }
// }

// class ChatUser {
//   ChatUser({this.name, this.imageUrl});
//   final String name;
//   final String imageUrl;
// }

// class ChatMessage {
//   ChatMessage(
//       {this.sender,
//       this.text,
//       this.imageUrl,
//       this.textOverlay,
//       this.animationController});
//   final ChatUser sender;
//   final String text;
//   final String imageUrl;
//   final String textOverlay;
//   final AnimationController animationController;
// }

// class ChatMessageListItem extends StatelessWidget {
//   ChatMessageListItem(this.message);

//   final ChatMessage message;

//   Widget build(BuildContext context) {
//     print('chatmessage');
//     print('${message.text}');
//     return SizeTransition(
//         sizeFactor: CurvedAnimation(
//             parent: message.animationController, curve: Curves.easeOut),
//         axisAlignment: 0.0,
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(right: 16.0),
//                 child: CircleAvatar(
//                     backgroundImage: NetworkImage(message.sender.imageUrl)),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(message.sender.name,
//                       style: Theme.of(context).textTheme.subhead),
//                   Container(
//                       margin: const EdgeInsets.only(top: 5.0),
//                       child: ChatMessageContent(message)),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class ChatMessageContent extends StatelessWidget {
//   ChatMessageContent(this.message);

//   final ChatMessage message;

//   Widget build(BuildContext context) {
//     if (message.imageUrl != null) {
//       var image = Image.network(message.imageUrl, width: 200.0);
//       if (message.textOverlay == null) {
//         return image;
//       } else {
//         return Stack(
//           alignment: FractionalOffset.topCenter,
//           children: [
//             image,
//             Container(
//                 alignment: FractionalOffset.topCenter,
//                 width: 200.0,
//                 child: Text(message.textOverlay,
//                     style: const TextStyle(
//                         fontFamily: 'Anton',
//                         fontSize: 30.0,
//                         color: Colors.white),
//                     softWrap: true,
//                     textAlign: TextAlign.center)),
//           ],
//         );
//       }
//     } else {
//       print(message.text);
//       return Text(message.text);
//     }
//   }
// }

// // // final ThemeData kIOSTheme = new ThemeData(
// // //   primarySwatch: Colors.orange,
// // //   primaryColor: Colors.grey[100],
// // //   primaryColorBrightness: Brightness.light,
// // // );

// // // final ThemeData kDefaultTheme = new ThemeData(
// // //   primarySwatch: Colors.purple,
// // //   accentColor: Colors.orangeAccent[400],
// // // );

// // // const String _name = "Username";

// // // class SuggestionPage extends StatelessWidget {
// // //   // FirebaseUser user;
// // //   // SuggestionPage({Key key, this.user});
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return new MaterialApp(
// // //       title: "Friendlychat",
// // //       theme: defaultTargetPlatform == TargetPlatform.iOS
// // //           ? kIOSTheme
// // //           : kDefaultTheme,
// // //       home: new ChatScreen(),
// // //     );
// // //   }
// // // }

// // // class SuggestionBody extends StatelessWidget {
// // //   SuggestionBody({this.text, this.animationController});
// // //   final String text;
// // //   final AnimationController animationController;
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return new SizeTransition(
// // //         sizeFactor: new CurvedAnimation(
// // //             parent: animationController,
// // //             curve: Curves.easeOut
// // //         ),
// // //         axisAlignment: 0.0,
// // //         child: new Container(
// // //           margin: const EdgeInsets.symmetric(vertical: 10.0),
// // //           child: new Row(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: <Widget>[
// // //               new Expanded(
// // //                 child: new Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: <Widget>[
// // //                     new Text(_name, style: Theme.of(context).textTheme.subhead),
// // //                     new Container(
// // //                       margin: const EdgeInsets.only(top: 5.0),
// // //                       child: new Text(text),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               new Container(
// // //                 margin: const EdgeInsets.only(right: 16.0),
// // //                 child: new CircleAvatar(child: new Text(_name[0])),
// // //               ),
// // //             ],
// // //           ),
// // //         )
// // //     );
// // //   }
// // // }

// // // class ChatScreen extends StatefulWidget {
// // //   @override
// // //   State createState() => new ChatScreenState();
// // // }

// // // class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
// // //   final List<SuggestionBody> _messages = <SuggestionBody>[];
// // //   final TextEditingController _textController = new TextEditingController();
// // //   bool _isComposing = false;

// // //   void _handleSubmitted(String text) {
// // //     _textController.clear();
// // //     setState(() {
// // //       _isComposing = false;
// // //     });

// // //     SuggestionBody message = new SuggestionBody(
// // //       text: text,
// // //       animationController: new AnimationController(
// // //         duration: new Duration(milliseconds: 500),
// // //         vsync: this,
// // //       ),
// // //     );
// // //     setState(() {
// // //       _messages.insert(0, message);
// // //     });
// // //     message.animationController.forward();
// // //   }

// // //   void dispose() {
// // //     for (SuggestionBody message in _messages)
// // //       message.animationController.dispose();
// // //     super.dispose();
// // //   }

// // //   Widget _buildTextComposer() {
// // //     return new IconTheme(
// // //       data: new IconThemeData(color: Theme.of(context).accentColor),
// // //       child: new Container(
// // //           margin: const EdgeInsets.symmetric(horizontal: 8.0),
// // //           child: new Row(children: <Widget>[
// // //             new Flexible(
// // //               child: new TextField(
// // //                 controller: _textController,
// // //                 onChanged: (String text) {
// // //                   setState(() {
// // //                     _isComposing = text.length > 0;
// // //                   });
// // //                 },
// // //                 onSubmitted: _handleSubmitted,
// // //                 decoration:
// // //                 new InputDecoration.collapsed(hintText: "Send a message"),
// // //               ),
// // //             ),
// // //             new Container(
// // //                 margin: new EdgeInsets.symmetric(horizontal: 4.0),
// // //                 child: new IconButton (
// // //                   //divide cases into two different cases -> two different icons!
// // //                   icon : _isComposing
// // //                   ? new Icon(Icons.directions_run)
// // //                   : new Icon(Icons.directions_walk),

// // //                   onPressed: _isComposing
// // //                   ? () => _handleSubmitted(_textController.text)
// // //                   : null,
// // //                   ),
// // //                 ),
// // //           ]),
// // //           decoration: Theme.of(context).platform == TargetPlatform.iOS
// // //               ? new BoxDecoration(
// // //               border:
// // //               new Border(top: new BorderSide(color: Colors.grey[200])))
// // //               : null),
// // //     );
// // //   }

// // //   Widget build(BuildContext context) {
// // //     return new Scaffold(
// // //       appBar: new AppBar(
// // //           title: new Text("건의사항"),
// // //           elevation:
// // //           Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0
// // //       ),
// // //       body: new Container(
// // //           child: new Column(
// // //               children: <Widget>[
// // //                 new Flexible(
// // //                     child: new ListView.builder(
// // //                       padding: new EdgeInsets.all(8.0),
// // //                       reverse: true,
// // //                       itemBuilder: (_, int index) => _messages[index],
// // //                       itemCount: _messages.length,
// // //                     )
// // //                 ),
// // //                 new Divider(height: 1.0),
// // //                 new Container(
// // //                   decoration: new BoxDecoration(
// // //                       color: Theme.of(context).cardColor),
// // //                   child: _buildTextComposer(),
// // //                 ),
// // //               ]
// // //           ),
// // //           decoration: Theme.of(context).platform == TargetPlatform.iOS ? new BoxDecoration(border: new Border(top: new BorderSide(color: Colors.grey[200]))) : null),//new
// // //     );
// // //   }
// // // }

