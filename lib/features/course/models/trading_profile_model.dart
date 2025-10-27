import 'package:equatable/equatable.dart';

class TradingProfile extends Equatable {
  final String tradingExperience;
  final String assetsOfInterest;
  final String mainGoal;
  final String riskAppetite;
  final List<String> preferredLearning;
  const TradingProfile({
    required this.tradingExperience,
    required this.assetsOfInterest,
    required this.mainGoal,
    required this.riskAppetite,
    required this.preferredLearning,
  });
  factory TradingProfile.fromJson(Map<String, dynamic> json) => TradingProfile(
    tradingExperience:
        json['trading_exprience'] ?? json['trading_experience'] ?? '',
    assetsOfInterest: json['assets_of_interest'] ?? '',
    mainGoal: json['main_goal'] ?? '',
    riskAppetite: json['risk_appetite'] ?? '',
    preferredLearning: (json['preffered_learning'] as List? ?? [])
        .map((e) => e.toString())
        .toList(),
  );
  @override
  List<Object?> get props => [tradingExperience, assetsOfInterest, mainGoal];
}
