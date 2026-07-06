import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CitizenScreen extends StatefulWidget {
  const CitizenScreen({super.key});

  @override
  State<CitizenScreen> createState() => _CitizenScreenState();
}

class _CitizenScreenState extends State<CitizenScreen> {
  bool _isRecording = false;
  String _voiceText = '';
  bool _isProcessing = false;
  String? _detectedCategory;
  String? _detectedUrgency;
  
  void _toggleRecording() async {
    if (_isRecording) {
      // Stop recording, simulate transcription & NLP classification
      setState(() {
        _isRecording = false;
        _isProcessing = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isProcessing = false;
        _voiceText = "यहाँ वार्ड 12 में मुख्य पानी की पाइपलाइन फट गई है और सड़क पर बहुत पानी बह रहा है। कृपया इसे जल्द ठीक करवाएं।";
        _detectedCategory = "Water Supply & Infrastructure";
        _detectedUrgency = "High";
      });
    } else {
      // Start recording
      setState(() {
        _isRecording = true;
        _voiceText = '';
        _detectedCategory = null;
        _detectedUrgency = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Voice Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Report an Issue',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Hold the button below and speak in your local language to lodge a ticket. Our Bhashini AI will translate and route it instantly.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 30),

            // Voice Recording Area
            Center(
              child: Card(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                  child: Column(
                    children: [
                      // Pulsing Mic Button
                      GestureDetector(
                        onTap: _toggleRecording,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.all(_isRecording ? 30 : 24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isRecording ? Colors.red.withOpacity(0.2) : theme.primaryColor.withOpacity(0.1),
                            border: Border.all(
                              color: _isRecording ? Colors.red : theme.primaryColor,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            _isRecording ? Icons.mic : Icons.mic_none,
                            size: 48,
                            color: _isRecording ? Colors.red : theme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _isRecording ? 'Listening (Tap to stop)...' : 'Tap Mic to Start Speaking',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: _isRecording ? Colors.red : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Supports Hindi, Marathi, Telugu, Tamil, & 18 other languages',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // AI Status & Output
            if (_isProcessing)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 12),
                      Text('AI Engine: Transcribing, Translating, & Validating with ISRO Sentinel GIS...'),
                    ],
                  ),
                ),
              ),

            if (_voiceText.isNotEmpty) ...[
              Text(
                'AI Transcript & Translation Output',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.translate, size: 16, color: AppTheme.accentIndigo),
                          SizedBox(width: 8),
                          Text(
                            'Parsed Statement (English)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '"A main water pipeline has burst here in Ward 12, causing water logging on the streets. Please resolve this immediately."',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const Divider(height: 24),
                      Row(
                        children: [
                          if (_detectedCategory != null) ...[
                            Chip(
                              label: Text(_detectedCategory!),
                              backgroundColor: AppTheme.accentIndigo.withOpacity(0.1),
                              labelStyle: const TextStyle(color: AppTheme.accentIndigo, fontSize: 12),
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (_detectedUrgency != null)
                            Chip(
                              label: Text('Urgency: $_detectedUrgency'),
                              backgroundColor: AppTheme.accentAmber.withOpacity(0.1),
                              labelStyle: const TextStyle(color: AppTheme.accentAmber, fontSize: 12),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Icon(Icons.verified_user_outlined, color: AppTheme.accentEmerald, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'ISRO GIS Verified Location: Ward 12 - Janpath Main Rd',
                            style: TextStyle(color: AppTheme.accentEmerald, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ticket created successfully! Sent to Ward 12 Representative.'),
                        backgroundColor: AppTheme.accentEmerald,
                      ),
                    );
                    setState(() {
                      _voiceText = '';
                    });
                  },
                  child: const Text('Confirm & File Complaint'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
