import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class WebDashboardScreen extends StatelessWidget {
  const WebDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MP Office - District Analytics Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            backgroundColor: AppTheme.accentIndigo,
            child: Text('MP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('District Overview', style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    const Text('Constituency Planning Platform | MP Portal'),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.accentIndigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'District Code: DL-02',
                    style: TextStyle(color: AppTheme.accentIndigo, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),

            // Responsive Layout: Cards
            if (isWide)
              const Row(
                children: [
                  Expanded(child: StatCard(title: 'Total Lodged Issues', value: '1,492', icon: Icons.description_outlined, color: AppTheme.accentIndigo)),
                  SizedBox(width: 16),
                  Expanded(child: StatCard(title: 'Resolved Tickets', value: '1,284', icon: Icons.task_alt_outlined, color: AppTheme.accentEmerald)),
                  SizedBox(width: 16),
                  Expanded(child: StatCard(title: 'Pending Verification', value: '48', icon: Icons.map_outlined, color: AppTheme.accentAmber)),
                  SizedBox(width: 16),
                  Expanded(child: StatCard(title: 'WhatsApp Daily Digits', value: 'Active', icon: Icons.chat_bubble_outline, color: Colors.green)),
                ],
              )
            else
              Column(
                children: [
                  const Row(
                    children: [
                      Expanded(child: StatCard(title: 'Total Issues', value: '1,492', icon: Icons.description_outlined, color: AppTheme.accentIndigo)),
                      SizedBox(width: 12),
                      Expanded(child: StatCard(title: 'Resolved', value: '1,284', icon: Icons.task_alt_outlined, color: AppTheme.accentEmerald)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Expanded(child: StatCard(title: 'Pending', value: '48', icon: Icons.map_outlined, color: AppTheme.accentAmber)),
                      SizedBox(width: 12),
                      Expanded(child: StatCard(title: 'WhatsApp Digest', value: 'Active', icon: Icons.chat_bubble_outline, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 32),

            // District Map / Heatmap & Detailed ticket breakdowns
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Complaint Density (GIS Heatmap)', style: theme.textTheme.titleLarge),
                              const Icon(Icons.zoom_in, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Simulated Heatmap
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.withOpacity(0.2)),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.map, size: 80, color: Colors.grey.withOpacity(0.3)),
                                      const SizedBox(height: 10),
                                      const Text('[ISRO Sentinel-2 Spatial Layout Overlay Active]', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                // Simulated Hotspots
                                Positioned(
                                  top: 80,
                                  left: 140,
                                  child: CircleAvatar(radius: 40, backgroundColor: Colors.red.withOpacity(0.3)),
                                ),
                                Positioned(
                                  top: 180,
                                  right: 120,
                                  child: CircleAvatar(radius: 60, backgroundColor: Colors.orange.withOpacity(0.3)),
                                ),
                                Positioned(
                                  bottom: 40,
                                  left: 80,
                                  child: CircleAvatar(radius: 30, backgroundColor: Colors.green.withOpacity(0.3)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                if (isWide)
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Representative Actions', style: theme.textTheme.titleLarge),
                            const SizedBox(height: 16),
                            const ActionItem(title: 'Approved Road Repair', desc: 'MLA Ward 5 - ISRO Map verified', time: '10 mins ago', status: 'Completed'),
                            const ActionItem(title: 'Dispatched Water Tanker', desc: 'Ward 12 - Pipeline leakage reported', time: '1 hour ago', status: 'Active'),
                            const ActionItem(title: 'Flagged Spam Complaint', desc: 'Aadhaar limit hit for user ID 10924', time: '4 hours ago', status: 'Rejected'),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      color: isDark ? const Color(0xFF151F32) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 24,
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  final String status;

  const ActionItem({
    super.key,
    required this.title,
    required this.desc,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 8,
            backgroundColor: status == 'Completed'
                ? AppTheme.accentEmerald
                : (status == 'Active' ? AppTheme.accentAmber : Colors.red),
            child: const Icon(Icons.check, size: 10, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(time, style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
