import 'dart:io';
import 'dart:typed_data';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/colors.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _GeminiChatState();
}

final Gemini gemini = Gemini.instance;

List<ChatMessage> messages = [];

class _GeminiChatState extends State<ChatBot> {
  ChatUser? currentUser;
  final ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "IVIVU Digibot",
    profileImage: "assets/images/chatbot.gif",
  );

  @override
  void initState() {
    super.initState();
    _promptForName(); //Goi hop thoai nhap ten nguoi dung
  }

// Nhap ten nguoi dung
  void _promptForName() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? userName = await showDialog<String>(
        context: context,
        builder: (context) {
          String nameInput = "";
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            title: const Center(child: Text("Enter Your Name")),
            content: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorIcon),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: "Your name", border: InputBorder.none),
                  onChanged: (value) {
                    nameInput = value;
                  },
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(nameInput);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorIcon,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Opensans'),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );

      if (userName != null && userName.trim().isNotEmpty) {
        setState(() {
          currentUser = ChatUser(
            id: "0",
            firstName: userName.trim(),
          );
          _sendWelcomeMessage(userName.trim());
        });
      } else {
        _promptForName();
      }
    });
  }

// Gui tin chao
  void _sendWelcomeMessage(String userName) {
    String welcomeMessage = "Xin chào $userName! \n"
        "Anh/Chị đang được hỗ trợ bởi Trợ lý ảo IVUVU Digibot. \n"
        "Để được hỗ trợ tốt nhất Anh/Chị vui lòng đặt các câu hỏi ngắn gọn, dễ hiểu 👇 ";

    ChatMessage welcomeChatMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: welcomeMessage,
    );

    setState(() {
      messages = [welcomeChatMessage, ...messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                'Chat with IVUVUDigibot',
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
            isRepeatingAnimation: true,
          ),
        ),
        backgroundColor: accentYellowColor,
      ),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : _buildUI(),
    );
  }

// Xuất giao diện chat
  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
          onPressed: _sendMediaMessage,
          icon: const Icon(Icons.image),
        )
      ]),
      currentUser: currentUser!,
      onSend: _sendMessage, // Hàm gửi tin nhắn
      messages: messages, // Danh sách tin nhắn
    );
  }

  // Hàm tìm kiếm khách sạn theo địa điểm
  Future<void> _searchHotels(String placed) async {
    try {
      // Truy vấn Firestore dựa trên trường `placed`
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('hotel') // Tên bộ sưu tập
          .where('placed', isEqualTo: placed) // Điều kiện tìm kiếm
          .get();

      List<ChatMessage> hotelMessages = []; // Danh sách tin nhắn khách sạn

      if (snapshot.docs.isNotEmpty) {
        // Lấy dữ liệu từ từng tài liệu
        for (var doc in snapshot.docs) {
          String name = doc.get('name') ?? "Không rõ tên khách sạn";
          String detail =
              doc.get('detail_placed') ?? "Không có thông tin chi tiết";

          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "Khách sạn: $name\nChi tiết: $detail",
          );

          hotelMessages.add(message);
        }
      } else {
        // Trường hợp không tìm thấy khách sạn
        hotelMessages.add(ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "Không tìm thấy khách sạn nào ở địa điểm: $placed.",
        ));
      }

      // Cập nhật tin nhắn lên giao diện
      setState(() {
        messages = [...hotelMessages, ...messages];
      });
    } catch (e) {
      // Xử lý lỗi
      setState(() {
        messages = [
          ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "Đã xảy ra lỗi khi tìm kiếm khách sạn. Vui lòng thử lại sau.",
          ),
          ...messages,
        ];
      });
      print("Error searching hotels: $e");
    }
  }

  //
  // Hàm tìm kiếm khách sạn theo địa điểm
  Future<void> _searchTours(String placed) async {
    try {
      // Truy vấn Firestore dựa trên trường `placed`
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Placed') // Tên bộ sưu tập
          .where('placed', isEqualTo: placed) // Điều kiện tìm kiếm
          .get();

      List<ChatMessage> hotelMessages = []; // Danh sách tin nhắn khách sạn

      if (snapshot.docs.isNotEmpty) {
        // Lấy dữ liệu từ từng tài liệu
        for (var doc in snapshot.docs) {
          String money = doc.get('money') ?? "Không rõ !";
          String detail = doc.get('des') ?? "Không có thông tin chi tiết";

          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "Giá: $money VND \n Chi tiết tour: $detail",
          );

          hotelMessages.add(message);
        }
      } else {
        // Trường hợp không tìm thấy tour
        hotelMessages.add(ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "Không tìm thấy tour nào ở địa điểm: $placed.",
        ));
      }

      // Cập nhật tin nhắn lên giao diện
      setState(() {
        messages = [...hotelMessages, ...messages];
      });
    } catch (e) {
      // Xử lý lỗi
      setState(() {
        messages = [
          ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "Đã xảy ra lỗi khi tìm kiếm tour. Vui lòng thử lại sau.",
          ),
          ...messages,
        ];
      });
      print("Error searching tours: $e");
    }
  }

//Ham gửi tin nhắn
  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;

      // Kiểm tra nếu câu hỏi liên quan đến tìm kiếm khách sạn
      if (question.toLowerCase().contains("tìm khách sạn ở")) {
        String location =
            question.split("tìm khách sạn ở")[1].trim(); // Lấy địa điểm
        await _searchHotels(location);
        return; // Không gọi Gemini nếu tìm kiếm khách sạn
      }

      // Kiểm tra nếu câu hỏi liên quan đến tìm kiếm tour
      if (question.toLowerCase().contains("tìm tour ở")) {
        String location =
            question.split("tìm tour ở")[1].trim(); // Lấy địa điểm
        await _searchTours(location);
        return; // Không gọi Gemini nếu tìm kiếm khách sạn
      }

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
          String response = event.output ??
              ""; // Changed from event.content?.parts?.fold to event.output
          setState(() {
            messages = [lastMessage!, ...messages];
          });
          lastMessage.text += response;
        } else {
          String response = event.output ??
              ""; // Changed from event.content?.parts?.fold to event.output

          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
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
        user: currentUser!,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(url: file.path, fileName: "", type: MediaType.image),
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
