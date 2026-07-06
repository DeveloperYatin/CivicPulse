class AppConstants {
  static const String appName = 'CivicPulse';
  
  // API Endpoints
  static const String apiBaseUrl = 'https://api.civicpulse.gov.in/v1'; // Dummy base URL
  static const String bhashiniTranslateUrl = '/translate';
  static const String whisperSttUrl = '/transcribe';
  static const String satelliteVerifyUrl = '/verify/satellite';
  static const String complaintsUrl = '/complaints';
  
  // Storage keys
  static const String keyUserRole = 'user_role';
  static const String keyAuthToken = 'auth_token';
  static const String keyOfflineComplaints = 'offline_complaints';
}
