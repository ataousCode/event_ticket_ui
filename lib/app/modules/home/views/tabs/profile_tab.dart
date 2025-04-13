// lib/app/modules/home/views/tabs/profile_tab.dart
import 'package:event_ticket_ui/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTab extends GetView<HomeController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile header
            _buildProfileHeader(context),
            const SizedBox(height: 24),

            // Profile options
            _buildProfileOptions(context),
            const SizedBox(height: 24),

            // Logout button
            ElevatedButton.icon(
              onPressed: controller.logout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'Almousleck Atalib Ag',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'almouslecka@gmail.com',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              // Navigate to edit profile
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final options = [
      {
        'title': 'My Bookings',
        'icon': Icons.confirmation_number,
        'onTap': () {
          // Navigate to bookings
        },
      },
      {
        'title': 'Payment Methods',
        'icon': Icons.payment,
        'onTap': () {
          // Navigate to payment methods
        },
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications,
        'onTap': () {
          // Navigate to notifications settings
        },
      },
      {
        'title': 'VIP Subscription',
        'icon': Icons.star,
        'onTap': () {
          // Navigate to subscription settings
        },
      },
      {
        'title': 'Help & Support',
        'icon': Icons.help,
        'onTap': () {
          // Navigate to help
        },
      },
      {
        'title': 'About',
        'icon': Icons.info,
        'onTap': () {
          // Navigate to about
        },
      },
    ];

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final option = options[index];
          return ListTile(
            leading: Icon(option['icon'] as IconData, color: Colors.white70),
            title: Text(
              option['title'] as String,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.white70),
            onTap: option['onTap'] as Function(),
          );
        },
      ),
    );
  }
}
