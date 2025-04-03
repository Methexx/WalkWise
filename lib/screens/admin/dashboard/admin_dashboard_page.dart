import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkwise/providers/admin_provider.dart';
import 'package:walkwise/screens/admin/components/admin_places_view.dart';
import 'package:walkwise/screens/admin/components/admin_users_list.dart';
import '../components/admin_stats_grid.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await context.read<AdminProvider>().loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Users'),
              Tab(text: 'Places'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard Overview',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    const AdminStatsGrid(),
                  ],
                ),
              ),
            ),
            const AdminUsersList(),
            const AdminPlacesView(),
          ],
        ),
      ),
    );
  }
}
