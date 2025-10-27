import 'package:flutter/material.dart';
import '../../models/quiz_question_model.dart';
import 'custom_radio.dart';

class QuestionCard extends StatelessWidget {
  final int index;
  final QuizQuestion question;
  final int? selected;
  final ValueChanged<int> onSelect;
  final bool isSubmitted;

  const QuestionCard({
    super.key,
    required this.index,
    required this.question,
    required this.selected,
    required this.onSelect,
    required this.isSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. ${question.title}',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ...question.options.asMap().entries.map((e) {
            final i = e.key;
            final t = e.value.text;
            final isCorrect = i == question.correctAnswerIndex;
            final isSelected = selected == i;

            Color? radioColor;
            Color? textColor;

            if (isSubmitted) {
              if (isCorrect) {
                radioColor = Colors.green;
                textColor = Colors.green;
              } else if (isSelected) {
                radioColor = Colors.red;
                textColor = Colors.red;
              }
            } else if (isSelected) {
              radioColor = Colors.grey;
            }

            return InkWell(
              onTap: () => onSelect(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    CustomRadio(checked: isSelected, color: radioColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(t, style: TextStyle(color: textColor)),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
