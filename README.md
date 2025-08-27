
***

# FamPay Flutter Assignment

⏰ **Deadline:** 48 Hours from receiving assignment

---

## 📌 Project Overview

This Flutter project implements a **standalone container** that displays a list of **Contextual Cards** fetched dynamically from an API.  
The cards are **fully dynamic** — their images, colors, texts, buttons (CTAs), and other elements are driven entirely from backend configuration.  

The container is **plug-and-play**, meaning it can be embedded in any screen/widget independently.

---

## 🚀 Features

- **Dynamic Card Rendering**: Cards displayed based on API response  
- **Multiple Card Types Supported**: `HC1`, `HC3`, `HC5`, `HC6`, `HC9`  
- **Deep Link Handling**: All CTAs, formatted text, and taps open respective links  
- **HC3 Actions**  
  - Long press → `Remind Later` / `Dismiss Now`  
- **Pull-to-Refresh**: Swipe down to refresh cards  
- **State Management**: Handles loading, error, and success states  
- **Responsive Design**: Works across different screen sizes  

---

## 🃏 Card Types

- **HC1** → Small Display Card *(title, description, icon)*  
- **HC3** → Big Display Card *(with background image)*  
- **HC5** → Image Card *(with centered content)*  
- **HC6** → Small Card *(with arrow for navigation)*  
- **HC9** → Dynamic Width Card *(height from parent, width based on content)*  

---

## 🌐 API Integration

**API Endpoint:**  

https://polyjuice.kong.fampay.co/mock/famapp/feed/home_section/?slugs=famx-paypage


### Response Structure

- **CardGroup**  
  - `design_type`: `HC1`, `HC3`, `HC5`, `HC6`, `HC9`  
  - `cards`: Array of `CardModel`  
  - `height`: Only for `HC9`  
  - `is_scrollable`: Horizontal scroll (true/false)  

- **CardModel**  
  - `name` *(reference only)*  
  - `title` / `formatted_title`  
  - `description` / `formatted_description`  
  - `icon`, `bg_image`, `bg_color`, `bg_gradient`  
  - `ctas`: Array of Call-to-Action objects  
  - `url`: Deep link for card tap  

- **CTA**  
  - `text`, `bg_color`, `text_color`, `url`  

- **Formatted Text**  
  - `text` with `{}` placeholders  
  - `entities` for styling + clickable text  

- **Entity**  
  - `text`  
  - optional: `color`, `url`, `font_style`  

> ⚠️ Any extra params from API can be ignored.

---
``` 
## 📂 Project Structure


lib/
├── data/
│   ├── models/        # API response models
│   ├── repository/    # Data repository and network services
│   └── services/      # API/network services
├── presentation/
│   ├── cards/         # Widgets for each card type
│   ├── screens/       # Screens embedding the container
│   └── widgets/       # Reusable UI components
├── state/
│   └── providers/     # Provider state management
└── utils/             # Constants and helper functions


---
```
## ⚙️ Setup & Installation

### Prerequisites
- Flutter SDK (>= 2.0.0)  
- Dart SDK (>= 2.12.0)  
- Android Studio / VS Code  
- Git  

### Installation Steps


# Clone the repository
git clone https://github.com/nikhil2004-blip/fampay.git
cd fampay

# Install dependencies
flutter pub get

# Run the app
flutter run


---

## 🔑 Key Components

### ContextualCardsContainer
A plug-and-play widget that can be embedded anywhere:


ContextualCardsContainer(
onCardTap: (url) => handleDeepLink(url),
onRefresh: () => refreshCards(),
)


### HC3 Card Actions
- **Remind Later**: Temporarily remove card until next app restart  
- **Dismiss Now**: Permanently remove card  

---

## 🛠️ State Management
- Uses **Provider pattern** for:  
  - API fetching  
  - Loading & Error states  
  - Card dismissal persistence  

---

## 🎨 UI & Design
- Pixel-perfect implementation (based on Figma design)  
- Handles **dynamic colors, gradients, CTAs, images** from API  
- Responsive layouts across devices  

---

## 🧪 Testing


# Run unit tests
flutter test


- Unit tests → Models & Repository  
- Widget tests → Card UI validation  
- Integration tests → API flow verification  

---

## 📦 Build

### Android APK

flutter build apk --release


### iOS IPA

flutter build ios --release


---

## 📚 Dependencies

```
dependencies:
flutter:
sdk: flutter
provider: ^6.0.0
http: ^0.13.0
shared_preferences: ^2.0.0
cached_network_image: ^3.2.0
url_launcher: ^6.1.0


---
```
***



