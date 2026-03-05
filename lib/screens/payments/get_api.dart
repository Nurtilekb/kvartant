// // lib/services/payment_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PaymentsGateService {
//   final String _apiKey = 'YOUR_API_KEY'; // Получить у PaymentsGate
//   final String _baseUrl = 'https://api.paymentsgate.com/v1';

//   Future<String?> createElqrPayment({
//     required double amount,
//     required String invoiceId,
//     required String clientId,
//     List<String>? preferredBanks, // Например ['mbank', 'bakai']
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/payments'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $_apiKey',
//         },
//         body: jsonEncode({
//           'amount': amount,
//           'currency': 'KGS',
//           'invoiceId': invoiceId,
//           'clientId': clientId,
//           'lang': 'RU',
//           'successUrl': 'yourapp://payment/success',
//           'failUrl': 'yourapp://payment/fail',
//           'backUrl': 'yourapp://payment/back',
//           'multiWidgetOptions': {
//             'elqrBanks': preferredBanks ?? ['mbank', 'bakai', 'kicb'],
//           },
//           'type': 'elqr',
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['url']; // URL платежного виджета
//       }
//     } catch (e) {
//       print('Payment error: $e');
//     }
//     return null;
//   }

//   Future<void> openPaymentWidget(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
// }
