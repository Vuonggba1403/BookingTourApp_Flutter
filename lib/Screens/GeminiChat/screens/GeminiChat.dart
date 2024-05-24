import 'dart:io';
import 'dart:typed_data';
import 'package:BookingTourApp/components/curve_navigation_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
    fontSize: 30.0, fontFamily: 'Horizon', fontWeight: FontWeight.bold);

final Gemini gemini = Gemini.instance;

List<ChatMessage> messages = [];

class _GeminiChatState extends State<GeminiChat> {
//tao bien user de tro chuyen
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");

//tao bien goi nguoi dung gemini
  ChatUser geminiUser =
      ChatUser(id: "1", firstName: "Gemini", profileImage: "assets/gemini.png");
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CurveBar(),
                  ));
            },
            icon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.white,
            )),
        centerTitle: true,
        title: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'GEMINI CHAT',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        //them anh
        inputOptions: InputOptions(trailing: [
          IconButton(
              onPressed: () {
                _sendMediaMessage();
              },
              icon: const Icon(Icons.image))
        ]),
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages);
  }

//ham tra ve tin nhan
  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      // them anh
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String reponse = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          setState(() {
            messages = [lastMessage!, ...messages];
          });
          lastMessage.text += reponse;
        } else {
          String reponse = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";

          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: reponse,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image),
          ]);
      _sendMessage(chatMessage);
    }
  }
}
