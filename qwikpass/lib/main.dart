import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwikpass/core/theme/app_theme.dart';
import 'package:qwikpass/features/auth/screens/onboarding_screen.dart';
import 'package:qwikpass/features/auth/screens/phone_auth_screen.dart';
import 'package:qwikpass/features/auth/screens/otp_verification_screen.dart';
import 'package:qwikpass/features/auth/screens/city_selector_screen.dart';
import 'package:qwikpass/features/home/screens/home_screen.dart';
import 'package:qwikpass/features/events/screens/events_listing_screen.dart';
import 'package:qwikpass/features/events/screens/event_detail_screen.dart';
import 'package:qwikpass/features/booking/screens/live_queue_screen.dart';
import 'package:qwikpass/features/booking/screens/seat_selection_screen.dart';
import 'package:qwikpass/features/booking/screens/group_booking_screen.dart';
import 'package:qwikpass/features/booking/screens/checkout_screen.dart';
import 'package:qwikpass/features/booking/screens/booking_confirmation_screen.dart';
import 'package:qwikpass/features/booking/screens/digital_ticket_screen.dart';
import 'package:qwikpass/features/resale/screens/resale_exchange_screen.dart';
import 'package:qwikpass/features/profile/screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.backgroundDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const StubApp());
}

class StubApp extends StatelessWidget {
  const StubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stub - Fair Ticket Access',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
          case '/onboarding':
            return MaterialPageRoute(
              builder: (_) => const OnboardingScreen(),
            );
          case '/home':
            return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            );
          case '/phone-auth':
            return MaterialPageRoute(
              builder: (_) => const PhoneAuthScreen(),
            );
          case '/otp-verification':
            final phoneNumber = settings.arguments as String? ?? '';
            return MaterialPageRoute(
              builder: (_) => OTPVerificationScreen(phoneNumber: phoneNumber),
            );
          case '/city-selector':
            return MaterialPageRoute(
              builder: (_) => const CitySelectorScreen(),
            );
          case '/events':
            return MaterialPageRoute(
              builder: (_) => const EventsListingScreen(
                category: 'Concerts',
                city: 'Mumbai',
              ),
            );
          case '/event-detail':
            return MaterialPageRoute(
              builder: (_) => const EventDetailScreen(),
            );
          case '/queue':
            return MaterialPageRoute(
              builder: (_) => const LiveQueueScreen(),
            );
          case '/seat-selection':
            return MaterialPageRoute(
              builder: (_) => const SeatSelectionScreen(),
            );
          case '/group-booking':
            return MaterialPageRoute(
              builder: (_) => const GroupBookingScreen(),
            );
          case '/checkout':
            return MaterialPageRoute(
              builder: (_) => const CheckoutScreen(),
            );
          case '/confirmation':
            return MaterialPageRoute(
              builder: (_) => const BookingConfirmationScreen(),
            );
          case '/digital-ticket':
            return MaterialPageRoute(
              builder: (_) => const DigitalTicketScreen(),
            );
          case '/resale':
            return MaterialPageRoute(
              builder: (_) => const ResaleExchangeScreen(),
            );
          case '/profile':
            return MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => const OnboardingScreen(),
            );
        }
      },
    );
  }
}
