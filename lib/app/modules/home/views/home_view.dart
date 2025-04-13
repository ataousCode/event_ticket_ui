// lib/app/modules/home/views/home_view.dart
// ignore_for_file: deprecated_member_use

import 'package:event_ticket_ui/app/modules/home/views/tabs/dashboard_tab.dart';
import 'package:event_ticket_ui/app/modules/home/views/tabs/events_tab.dart';
import 'package:event_ticket_ui/app/modules/home/views/tabs/profile_tab.dart';
import 'package:event_ticket_ui/app/modules/home/views/tabs/tickets_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [DashboardTab(), EventsTab(), TicketsTab(), ProfileTab()],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.onNavItemTapped,
          backgroundColor: const Color(0xFF252850),
          indicatorColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.2),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.event_outlined),
              selectedIcon: Icon(Icons.event),
              label: 'Events',
            ),
            NavigationDestination(
              icon: Icon(Icons.confirmation_number_outlined),
              selectedIcon: Icon(Icons.confirmation_number),
              label: 'Tickets',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
