import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'home/home_screen.dart';
import 'analytics/analytics_screen.dart';
import 'pos/new_transaction_pos_screen.dart';
import 'reports/reports_consolidated_screen.dart';
import 'store/store_profile_screen.dart';
import 'widgets/app_end_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _openNewTransactionPos() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewTransactionPosScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        onStartNewTransaction: _openNewTransactionPos,
        onNavigateTab: _navigateToTab,
        onOpenEndDrawer: _openEndDrawer,
      ),
      AnalyticsScreen(
        onOpenEndDrawer: _openEndDrawer,
      ),
      const SizedBox.shrink(), // Index 2 placeholder (center button)
      ReportsConsolidatedScreen(
        onOpenEndDrawer: _openEndDrawer,
      ),
      StoreProfileScreen(
        onOpenEndDrawer: _openEndDrawer,
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppEndDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: _navigateToTab,
        onCenterActionTap: _openNewTransactionPos,
      ),
    );
  }
}
