import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool _biometricAuth = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = true;

  // Push notification sub-options
  bool _notifEventReminders = true;
  bool _notifQueueUpdates = true;
  bool _notifOffers = false;
  bool _notifNearbyEvents = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile
              _buildProfileHeader(),

              const SizedBox(height: 24),

              // Verification status
              _buildVerificationStatus(),

              const SizedBox(height: 24),

              // Account section
              _buildSection('ACCOUNT'),
              _buildMenuItem(
                Icons.person_outline,
                'Personal Information',
                'Aditya Sharma, +91 98765-43210',
                () {},
              ),
              _buildMenuItem(
                Icons.location_on_outlined,
                'Saved Addresses',
                '3 addresses',
                () {},
              ),
              _buildMenuItem(
                Icons.payment_outlined,
                'Payment Methods',
                '2 UPI, 1 card',
                () {},
              ),

              const SizedBox(height: 24),

              // Security section
              _buildSection('SECURITY & PRIVACY'),
              _buildSwitchMenuItem(
                Icons.fingerprint,
                'Biometric Authentication',
                'Touch ID enabled for quick access',
                _biometricAuth,
                (value) {
                  setState(() {
                    _biometricAuth = value;
                  });
                },
              ),
              _buildMenuItem(
                Icons.lock_outline,
                'Change PIN',
                'Last changed 30 days ago',
                () {},
              ),
              _buildMenuItem(
                Icons.shield_outlined,
                'Trusted Devices',
                '2 active sessions',
                () {},
              ),

              const SizedBox(height: 24),

              // Preferences section
              _buildSection('PREFERENCES'),
              _buildMenuItem(Icons.language, 'Language', 'English', () {}),
              _buildMenuItem(
                Icons.accessible,
                'Accessibility Settings',
                'Wheelchair view, Sign language',
                () {},
              ),
              _buildSwitchMenuItem(
                Icons.dark_mode_outlined,
                'Dark Mode',
                'Always on',
                true,
                null,
              ),

              const SizedBox(height: 24),

              // Notifications section
              _buildSection('NOTIFICATIONS'),
              _buildPushNotificationsSection(),
              _buildSwitchMenuItem(
                Icons.email_outlined,
                'Email Notifications',
                'Booking confirmations',
                _emailNotifications,
                (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
              ),
              _buildSwitchMenuItem(
                Icons.sms_outlined,
                'SMS Notifications',
                'OTP and alerts',
                _smsNotifications,
                (value) {
                  setState(() {
                    _smsNotifications = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Support section
              _buildSection('SUPPORT'),
              _buildMenuItem(
                Icons.help_outline,
                'Help Center',
                'FAQs & Support',
                () {},
              ),
              _buildMenuItem(
                Icons.article_outlined,
                'Terms & Policies',
                'Terms, Privacy, Refunds',
                () {},
              ),
              _buildMenuItem(
                Icons.info_outline,
                'About Stub',
                'Version 1.0.0 • Build 2024',
                () {},
              ),

              const SizedBox(height: 24),

              // Danger zone
              _buildSection('ACCOUNT ACTIONS'),
              _buildMenuItem(
                Icons.logout,
                'Log Out of Secure Identity Session',
                '',
                () {
                  _showLogoutDialog();
                },
                isDanger: true,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.accentPurple.withOpacity(0.2),
            AppTheme.surfaceDark,
          ],
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryYellow.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryYellow, width: 3),
            ),
            child: Center(
              child: Text(
                'AS',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppTheme.primaryYellow,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(width: 20),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aditya Sharma',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  '+91 98765-43210',
                  style: AppTheme.monospaceSmall(context)
                      .copyWith(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppTheme.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Mumbai, Maharashtra',
                      style: AppTheme.monospaceXSmall(context)
                          .copyWith(color: AppTheme.textTertiary),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Edit button
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
            color: AppTheme.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.success.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user, color: AppTheme.success, size: 24),
              const SizedBox(width: 12),
              Text(
                'GOVERNMENT IDENTITY VAULT',
                style: AppTheme.monospaceSmall(context).copyWith(
                  color: AppTheme.success,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildVerificationItem('AADHAAR', 'VERIFIED', '99.1%'),
              ),
              Container(width: 1, height: 40, color: AppTheme.borderGray),
              Expanded(
                child: _buildVerificationItem(
                  'GSTN SEL SIGN+ECC',
                  'VERIF PAN',
                  'PIN-LOOK LIMIT',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Your identity is cryptographically bound to your bookings. This prevents scalping and ensures fair access.',
            style: AppTheme.monospaceXSmall(context)
                .copyWith(color: AppTheme.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationItem(String label, String status, String detail) {
    return Column(
      children: [
        Text(
          label,
          style: AppTheme.monospaceXSmall(context).copyWith(fontSize: 9),
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: AppTheme.monospaceSmall(context).copyWith(
            color: AppTheme.success,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        Text(
          detail,
          style: AppTheme.monospaceXSmall(context)
              .copyWith(color: AppTheme.textTertiary, fontSize: 8),
        ),
      ],
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: AppTheme.monospaceSmall(context).copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDanger = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDanger
                    ? AppTheme.error.withOpacity(0.1)
                    : AppTheme.cardDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isDanger ? AppTheme.error : AppTheme.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: isDanger ? AppTheme.error : AppTheme.textPrimary,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTheme.monospaceXSmall(context)
                          .copyWith(color: AppTheme.textTertiary, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppTheme.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchMenuItem(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Function(bool)? onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppTheme.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTheme.monospaceXSmall(context)
                      .copyWith(color: AppTheme.textTertiary, fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryYellow,
          ),
        ],
      ),
    );
  }

  Widget _buildPushNotificationsSection() {
    return Column(
      children: [
        _buildSwitchMenuItem(
          Icons.notifications_outlined,
          'Push Notifications',
          'Real-time alerts for bookings & queues',
          _pushNotifications,
          (value) {
            setState(() {
              _pushNotifications = value;
            });
          },
        ),
        if (_pushNotifications)
          Container(
            margin: const EdgeInsets.only(left: 36, right: 20, bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppTheme.borderGray,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOTIFY ME ABOUT',
                  style: AppTheme.monospaceXSmall(context).copyWith(
                    fontSize: 9,
                    letterSpacing: 0.5,
                    color: AppTheme.textTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                _buildSubNotifToggle(
                  'Event Reminders',
                  'Before your booked events',
                  _notifEventReminders,
                  (v) => setState(() => _notifEventReminders = v),
                ),
                _buildSubNotifToggle(
                  'Queue Updates',
                  'Position changes & entry alerts',
                  _notifQueueUpdates,
                  (v) => setState(() => _notifQueueUpdates = v),
                ),
                _buildSubNotifToggle(
                  'Offers & Deals',
                  'Exclusive early-bird pricing',
                  _notifOffers,
                  (v) => setState(() => _notifOffers = v),
                ),
                _buildSubNotifToggle(
                  'Nearby Events',
                  'Events happening around you',
                  _notifNearbyEvents,
                  (v) => setState(() => _notifNearbyEvents = v),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSubNotifToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTheme.monospaceXSmall(context).copyWith(
                    color: AppTheme.textTertiary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryYellow,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text('Log Out?', style: Theme.of(context).textTheme.titleLarge),
        content: Text(
          'You\'ll need to verify your identity again to book tickets.',
          style: Theme.of(context).textTheme.bodyMedium!
              .copyWith(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/onboarding',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('LOG OUT'),
          ),
        ],
      ),
    );
  }
}
