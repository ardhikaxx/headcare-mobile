import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'main_navigation.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/log_headache/log_headache_screen.dart';
import 'screens/log_headache/log_headache_confirm.dart';
import 'screens/headache_detail/headache_detail_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/assessment/assessment_screen.dart';
import 'screens/assessment/assessment_result_screen.dart';
import 'screens/consultation/doctor_detail_screen.dart';
import 'screens/consultation/booking_screen.dart';
import 'screens/consultation/booking_confirmation_screen.dart';
import 'screens/consultation/consultation_room_screen.dart';
import 'screens/consultation/consultation_history_screen.dart';
import 'screens/education/education_screen.dart';
import 'screens/education/article_detail_screen.dart';
import 'screens/weekly_summary/weekly_summary_screen.dart';
import 'screens/emergency/emergency_screen.dart';
import 'screens/notifications/notifications_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const HeadCareApp());
}

class HeadCareApp extends StatelessWidget {
  const HeadCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeadCare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const MainNavigation(),
        '/log-headache': (context) => const LogHeadacheScreen(),
        '/log-headache-confirm': (context) => const LogHeadacheConfirmScreen(),
        '/headache-detail': (context) => const HeadacheDetailScreen(),
        '/history': (context) => const HistoryScreen(),
        '/assessment': (context) => const AssessmentScreen(),
        '/assessment-result': (context) => const AssessmentResultScreen(),
        '/consult': (context) => const MainNavigation(),
        '/doctor-detail': (context) => const DoctorDetailScreen(),
        '/booking': (context) => const BookingScreen(),
        '/booking-confirmation': (context) => const BookingConfirmationScreen(),
        '/consultation-room': (context) => const ConsultationRoomScreen(),
        '/consultation-history': (context) => const ConsultationHistoryScreen(),
        '/education': (context) => const EducationScreen(),
        '/article-detail': (context) => const ArticleDetailScreen(),
        '/weekly-summary': (context) => const WeeklySummaryScreen(),
        '/emergency': (context) => const EmergencyScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/profile': (context) => const MainNavigation(),
      },
    );
  }
}
