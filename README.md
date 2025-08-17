<<<<<<< HEAD
# \# Travel App 🛫🏨🚗

# 

# A Flutter application that supports hotel booking, attraction discovery, car rentals, travel news, and user profile management.  

# The project is organized using a \*\*Model + View (UI)\*\* structure with reusable components grouped by feature.

# 

# ---

# 

# \## 📂 Project Structure

# 

# ```bash

# E:.

# ├── firebase\_options.dart        # ⚙️ Firebase configuration

# ├── main.dart                    # 🚀 Application entry point

# │

# ├── components/                  # 🧩 Reusable widgets

# │   ├── attractions/             # 🎡 UI components for attractions

# │   └── stays/                   # 🏨 UI components for hotels/stays

# │

# ├── details\_screen/              # 🔎 Detail screens

# │   ├── details\_attractions.dart

# │   ├── details\_car.dart

# │   ├── details\_news.dart

# │   ├── detail\_stays.dart

# │   └── detail\_travel.dart

# │

# ├── information\_screen/          # 📋 User-related information screens

# │   ├── get\_information\_user.dart

# │   ├── information\_addTour.dart

# │   ├── information\_history.dart

# │   ├── information\_hotel.dart

# │   └── notification\_firebase.dart

# │

# ├── models/                      # 📦 Data models (Hotel, Car, News, Attraction…)

# │

# ├── other/                       # 📑 Miscellaneous supporting screens

# │   ├── attractions/

# │   └── stays/

# │

# ├── screens/                     # 🖥️ Main application screens

# │   ├── Authentication/          # 🔐 Login, Register, Forgot password

# │   └── ChatBot/                 # 🤖 Chatbot support

# │

# └── utils/                       # 🛠️ Utilities \& small custom widgets

# &nbsp;   ├── colors.dart

# &nbsp;   ├── image\_utils.dart

# &nbsp;   ├── loading\_screen.dart

# &nbsp;   └── custom\_text.dart

# 🚀 Features

# &nbsp;  🔐 Authentication: login, register, forgot password (via Firebase).

# &nbsp;  🏨 Search and book hotels.

# &nbsp;  🎡 Discover and search attractions.

# &nbsp;  🚗 Car rental management.

# &nbsp;  📰 Travel news feed.

# &nbsp;  ❤️ Manage favorites and booking history.

# &nbsp;  🤖 Built-in chatbot support.

# &nbsp;  🔔 Push notifications (Firebase).

# &nbsp;  🛠️ Tech Stack

# Flutter for UI

# &nbsp;  Firebase (Authentication, Notifications)

# &nbsp;  Dart models for data handling

# &nbsp;  Custom Widgets for reusable UI

# ▶️ Getting Started

# Clone the repository:

# &nbsp;  git clone https://github.com/Vuonggba1403/BookingTourApp\_Flutter

# Install dependencies:

# &nbsp;  flutter pub get

# Configure Firebase:

# &nbsp;   Add google-services.json (Android) and GoogleService-Info.plist (iOS).

# &nbsp;   The firebase\_options.dart file is pre-configured.

# Run the app:

# &nbsp;   flutter run



=======
# Travel App 🛫🏨🚗

A Flutter application that supports hotel booking, attraction discovery, car rentals, travel news, and user profile management.  
The project is organized using a **Model + View (UI)** structure with reusable components grouped by feature.

---

## 📂 Project Structure

```bash
E:.
├── firebase_options.dart        # ⚙️ Firebase configuration
├── main.dart                    # 🚀 Application entry point
│
├── components/                  # 🧩 Reusable widgets
│   ├── attractions/             # 🎡 UI components for attractions
│   └── stays/                   # 🏨 UI components for hotels/stays
│
├── details_screen/              # 🔎 Detail screens
│   ├── details_attractions.dart
│   ├── details_car.dart
│   ├── details_news.dart
│   ├── detail_stays.dart
│   └── detail_travel.dart
│
├── information_screen/          # 📋 User-related information screens
│   ├── get_information_user.dart
│   ├── information_addTour.dart
│   ├── information_history.dart
│   ├── information_hotel.dart
│   └── notification_firebase.dart
│
├── models/                      # 📦 Data models (Hotel, Car, News, Attraction…)
│
├── other/                       # 📑 Miscellaneous supporting screens
│   ├── attractions/
│   └── stays/
│
├── screens/                     # 🖥️ Main application screens
│   ├── Authentication/          # 🔐 Login, Register, Forgot password
│   └── ChatBot/                 # 🤖 Chatbot support
│
└── utils/                       # 🛠️ Utilities & small custom widgets
    ├── colors.dart
    ├── image_utils.dart
    ├── loading_screen.dart
    └── custom_text.dart
🚀 Features
   🔐 Authentication: login, register, forgot password (via Firebase).
   🏨 Search and book hotels.
   🎡 Discover and search attractions.
   🚗 Car rental management.
   📰 Travel news feed.
   ❤️ Manage favorites and booking history.
   🤖 Built-in chatbot support.
   🔔 Push notifications (Firebase).
   🛠️ Tech Stack
Flutter for UI
   Firebase (Authentication, Notifications)
   Dart models for data handling
   Custom Widgets for reusable UI
▶️ Getting Started
Clone the repository:
   git clone https://github.com/Vuonggba1403/BookingTourApp_Flutter
Install dependencies:
   flutter pub get
Configure Firebase:
    Add google-services.json (Android) and GoogleService-Info.plist (iOS).
    The firebase_options.dart file is pre-configured.
Run the app:
    flutter run
## 📸 Screenshots
### 🏠 Home
  ![Home](assets/screenshots/Home.png)
### 🔐 Login
  ![Login](assets/screenshots/Login.png)
### 🚗 Search Car
  ![Search Car](assets/screenshots/SearchCar.png)
### 🌍 Search Place
  ![Search Place](assets/screenshots/SearchPlace.png)
### 📖 Book Tour
  ![Book Tour](assets/screenshots/BookTour.png)
### 🤖 ChatBot
  ![ChatBot](assets/screenshots/ChatBot.png)
>>>>>>> 07476276aa60ce82af01433ff5843b927d658816
