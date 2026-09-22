import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';
import 'package:qwikpass/core/widgets/custom_button.dart';

class GroupBookingScreen extends StatefulWidget {
  const GroupBookingScreen({Key? key}) : super(key: key);

  @override
  State<GroupBookingScreen> createState() => _GroupBookingScreenState();
}

class _GroupBookingScreenState extends State<GroupBookingScreen> {
  final List<Attendee> _attendees = [
    Attendee(
      name: 'You (Host)',
      phone: '***-***-9020',
      share: 2499,
      isPaid: true,
      isHost: true,
    ),
    Attendee(
      name: 'Rohan Verma',
      phone: '+91 98765-43210',
      share: 2499,
      isPaid: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalAmount = _attendees.fold<int>(
      0,
      (sum, attendee) => sum + attendee.share,
    );
    final paidAmount = _attendees
        .where((a) => a.isPaid)
        .fold<int>(0, (sum, attendee) => sum + attendee.share);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SPLIT TICKET BILL • UPI REQUEST',
              style: AppTheme.monospaceSmall(context).copyWith(
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            Text(
              '12:29 REMAINING',
              style: AppTheme.monospaceXSmall(context).copyWith(
                color: AppTheme.warning,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event header
              _buildEventHeader(),

              const SizedBox(height: 24),

              // Add co-attendee button
              _buildAddAttendeeButton(),

              const SizedBox(height: 24),

              // Attendees list
              Text(
                'CO-ATTENDEE VAULT',
                style: AppTheme.monospaceSmall(context).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 12),

              ..._attendees.map((attendee) => _buildAttendeeCard(attendee)),

              const SizedBox(height: 24),

              // Settlement info
              _buildSettlementInfo(),

              const SizedBox(height: 24),

              // Total summary
              _buildTotalSummary(totalAmount, paidAmount),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(totalAmount, paidAmount),
    );
  }

  Widget _buildEventHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LIVE METRO CONCERT TOUR',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Bloodywood: Return of the Raj / Metal Arena',
                style: AppTheme.monospaceSmall(context).copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: AppTheme.borderGray),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATE & TIME',
                    style: AppTheme.monospaceXSmall(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '23 NOV 2024 • 19:00 IST',
                    style: AppTheme.monospaceSmall(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'SEAT ALLOCATION',
                    style: AppTheme.monospaceXSmall(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'FAN PIT • ROW 3',
                    style: AppTheme.monospaceSmall(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddAttendeeButton() {
    return GestureDetector(
      onTap: () {
        _showAddAttendeeDialog();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryYellow,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primaryYellow.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppTheme.primaryYellow,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'CHANGE ATTENDEE VAULT / PHONE OR UPI HANDLE',
              style: AppTheme.monospaceSmall(context).copyWith(
                color: AppTheme.primaryYellow,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeCard(Attendee attendee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: attendee.isHost
            ? AppTheme.primaryYellow.withOpacity(0.1)
            : AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: attendee.isHost ? AppTheme.primaryYellow : AppTheme.borderGray,
          width: attendee.isHost ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: attendee.isPaid
                  ? AppTheme.success.withOpacity(0.2)
                  : AppTheme.warning.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: attendee.isPaid ? AppTheme.success : AppTheme.warning,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                attendee.name[0].toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: attendee.isPaid ? AppTheme.success : AppTheme.warning,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      attendee.name,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (attendee.isHost) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryYellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'HOST',
                          style: AppTheme.monospaceXSmall(context).copyWith(
                            color: AppTheme.backgroundDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  attendee.phone,
                  style: AppTheme.monospaceXSmall(context).copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Amount and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${attendee.share}',
                style: AppTheme.monospaceMedium(context).copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: attendee.isPaid
                      ? AppTheme.success.withOpacity(0.15)
                      : AppTheme.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  attendee.isPaid ? 'PAID' : 'PENDING',
                  style: AppTheme.monospaceXSmall(context).copyWith(
                    color: attendee.isPaid ? AppTheme.success : AppTheme.warning,
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),

          // Remove button
          if (!attendee.isHost) ...[
            const SizedBox(width: 12),
            IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
                color: AppTheme.textTertiary,
              ),
              onPressed: () {
                setState(() {
                  _attendees.remove(attendee);
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettlementInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.accentPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentPurple.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18,
                color: AppTheme.accentPurple,
              ),
              const SizedBox(width: 8),
              Text(
                'INSTANT SETTLEMENT RULES',
                style: AppTheme.monospaceSmall(context).copyWith(
                  color: AppTheme.accentPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSettlementRule('UPI payment requests sent to all co-attendees'),
          _buildSettlementRule('Payment window: 10min from receipt'),
          _buildSettlementRule('Unpaid shares revert to host'),
          _buildSettlementRule('Ticket base & taxes split evenly (no markup)'),
        ],
      ),
    );
  }

  Widget _buildSettlementRule(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.accentPurple,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTheme.monospaceXSmall(context).copyWith(
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSummary(int total, int paid) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildSummaryRow('TICKET BASE PRICE', '₹4,998.00'),
          _buildSummaryRow('CENTRAL & STATE GST (18%)', '₹899.64'),
          _buildSummaryRow('CONVENIENCE FEE (WAIVED)', '₹0.00', isSuccess: true),
          _buildSummaryRow('DYNAMIC SURGE FEE', '₹0.00 (ZERO MARKUP)', isSuccess: true),
          Divider(color: AppTheme.borderGray),
          _buildSummaryRow(
            'TOTAL EVENT DUES',
            '₹5,897.64',
            isTotal: true,
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: paid / total,
            backgroundColor: AppTheme.borderGray,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.success),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HOST LIABILITY',
                style: AppTheme.monospaceXSmall(context),
              ),
              Text(
                '₹${total - paid} (${((total - paid) / total * 100).toInt()}% PENDING)',
                style: AppTheme.monospaceXSmall(context).copyWith(
                  color: AppTheme.warning,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false, bool isSuccess = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTheme.monospaceSmall(context).copyWith(
                    fontWeight: FontWeight.w700,
                  )
                : AppTheme.monospaceXSmall(context).copyWith(
                    color: AppTheme.textSecondary,
                  ),
          ),
          Text(
            amount,
            style: isTotal
                ? AppTheme.monospaceMedium(context).copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )
                : AppTheme.monospaceSmall(context).copyWith(
                    color: isSuccess ? AppTheme.success : AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(int total, int paid) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(
          top: BorderSide(
            color: AppTheme.borderGray,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: PrimaryButton(
          text: 'Send UPI Split Requests (₹2,499 pending)',
          icon: Icons.send,
          onPressed: () {
            Navigator.pushNamed(context, '/checkout');
          },
        ),
      ),
    );
  }

  void _showAddAttendeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Add Co-Attendee',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppTheme.textTertiary,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone / UPI Handle',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppTheme.textTertiary,
                    ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add attendee
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}

class Attendee {
  final String name;
  final String phone;
  final int share;
  final bool isPaid;
  final bool isHost;

  Attendee({
    required this.name,
    required this.phone,
    required this.share,
    this.isPaid = false,
    this.isHost = false,
  });
}
