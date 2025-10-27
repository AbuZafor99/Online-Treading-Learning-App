import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String cardType;
  final String cardNumber;

  const PaymentCard({
    super.key,
    required this.cardType,
    required this.cardNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 24,
            decoration: BoxDecoration(
              color: cardType == 'Visa' ? Colors.blue : Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                cardType == 'Visa' ? 'V' : 'M',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            cardNumber,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
