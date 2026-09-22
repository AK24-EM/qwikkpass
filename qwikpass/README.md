# Stub - Fair Ticket Access App

A comprehensive Flutter mobile application for fair, anti-scalping ticket booking with identity verification and face-value resale enforcement. Built with a nightlife-inspired design featuring perforated ticket aesthetics and thermal-print typography.

## Design Philosophy

**Visual Theme:** Nightlife-inspired with physical ticket aesthetics
- Perforated dividers with circular notches
- Torn-edge stub cards
- Thermal-print typography for data fields
- Bold condensed display font (Bebas Neue) for headlines
- Clean sans-serif (Inter) for body text
- Monospace font (Roboto Mono) for all data: seats, prices, codes, queue positions, timestamps

**Color Palette:**
- Primary Accent: Yellow (`#FFC107`)
- Background: Dark (`#0A0C10`)
- Secondary Accents: Purple, Blue, Green, Red for status indicators
- Subtle borders and surfaces for depth

## Features

### 🎫 Core Booking Flow
1. **Onboarding & Authentication**
   - 3-page onboarding explaining fair access principles
   - Phone number + OTP verification
   - City selector with popular/other cities
   - Identity verification requirement explanation

2. **Home & Discovery**
   - Location-based event discovery
   - Horizontal category tabs (Concerts, Movies, Sports, Theatre, Comedy)
   - AI-powered natural language search
   - Personalized recommendations
   - "Selling Fast" carousel
   - Bottom navigation (Discover, Bookings, Resale, Profile)

3. **Event Browsing & Details**
   - Filterable event grid (Date, Price, Accessibility)
   - Event detail with collapsing hero image
   - Tabbed content (About, Venue, Reviews)
   - Multiple price tiers with face-value pricing
   - Live Fair Queue position tracking

