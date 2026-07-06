import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class MlaScreen extends StatelessWidget {
  const MlaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<Map<String, dynamic>> tickets = [
      {
        'id': 'TKT-1082',
        'ward': 'Ward 5 - Govindpuri',
        'issue': 'Garbage pile blockaging drainage',
        'status': 'In Progress',
        'urgency': 'High',
        'reportedTime': '2 hours ago',
      },
      {
        'id': 'TKT-1081',
        'ward': 'Ward 12 - Janpath Rd',
        'issue': 'Burst water pipeline causing road flood',
        'status': 'Open',
        'urgency': 'Critical',
        'reportedTime': '5 mins ago',
      },
      {
        'id': 'TKT-1079',
        'ward': 'Ward 8 - Rampur East',
        'issue': 'Street lights blinking / damaged',
        'status': 'Resolved',
        'urgency': 'Low',
        'reportedTime': 'Yesterday',
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MLA Constituency Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header stats
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Open Tickets', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 8),
                          Text('14', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.accentAmber)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Resolved (Month)', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 8),
                          Text('128', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.accentEmerald)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Ward Tickets Queue',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  final urgencyColor = ticket['urgency'] == 'Critical'
                      ? Colors.red
                      : (ticket['urgency'] == 'High' ? AppTheme.accentAmber : Colors.blue);
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ticket['id'],
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentIndigo),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: urgencyColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  ticket['urgency'],
                                  style: TextStyle(color: urgencyColor, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(ticket['issue'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(ticket['ward'], style: theme.textTheme.bodyMedium),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reported ${ticket['reportedTime']}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: ticket['status'] == 'Resolved'
                                        ? AppTheme.accentEmerald
                                        : (ticket['status'] == 'In Progress' ? Colors.blue : AppTheme.accentAmber),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    ticket['status'],
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
