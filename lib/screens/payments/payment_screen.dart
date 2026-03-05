// // lib/screens/payment_screen.dart
// import 'package:flutter/material.dart';
// import 'package:_kvartant/core/app_theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'get_api.dart';

// class PaymentScreen extends StatefulWidget {
//   final double amount;
//   final String orderId;

//   const PaymentScreen({
//     super.key,
//     required this.amount,
//     required this.orderId,
//   });

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final PaymentsGateService _paymentService = PaymentsGateService();
//   bool _isLoading = false;
//   String? _selectedBank;

//   final List<Map<String, dynamic>> _banks = [
//     {'id': 'mbank', 'name': 'MBank', 'icon': Icons.account_balance},
//     {'id': 'bakai', 'name': 'Бакай Банк', 'icon': Icons.account_balance},
//     {'id': 'kicb', 'name': 'KICB', 'icon': Icons.account_balance},
//     {'id': 'demir', 'name': 'Демир Банк', 'icon': Icons.account_balance},
//     {'id': 'odengi', 'name': 'O!Dengi', 'icon': Icons.account_balance_wallet},
//   ];

//   Future<void> _processPayment() async {
//     setState(() => _isLoading = true);

//     try {
//       final preferredBanks = _selectedBank != null ? [_selectedBank!] : null;

//       final widgetUrl = await _paymentService.createElqrPayment(
//         amount: widget.amount,
//         invoiceId: widget.orderId,
//         clientId: 'user_123', // ID пользователя
//         preferredBanks: preferredBanks,
//       );

//       if (widgetUrl != null) {
//         await _paymentService.openPaymentWidget(widgetUrl);
//         // Обработка результата через deep link (см. ниже)
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Ошибка: $e')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         title: Text('Оплата'),
//         backgroundColor: AppColors.white,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Сумма к оплате:',
//                       style: AppTextStyles.body,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       '${widget.amount} сом',
//                       style: AppTextStyles.headline.copyWith(
//                         color: AppColors.primary,
//                         fontSize: 15.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 15),

//             Text(
//               'Выберите банк:',
//               style: AppTextStyles.subtitle,
//             ),

//             SizedBox(height: 12),
//             // Список банков
//             ..._banks.map((bank) => RadioListTile<String>(
//                   title: Row(
//                     children: [
//                       Icon(bank['icon'], color: AppColors.primary),
//                       SizedBox(width: 12),
//                       Text(bank['name']),
//                     ],
//                   ),
//                   value: bank['id'],
//                   groupValue: _selectedBank,
//                   onChanged: (value) {
//                     setState(() => _selectedBank = value);
//                   },
//                 )),

//             Spacer(),

//             // Кнопка оплаты
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _isLoading ? null : _processPayment,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: AppColors.primary,
//                 ),
//                 child: _isLoading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text(
//                         'Оплатить',
//                         style: AppTextStyles.button.copyWith(
//                           color: Colors.white,
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
