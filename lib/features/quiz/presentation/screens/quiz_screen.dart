import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';
import '../../models/quiz_question_model.dart';
import '../controller/quiz_controller.dart';
import '../widgets/questions_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(QuizController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff1A3E74),
          ),
        ),
      ),
      body: FutureBuilder<List<QuizQuestion>>(
        future: controller.questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GetBuilder<QuizController>(
              builder: (controller) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, qIndex) {
                          final q = controller.questions[qIndex];
                          return QuestionCard(
                            index: qIndex + 1,
                            question: q,
                            selected: controller.answers[qIndex] == -1
                                ? null
                                : controller.answers[qIndex],
                            onSelect: (opt) => controller.select(qIndex, opt),
                            isSubmitted: controller.submitted,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemCount: controller.questions.length,
                      ),
                    ),
                    Container(
                      height: 79,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: controller.submitted
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Result: ${controller.score} / ${controller.questions.length}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                              child: context.primaryButton(
                                onPressed: controller.submit,
                                text: 'Submit',
                              ),
                            ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
