import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PanchayatScreen extends StatefulWidget {
  const PanchayatScreen({super.key});

  @override
  State<PanchayatScreen> createState() => _PanchayatScreenState();
}

class _PanchayatScreenState extends State<PanchayatScreen> {
  bool _isSyncing = false;
  List<Map<String, dynamic>> offlineQueue = [
    {
      'subject': 'Panchayat Bhavan Solar Panel Not Charging',
      'localLanguage': 'मराठी',
      'created': '2 hours ago',
      'hasGeoTag': true,
      'hasVoiceNotes': true
    },
    {
      'subject': 'Borewell hand pump dry in Sector C',
      'localLanguage': 'हिन्दी',
      'created': 'Yesterday',
      'hasGeoTag': true,
      'hasVoiceNotes': true
    }
  ];

  void _triggerSync() async {
    setState(() {
      _isSyncing = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isSyncing = false;
      offlineQueue.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully synced local offline tickets to District Database!'),
        backgroundColor: AppTheme.accentEmerald,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gram Panchayat Offline Sync'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync_problem),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connectivity Status Banner
            Card(
              color: Colors.orange.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.orange, width: 1.5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.wifi_off, color: Colors.orange, size: 28),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Offline Mode Active', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                          SizedBox(height: 4),
                          Text('No internet connection. Complaints are stored locally and will be synced upon network detection or manual trigger.', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Local Queue (${offlineQueue.length})',
                  style: theme.textTheme.titleLarge,
                ),
                if (offlineQueue.isNotEmpty)
                  ElevatedButton.icon(
                    onPressed: _isSyncing ? null : _triggerSync,
                    icon: _isSyncing
                        ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.cloud_upload_outlined),
                    label: Text(_isSyncing ? 'Syncing...' : 'Sync Now'),
                  )
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: offlineQueue.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_done_outlined, size: 64, color: Colors.grey.withOpacity(0.5)),
                          const SizedBox(height: 12),
                          const Text('All offline logs are synced!', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: offlineQueue.length,
                      itemBuilder: (context, index) {
                        final item = offlineQueue[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: theme.primaryColor.withOpacity(0.1),
                              child: const Icon(Icons.mic, color: AppTheme.accentIndigo),
                            ),
                            title: Text(item['subject'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Row(
                              children: [
                                Text('Created: ${item['created']}', style: const TextStyle(fontSize: 11)),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item['localLanguage'],
                                    style: const TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.vpn_key_sharp, size: 16, color: Colors.grey), // Aadhaar secure hash active indicator
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
