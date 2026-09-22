import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';
import 'package:qwikpass/core/widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'upi';
  final TextEditingController _promoController = TextEditingController();
  bool _promoApplied = false;

  @override
  Widget build(BuildContext context) {
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
              'CHECKOUT UPI',
              style: AppTheme.monospaceSmall(context).copyWith(
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
            Text(
              'RESERVATION HOLD EXPIRES',
              style: AppTheme.monospaceXSmall(context).copyWith(
                color: AppTheme.warning,
                fontSize: 9,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: AppTheme.warning,
                ),
                const SizedBox(width: 4),
                Text(
                  '06:30',
                  style: AppTheme.monospaceXSmall(context).copyWith(
                    color: AppTheme.warning,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order summary header
              _buildOrderSummaryHeader(),

              const SizedBox(height: 24),

              // Ticket breakdown
              _buildTicketBreakdown(),

              const SizedBox(height: 24),

              // Promo code
              _buildPromoCodeSection(),

              const SizedBox(height: 24),

              // Payment method selector
              Text(
                'SELECT PAYMENT METHOD • NO GATEWAY CHARGES',
                style: AppTheme.monospaceSmall(context).copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 12),

              _buildPaymentMethod(
                'upi',
                'Instant UPI Rails',
                'PhonePe, GooglePay, Paytm, Bhim',
                Icons.payment,
                AppTheme.primaryYellow,
              ),

              _buildPaymentMethod(
                'card',
                'Debit / Credit Card',
                'Visa, Mastercard, Amex, RuPay',
                Icons.credit_card,
                null,
              ),

              _buildPaymentMethod(
                'wallet',
                'Netbanking',
                'All major banks',
                Icons.account_balance,
                null,
              ),

              const SizedBox(height: 24),

              // UPI ID input (if UPI selected)
              if (_selectedPaymentMethod == 'upi') _buildUPIInput(),

              const SizedBox(height: 24),

              // Fair admission guarantee
              _buildFairAdmissionGuarantee(),

              const SizedBox(height: 24),

              // Total and CTA
              _buildTotalSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummaryHeader() {
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
            'BLOODYWOOD',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 20,
                ),
          ),
          Text(
            'RAAJI TOUR // NSCI DOME, MUMBAI',
            style: AppTheme.monospaceSmall(context).copyWith(
              color: AppTheme.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: AppTheme.borderGray),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderInfo('DATE & TIME', '23 NOV 2024\n19:00 IST'),
              _buildHeaderInfo('ADMISSION SECTION', 'FAN PIT • ROW 3\nSTANDING DESK'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.monospaceXSmall(context).copyWith(
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.monospaceSmall(context).copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketBreakdown() {
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
            'RESERVATION HOLD EXPIRES',
            style: AppTheme.monospaceSmall(context).copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          _buildBreakdownRow('TICKET FACE VALUE (2x ₹2,499)', '₹4,998.00'),
          _buildBreakdownRow('CONVENIENCE EXTENSION', '₹98.00', isStrikethrough: true),
          _buildBreakdownRow('CENTRAL & STATE GST (18%)', '₹973.24'),
          _buildBreakdownRow('SERVICE UNDER FEE (3%+tax)', '₹0.00 ZERO', isSuccess: true),
          Divider(color: AppTheme.borderGray),
          _buildBreakdownRow('DYNAMIC SURGE PRICING', '₹0.00', isSuccess: true),
          const SizedBox(height: 8),
          Text(
            '(ZERO MARKUP · FACE VALUE AT FACE VALUE PROTOCOL)',
            style: AppTheme.monospaceXSmall(context).copyWith(
              color: AppTheme.success,
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 12),
          Divider(color: AppTheme.borderGray),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL PAYABLE',
                style: AppTheme.monospaceMedium(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '₹6,039.24',
                style: AppTheme.monospaceLarge(context).copyWith(
                  color: AppTheme.primaryYellow,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String amount, {bool isSuccess = false, bool isStrikethrough = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.monospaceXSmall(context).copyWith(
              color: AppTheme.textSecondary,
              fontSize: 11,
            ),
          ),
          Text(
            amount,
            style: AppTheme.monospaceSmall(context).copyWith(
              color: isSuccess ? AppTheme.success : AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              decoration: isStrikethrough ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _promoApplied ? AppTheme.success : AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _promoController,
              enabled: !_promoApplied,
              style: AppTheme.monospaceMedium(context),
              decoration: InputDecoration(
                hintText: 'ENTER PROMO CODE',
                hintStyle: AppTheme.monospaceSmall(context).copyWith(
                  color: AppTheme.textTertiary,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (!_promoApplied)
            TextButton(
              onPressed: () {
                setState(() {
                  _promoApplied = true;
                });
              },
              child: Text(
                '[APPLY]',
                style: AppTheme.monospaceSmall(context).copyWith(
                  color: AppTheme.primaryYellow,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else
            Icon(
              Icons.check_circle,
              color: AppTheme.success,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String id, String title, String subtitle, IconData icon, Color? badgeColor) {
    final isSelected = _selectedPaymentMethod == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryYellow.withOpacity(0.1)
              : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryYellow : AppTheme.borderGray,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppTheme.primaryYellow : AppTheme.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: isSelected
                                  ? AppTheme.primaryYellow
                                  : AppTheme.textPrimary,
                            ),
                      ),
                      if (badgeColor != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'FASTEST',
                            style: AppTheme.monospaceXSmall(context).copyWith(
                              color: badgeColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTheme.monospaceXSmall(context).copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppTheme.primaryYellow,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUPIInput() {
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
            'UPI ID / PHONE NUMBER',
            style: AppTheme.monospaceSmall(context).copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            style: AppTheme.monospaceMedium(context),
            decoration: InputDecoration(
              hintText: 'user@okhdfc@bank',
              hintStyle: AppTheme.monospaceMedium(context).copyWith(
                color: AppTheme.textTertiary,
              ),
              suffixIcon: Icon(
                Icons.verified,
                color: AppTheme.success,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFairAdmissionGuarantee() {
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
                Icons.shield_outlined,
                color: AppTheme.accentPurple,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'FAIR ADMISSION GUARANTEE',
                style: AppTheme.monospaceSmall(context).copyWith(
                  color: AppTheme.accentPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildGuaranteeItem('Lock-in verified identity 1:1 ticket binding'),
          _buildGuaranteeItem('256-bit encrypted QR for entry verification'),
          _buildGuaranteeItem('Payment source: Surf face-value resale only'),
          _buildGuaranteeItem('Seat fallback: Sorted face value automatically refunded'),
        ],
      ),
    );
  }

  Widget _buildGuaranteeItem(String text) {
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

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TOTAL DUES',
                    style: AppTheme.monospaceXSmall(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹6,039.24',
                    style: AppTheme.monospaceLarge(context).copyWith(
                      color: AppTheme.primaryYellow,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Pay ₹6,039.24 via UPI ⚡',
            icon: Icons.lock,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/confirmation');
            },
          ),
          const SizedBox(height: 12),
          Text(
            '256-BIT ENCRYPTED • IMMEDIATE ANTI-SCALP VAULT',
            style: AppTheme.monospaceXSmall(context).copyWith(
              color: AppTheme.textTertiary,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }
}
