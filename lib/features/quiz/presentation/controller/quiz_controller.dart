import 'package:get/get.dart';
import '../../models/quiz_option_model.dart';
import '../../models/quiz_question_model.dart';

class QuizController extends GetxController {
  late Future<List<QuizQuestion>> questionsFuture;
  List<QuizQuestion> questions = [];
  List<int> answers = [];
  bool submitted = false;
  int get score => _calculateScore();

  @override
  void onInit() {
    super.onInit();
    questionsFuture = _fetchQuestions();
  }

  Future<List<QuizQuestion>> _fetchQuestions() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // 20 dummy questions as requested
    final dummyQuestions = [
      QuizQuestion(
        title: 'What is the primary purpose of technical analysis?',
        options: [
          QuizOption(text: 'Predicting future price movements'),
          QuizOption(text: 'Analyzing company fundamentals'),
          QuizOption(text: 'Calculating dividend yields'),
          QuizOption(text: 'Assessing management quality'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which of these is a trend reversal pattern?',
        options: [
          QuizOption(text: 'Head and Shoulders'),
          QuizOption(text: 'Flag pattern'),
          QuizOption(text: 'Triangle pattern'),
          QuizOption(text: 'Channel pattern'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What does RSI measure?',
        options: [
          QuizOption(text: 'Momentum and speed of price movements'),
          QuizOption(text: 'Volume of trades'),
          QuizOption(text: 'Market capitalization'),
          QuizOption(text: 'Interest rates'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which timeframe is best for swing trading?',
        options: [
          QuizOption(text: 'Daily charts'),
          QuizOption(text: 'Tick charts'),
          QuizOption(text: '1-minute charts'),
          QuizOption(text: 'Annual charts'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What is a "doji" candlestick?',
        options: [
          QuizOption(text: 'When open and close prices are nearly equal'),
          QuizOption(text: 'A very long bullish candle'),
          QuizOption(text: 'A gap down pattern'),
          QuizOption(text: 'A consolidation pattern'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which indicator uses moving averages?',
        options: [
          QuizOption(text: 'MACD'),
          QuizOption(text: 'RSI'),
          QuizOption(text: 'Stochastic'),
          QuizOption(text: 'Bollinger Bands'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What is support in technical analysis?',
        options: [
          QuizOption(text: 'Price level where buying interest emerges'),
          QuizOption(text: 'Resistance level'),
          QuizOption(text: 'Volume spike area'),
          QuizOption(text: 'Moving average crossover'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which pattern typically indicates continuation?',
        options: [
          QuizOption(text: 'Flag pattern'),
          QuizOption(text: 'Double top'),
          QuizOption(text: 'Head and Shoulders'),
          QuizOption(text: 'Triple bottom'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What does volume analysis help determine?',
        options: [
          QuizOption(text: 'Strength behind price movements'),
          QuizOption(text: 'Company earnings'),
          QuizOption(text: 'Interest rates'),
          QuizOption(text: 'Dividend payments'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which is a momentum oscillator?',
        options: [
          QuizOption(text: 'Stochastic'),
          QuizOption(text: 'Moving Average'),
          QuizOption(text: 'Fibonacci retracement'),
          QuizOption(text: 'Volume Profile'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What is the golden cross?',
        options: [
          QuizOption(text: '50-day MA crossing above 200-day MA'),
          QuizOption(text: 'RSI above 70'),
          QuizOption(text: 'Price above VWAP'),
          QuizOption(text: 'Volume spike'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which timeframe is best for scalp trading?',
        options: [
          QuizOption(text: '1-5 minute charts'),
          QuizOption(text: 'Daily charts'),
          QuizOption(text: 'Weekly charts'),
          QuizOption(text: 'Monthly charts'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What does Bollinger Bands measure?',
        options: [
          QuizOption(text: 'Volatility and relative price levels'),
          QuizOption(text: 'Volume'),
          QuizOption(text: 'Trend direction'),
          QuizOption(text: 'Momentum'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which pattern has three peaks?',
        options: [
          QuizOption(text: 'Triple top'),
          QuizOption(text: 'Double top'),
          QuizOption(text: 'Head and Shoulders'),
          QuizOption(text: 'Cup and Handle'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What is a breakout?',
        options: [
          QuizOption(text: 'Price moving outside defined support/resistance'),
          QuizOption(text: 'Volume decreasing'),
          QuizOption(text: 'RSI crossing 50'),
          QuizOption(text: 'Moving average crossover'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which indicator shows overbought/oversold conditions?',
        options: [
          QuizOption(text: 'RSI'),
          QuizOption(text: 'MACD'),
          QuizOption(text: 'Moving Average'),
          QuizOption(text: 'Fibonacci'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What is a bearish engulfing pattern?',
        options: [
          QuizOption(text: 'Large red candle following small green candle'),
          QuizOption(text: 'Two green candles'),
          QuizOption(text: 'Doji candle'),
          QuizOption(text: 'Hammer candle'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which tool is used for retracement levels?',
        options: [
          QuizOption(text: 'Fibonacci'),
          QuizOption(text: 'MACD'),
          QuizOption(text: 'RSI'),
          QuizOption(text: 'Bollinger Bands'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'What is volume divergence?',
        options: [
          QuizOption(text: 'Price and volume moving in opposite directions'),
          QuizOption(text: 'High volume breakout'),
          QuizOption(text: 'Low volume consolidation'),
          QuizOption(text: 'Volume spike'),
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        title: 'Which pattern is bullish?',
        options: [
          QuizOption(text: 'Inverse Head and Shoulders'),
          QuizOption(text: 'Head and Shoulders'),
          QuizOption(text: 'Double top'),
          QuizOption(text: 'Triple top'),
        ],
        correctAnswerIndex: 0,
      ),
    ];

    questions = dummyQuestions;
    answers = List.filled(dummyQuestions.length, -1);
    return dummyQuestions;
  }

  void select(int questionIndex, int optionIndex) {
    if (!submitted) {
      answers[questionIndex] = optionIndex;
      update();
    }
  }

  void submit() {
    submitted = true;
    update();
  }

  int _calculateScore() {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }
}
