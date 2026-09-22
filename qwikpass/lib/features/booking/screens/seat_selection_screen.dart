import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  // Selected seats (defaults to B14 and B15 as shown in mockup)
  final Set<String> _selectedSeats = {'14', '15'};
  final Set<String> _soldSeats = {'A1', 'A2', 'A6', 'A7', 'A8', 'B16', 'B17', 'B18', 'C3', 'C4', 'C7', 'C8', 'D1', 'D4', 'D7', 'D8'};

  int _remainingSeconds = 211; // 03:31 countdown
  Timer? _holdTimer;

  // Guest assignment state
  String? _guestName;
  String? _guestAadhaar;
  bool _isGuestAssigned = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _holdTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _holdTimer?.cancel();
      }
    });
  }

  String get _formattedTime {
    final m = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  int get _ticketCount => _selectedSeats.length;
  double get _subtotal => _ticketCount * 2499.0;

  void _toggleSeat(String seat) {
    if (_soldSeats.contains(seat)) return;
    setState(() {
      if (_selectedSeats.contains(seat)) {
        if (_selectedSeats.length > 1) {
          _selectedSeats.remove(seat);
        }
      } else {
        if (_selectedSeats.length < 4) {
          _selectedSeats.add(seat);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF1E2432),
              content: Text(
                'Fair Access Limit: Maximum 4 seats per verified ID session.',
                style: GoogleFonts.robotoMono(color: const Color(0xFFFFBE1A), fontSize: 11),
              ),
            ),
          );
        }
      }
    });
  }

  void _openGuestAssignModal() {
    final nameCtrl = TextEditingController(text: _guestName ?? '');
    final aadhaarCtrl = TextEditingController(text: _guestAadhaar ?? '');

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141822),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E3646),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.shield_outlined, color: Color(0xFF00E5FF), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'ASSIGN GUEST DIGILOCKER TOKEN',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Anti-scalping rule: Every additional seat must be cryptographically tied to a real person before payment.',
                style: GoogleFonts.inter(color: const Color(0xFF8E99AA), fontSize: 11),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Guest Full Name (as per Govt ID)',
                  labelStyle: GoogleFonts.robotoMono(color: const Color(0xFF8E99AA), fontSize: 11),
                  filled: true,
                  fillColor: const Color(0xFF0D1017),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF262C3A)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: aadhaarCtrl,
                keyboardType: TextInputType.number,
                maxLength: 12,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Aadhaar / DigiLocker ID (12 digits)',
                  labelStyle: GoogleFonts.robotoMono(color: const Color(0xFF8E99AA), fontSize: 11),
                  filled: true,
                  fillColor: const Color(0xFF0D1017),
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF262C3A)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isNotEmpty && aadhaarCtrl.text.trim().length >= 4) {
                      setState(() {
                        _guestName = nameCtrl.text.trim();
                        final raw = aadhaarCtrl.text.trim();
                        _guestAadhaar = '•••• •••• ${raw.substring(raw.length - 4)}';
                        _isGuestAssigned = true;
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBE1A),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'VERIFY & BIND GUEST PASS',
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B0E),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Top Bar
            _buildTopAppBar(),

            // 2. Sub-header (NSCI DOME • BOM & Timer)
            _buildSubHeader(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // 3. Interactive Venue / Stage & Seat Map Card
                      _buildStageAndSeatMap(),

                      const SizedBox(height: 14),

                      // 4. Selected Allocation Card
                      _buildSelectedAllocationCard(),

                      const SizedBox(height: 14),

                      // 5. 1-ID-1-TICKET PROTOCOL Card
                      _buildProtocolCard(),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // 6. Sticky Bottom Checkout Bar
            _buildBottomCheckoutBar(),
          ],
        ),
      ),
    );
  }

  // 1. Top App Bar
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF141822),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF262C3A)),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),

          // Center: Logo + Title + SECURE badge
          Row(
            children: [
              _buildStubLogo(),
              const SizedBox(width: 8),
              Text(
                'SEAT SELECTI...',
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 9,
                      color: Color(0xFF10B981),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'SECURE',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF10B981),
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right: User Profile Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFBE1A).withValues(alpha: 0.8),
                width: 1.5,
              ),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStubLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFBE1A),
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Text(
        'STUB',
        style: TextStyle(
          color: Colors.black,
          fontSize: 10.5,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // 2. Sub-header (NSCI DOME • BOM & Countdown Timer)
  Widget _buildSubHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFD97706),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'NSCI DOME • BOM',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF141822),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF262C3A),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 13,
                  color: Color(0xFF10B981),
                ),
                const SizedBox(width: 5),
                Text(
                  _formattedTime,
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Interactive Venue / Stage & Seat Map Card
  Widget _buildStageAndSeatMap() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1219),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1E2432),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Curved Stage Indicator Bar
          Center(
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF262F40),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFBE1A),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.equalizer, color: Color(0xFFFFBE1A), size: 13),
                    const SizedBox(width: 6),
                    Text(
                      'STAGE // SOUND PRODUCTION',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF8E99AA),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ZONE 1: FAN PIT (HIGH DECIBEL)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF131722),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF202738),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ZONE: FAN PIT (HIGH DECIBEL)',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF8E99AA),
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '₹2,499',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF10B981),
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row A: A1 - A8
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'].map((seat) {
                    return _buildSeatTile(seat);
                  }).toList(),
                ),

                const SizedBox(height: 8),

                // Row B: ♿, B12, B13, 14, 15, B16, B17, B18
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['♿', 'B12', 'B13', '14', '15', 'B16', 'B17', 'B18'].map((seat) {
                    return _buildSeatTile(seat);
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Side Stands Row: WEST STAND & EAST STAND
          Row(
            children: [
              // WEST STAND
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131722),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF202738)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'WEST STAND',
                            style: GoogleFonts.robotoMono(
                              color: const Color(0xFF8E99AA),
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹1,799',
                            style: GoogleFonts.robotoMono(
                              color: const Color(0xFF10B981),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['C1', 'C2', 'C3', 'C4'].map((s) => _buildSmallSeatTile(s)).toList(),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['D1', 'D2', 'D3', 'D4'].map((s) => _buildSmallSeatTile(s)).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // EAST STAND
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131722),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF202738)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EAST STAND',
                            style: GoogleFonts.robotoMono(
                              color: const Color(0xFF8E99AA),
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹1,799',
                            style: GoogleFonts.robotoMono(
                              color: const Color(0xFF10B981),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['C5', 'C6', 'C7', 'C8'].map((s) => _buildSmallSeatTile(s)).toList(),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['D5', 'D6', 'D7', 'D8'].map((s) => _buildSmallSeatTile(s)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // GENERAL ADMISSION [STANDING REAR]
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF131722),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF202738)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.people_alt_outlined, size: 13, color: Color(0xFF8E99AA)),
                    const SizedBox(width: 6),
                    Text(
                      'GENERAL ADMISSION [STANDING REAR]',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF8E99AA),
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹999',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF8E99AA),
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Seat Legend: Free, Picked, Sold, PwD
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFF1E2636), 'Free', border: const Color(0xFF2E3B52)),
              const SizedBox(width: 18),
              _buildLegendItem(const Color(0xFFFFBE1A), 'Picked', isYellow: true),
              const SizedBox(width: 18),
              _buildLegendItem(const Color(0xFF141720), 'Sold', border: const Color(0xFF1A1F2B)),
              const SizedBox(width: 18),
              _buildLegendItem(const Color(0xFF00E5FF), 'PwD', isIcon: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeatTile(String seat) {
    final isSelected = _selectedSeats.contains(seat);
    final isSold = _soldSeats.contains(seat);
    final isPwd = seat == '♿';

    Color bg = const Color(0xFF1C2230);
    Color border = const Color(0xFF2C374C);
    Color text = const Color(0xFFB0B9C6);

    if (isSelected) {
      bg = const Color(0xFFFFBE1A);
      border = const Color(0xFFFFBE1A);
      text = Colors.black;
    } else if (isPwd) {
      bg = const Color(0xFF00E5FF).withValues(alpha: 0.15);
      border = const Color(0xFF00E5FF);
      text = const Color(0xFF00E5FF);
    } else if (isSold) {
      bg = const Color(0xFF121620);
      border = const Color(0xFF1A1F2C);
      text = const Color(0xFF3E4756);
    }

    return GestureDetector(
      onTap: () => _toggleSeat(seat),
      child: Container(
        width: 32,
        height: 28,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border, width: 1),
        ),
        child: Center(
          child: Text(
            seat,
            style: GoogleFonts.robotoMono(
              color: text,
              fontSize: 9.5,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallSeatTile(String seat) {
    final isSold = _soldSeats.contains(seat);
    return Container(
      width: 28,
      height: 22,
      decoration: BoxDecoration(
        color: isSold ? const Color(0xFF121620) : const Color(0xFF1C2230),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: isSold ? const Color(0xFF1A1F2C) : const Color(0xFF2C374C),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          seat,
          style: GoogleFonts.robotoMono(
            color: isSold ? const Color(0xFF3E4756) : const Color(0xFFB0B9C6),
            fontSize: 8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, {Color? border, bool isYellow = false, bool isIcon = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
            border: border != null ? Border.all(color: border, width: 1) : null,
          ),
          child: isIcon
              ? const Icon(Icons.accessible, size: 8, color: Colors.black)
              : null,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF8E99AA),
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 4. Selected Allocation Card
  Widget _buildSelectedAllocationCard() {
    final seatsList = _selectedSeats.map((s) => s.startsWith('B') ? s : 'B$s').join(', ');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12151D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF202634),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title, Seats & Stepper
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.confirmation_number_outlined,
                        size: 14,
                        color: Color(0xFFFFBE1A),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'FAN PIT TIER 1',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 17,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ROW B • SEATS $seatsList',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),

              // Stepper: - 2 +
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF181D28),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF262F40)),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_selectedSeats.length > 1) {
                          setState(() {
                            _selectedSeats.remove(_selectedSeats.last);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: const Text('-', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '$_ticketCount',
                        style: GoogleFonts.robotoMono(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_selectedSeats.length < 4) {
                          setState(() {
                            final nextSeat = 'B${15 + _selectedSeats.length}';
                            _selectedSeats.add(nextSeat);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: const Text('+', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Breakdown Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BASE TICKET ALLOCATION',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF7E8896),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '₹2,499.00 × $_ticketCount',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFFB5BDCA),
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Subtotal Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SUBTOTAL',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF00E5FF),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '₹${_subtotal.toStringAsFixed(2)}',
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF00E5FF),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 5. 1-ID-1-TICKET PROTOCOL Card (MANDATORY)
  Widget _buildProtocolCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF10131B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1E2430),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 13,
                    color: Color(0xFF00E5FF),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '1-ID-1-TICKET PROTOCOL',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  'MANDATORY',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF10B981),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Seat 1: Primary Holder
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF141822),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF262C3A)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD97706).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFD97706).withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    'B14',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFFBE1A),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Self (Primary Holder)',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Aadhaar: •••• •••• 4920',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF7E8896),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline, color: Color(0xFF10B981), size: 13),
                    const SizedBox(width: 4),
                    Text(
                      'BOUND',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF10B981),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Seat 2: Guest Allocation
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF141822),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF262C3A)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2636),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF2E3B52)),
                  ),
                  child: Text(
                    'B15',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFB0B9C6),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isGuestAssigned ? (_guestName ?? 'Guest Attendee') : 'Guest Allocation',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _isGuestAssigned
                            ? 'DigiLocker: ${_guestAadhaar ?? ""}'
                            : 'Requires DigiLocker Token',
                        style: GoogleFonts.robotoMono(
                          color: _isGuestAssigned
                              ? const Color(0xFF10B981)
                              : const Color(0xFFD97706),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _openGuestAssignModal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: _isGuestAssigned
                          ? const Color(0xFF10B981).withValues(alpha: 0.15)
                          : const Color(0xFF1E2638),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _isGuestAssigned
                            ? const Color(0xFF10B981).withValues(alpha: 0.6)
                            : const Color(0xFF2F3C54),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isGuestAssigned ? Icons.check : Icons.person_add_alt_1,
                          size: 12,
                          color: _isGuestAssigned
                              ? const Color(0xFF10B981)
                              : Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isGuestAssigned ? 'Verified' : 'Assign',
                          style: GoogleFonts.robotoMono(
                            color: _isGuestAssigned
                                ? const Color(0xFF10B981)
                                : Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Footnote Security Notice
          Text(
            '* Proof of Identity verified at Turnstile Gate 3. Digital pass tokens regenerate every 15 seconds to prevent screenshot reselling.',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF7E8896),
              fontSize: 8.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // 6. Sticky Bottom Checkout Bar
  Widget _buildBottomCheckoutBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0E1218),
        border: Border(
          top: BorderSide(
            color: Color(0xFF1E2430),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Total Price & Zero Convenience Fee
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TOTAL [INCL. GST]',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF7E8896),
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '₹${_subtotal.toInt()}',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'ZERO CONV. FEE',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF10B981),
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Right: Proceed Button
            GestureDetector(
              onTap: () {
                // Navigate to Group Booking or Checkout
                Navigator.pushNamed(context, '/group-booking');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBE1A),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFBE1A).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'PROCEED',
                      style: GoogleFonts.robotoMono(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward,
                      size: 15,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
