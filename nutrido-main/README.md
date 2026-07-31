# App Name: 
NutriDo

## Problem Statement:
NutriDo is designed to revolutionize the way you manage your nutrition. In today's fast-paced world, maintaining a balanced diet can be challenging. NutriDo addresses this problem by providing an intuitive, AI-driven solution to track and analyze your nutritional intake, empowering you to make healthier choices effortlessly.

## Introduction:
Welcome to NutriDo! This README will guide you through the setup and usage of this innovative nutritional tracking application. NutriDo leverages cutting-edge Flutter technology and the advanced capabilities of Google's Gemini API to transform everyday food labels and meals into actionable health insights.

## Features

- **📸 Advanced Label & Food Scanner:** Effortlessly capture and decode product labels and food items with your device's camera.
- **🔍 Intelligent AI Analysis:** Utilize the power of Google's Gemini API for precise, real-time nutritional analysis.
- **📊 Comprehensive Nutrient Tracking:** Monitor your daily nutrient intake with detailed, intuitive breakdowns.
- **📅 Historical Consumption Insights:** Dive into your past food consumption data to track trends and make informed decisions.
- **📈 Stunning Visual Analytics:** Enjoy vibrant, interactive charts that clearly represent your macronutrient distribution.
- **⚡ Real-Time Wellness Insights:** Receive immediate, personalized nutritional recommendations to fuel your health journey.

## Technologies Used:
- **Frontend:** Flutter (Dart)
- **AI Analysis:** Google Gemini API for intelligent, real-time nutritional analysis.
- **Local Storage:** SharedPreferences for robust data management.
- **Additional Packages:**
    - `image_picker` for seamless camera integration.
    - `flutter_dotenv` for secure environment variable management.
    - `fl_chart` for dynamic, interactive data visualizations.
    - `rive` for engaging, fluid animations.

## Installation
Follow these steps to set up and run NutriDo on your local machine.

### Prerequisites:
- **Flutter SDK:** Version >= 3.4.3
- **Dart SDK**
- **Google Gemini API Key**
- **Git:** Installed on your machine

### 1. Clone the Repository:
Clone the NutriDo repository to your local machine:
```bash
git clone https://github.com/sangeetanandanvishal04/nutrido.git
```

### 2. Navigate to the Project Directory:
```bash
cd nutrido
```

### 3. Set Up Environment Variables:
Create a `.env` file in the root directory and add your Gemini API key:
```env
GEMINI_API_KEY=your_api_key
```

### 4. Install Dependencies:
```bash
flutter pub get
```

### 5. Run the App:
```bash
flutter run --no-enable-impeller
```