4. **Fair Queue System**
   - Real-time queue position counter (#4042 → #0000)
   - Animated countdown with progress bar
   - Estimated wait time display
   - Anti-bot security messaging
   - Queue integrity statistics (99.1%)

5. **Seat Selection**
   - Interactive 8x8 seat grid
   - Visual seat states (Available, Selected, Taken)
   - Max 4 tickets per booking
   - 1-to-1 identity binding notices
   - Real-time price calculation with zero markup

6. **Group Booking & Bill Split**
   - Add co-attendees with phone/UPI handles
   - Per-person share allocation
   - Payment status tracking (Paid/Pending)
   - UPI payment request automation
   - Host liability tracker

7. **Checkout & Payment**
   - Receipt-style order summary
   - Multiple payment methods (UPI, Card, Netbanking)
   - Promo code support
   - Transparent pricing breakdown (GST, fees, zero markup)
   - Session timer with reservation hold

8. **Booking Confirmation**
   - Success animation
   - Ticket stub preview with perforation
   - Confirmation code and payment details
   - Share and add-to-wallet options

9. **Digital Ticket**
   - Full ticket stub layout with perforated tear line
   - QR code for entry verification
   - Barcode for backup scanning
   - Monospace data display (seat, gate, section, row)
   - On-demand authenticity re-check
   - Face-value resale reminder

### 🛡️ Anti-Scalping Features
- **Identity Binding:** Each ticket bound to verified user
- **Fair Queue:** Bot-blocking queue system with real-time position
- **Face-Value Resale:** Resale permitted only at face value
- **Zero Dynamic Pricing:** No surge pricing or markup
- **Verified Fan Exchange:** Controlled secondary market

## Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart              # Complete theme configuration
│   └── widgets/
│       ├── perforated_card.dart        # Ticket stub with notches
│       ├── stub_card.dart              # Event card component
│       ├── custom_button.dart          # Primary/Secondary buttons
│       └── chips_and_tags.dart         # Filter chips and status tags
│
├── features/
│   ├── auth/
│   │   └── screens/
│   │       ├── onboarding_screen.dart
│   │       ├── phone_auth_screen.dart
│   │       ├── otp_verification_screen.dart
│   │       └── city_selector_screen.dart
│   │
│   ├── home/
│   │   ├── screens/
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── event_carousel.dart
│   │       └── ai_search_card.dart
│   │
│   ├── events/
│   │   └── screens/
│   │       ├── events_listing_screen.dart
│   │       └── event_detail_screen.dart
│   │
│   └── booking/
│       └── screens/
│           ├── live_queue_screen.dart
│           ├── seat_selection_screen.dart
│           ├── group_booking_screen.dart
│           ├── checkout_screen.dart
│           ├── booking_confirmation_screen.dart
│           └── digital_ticket_screen.dart
│
└── main.dart                           # App entry point with routing
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # QR Code and barcode generation
  qr_flutter: ^4.1.0
  barcode_widget: ^2.0.4
  
  # SVG support
  flutter_svg: ^2.0.10
  
  # Date/time formatting
  intl: ^0.19.0
  
  # State management and navigation
  provider: ^6.1.2
  go_router: ^14.6.2
  
  # UI enhancements
  google_fonts: ^6.2.1
  flutter_animate: ^4.5.0
  dotted_border: ^2.1.0
  
  # Icons
  phosphor_flutter: ^2.1.0
```

## Getting Started

### Prerequisites
- Flutter SDK 3.13.1 or higher
- Dart SDK
- iOS Simulator / Android Emulator or physical device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd qwikpass
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Key Screens & Routes

| Route | Screen | Description |
|-------|--------|-------------|
| `/` | OnboardingScreen | 3-page intro to fair access |
| `/phone-auth` | PhoneAuthScreen | Phone number entry |
| `/otp-verification` | OTPVerificationScreen | 6-digit OTP input |
| `/city-selector` | CitySelectorScreen | Choose your city |
| `/home` | HomeScreen | Main discovery feed |
| `/events` | EventsListingScreen | Filtered event grid |
| `/event-detail` | EventDetailScreen | Event info with queue |
| `/queue` | LiveQueueScreen | Live queue countdown |
| `/seat-selection` | SeatSelectionScreen | Interactive seat map |
| `/group-booking` | GroupBookingScreen | Bill split interface |
| `/checkout` | CheckoutScreen | Payment processing |
| `/confirmation` | BookingConfirmationScreen | Success state |
| `/digital-ticket` | DigitalTicketScreen | QR/barcode ticket |

## Design System

### Typography
- **Display:** Bebas Neue (Bold Condensed) - Event titles, headlines
- **Body:** Inter (Regular/Medium/Semibold) - General content
- **Data:** Roboto Mono (Regular/Medium/Bold) - Prices, codes, timestamps

### Components
- **PerforatedCard:** Container with circular notches and dashed divider
- **StubCard:** Event card with tear edge and thermal-print aesthetic
- **FilterChip:** Rounded chip for filtering with active state
- **StatusTag:** Small label for event status (Live, Hot Seller, etc.)
- **PrimaryButton:** Yellow CTA button with icon support
- **SecondaryButton:** Outlined button for secondary actions

### Color Usage
- **Yellow Accent:** Primary CTAs, selected states, prices
- **Purple:** Identity verification, security features
- **Green:** Success states, fair pricing indicators
- **Red:** Warning states, live event badges
- **Blue:** Information highlights

## Implementation Notes

### Fair Queue System
- Simulated countdown from #4042 to #0000
- Auto-progresses every 2 seconds
- Navigates to seat selection when complete
- Cannot be skipped or bypassed

### Seat Selection
- 8x8 grid with labeled rows/columns
- Click to select/deselect (max 4 seats)
- Some seats pre-marked as taken
- Real-time total calculation

### Payment Flow
- Multiple payment methods (UPI recommended)
- Transparent fee breakdown
- Zero markup messaging
- Session timer for urgency

### Digital Ticket
- QR code generated from booking code
- Code128 barcode for backup
- Monospace formatting for all data
- Verification status display

## Accessibility Features
- Wheelchair access filtering
- Sign language interpreted events
- Sensory-friendly options
- High contrast mode support
- Screen reader compatible

## Security & Fair Access
- **Identity Verification:** One ticket per verified identity
- **Anti-Bot Protocol:** Queue integrity checks, session monitoring
- **Face-Value Cap:** Resale restricted to original price
- **Encrypted QR:** 256-bit encryption for entry codes
- **Biometric Re-verification:** On-demand security checks

## Future Enhancements
- [ ] Profile & Settings screen
- [ ] Verified Resale Exchange marketplace
- [ ] Past bookings history
- [ ] Notification system
- [ ] Payment gateway integration
- [ ] Backend API integration
- [ ] Biometric authentication
- [ ] Multi-language support (Hindi, Marathi, Tamil, etc.)
- [ ] Dark/Light theme toggle
- [ ] Offline ticket viewing

## Contributing
This is a UI demonstration project. Contributions for completing remaining screens and adding functionality are welcome.

## License
This project is created for demonstration purposes.

## Credits
Design inspired by modern ticket booking platforms with a focus on fair access and anti-scalping measures.

---

**Built with Flutter 💙**
