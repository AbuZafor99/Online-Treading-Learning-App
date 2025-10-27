class TradingProfile {
  final String tradingExperience;
  final String assetsOfInterest;
  final String mainGoal;
  final String riskAppetite;
  final List<String> preferredLearning;

  TradingProfile({
    required this.tradingExperience,
    required this.assetsOfInterest,
    required this.mainGoal,
    required this.riskAppetite,
    required this.preferredLearning,
  });

  factory TradingProfile.fromJson(Map<String, dynamic> json) {
    return TradingProfile(
      tradingExperience: json["treding_exprience"] ?? "",
      assetsOfInterest: json["assets_of_interest"] ?? "",
      mainGoal: json["main_goal"] ?? "",
      riskAppetite: json["risk_appetite"] ?? "",
      preferredLearning: List<String>.from(json["preffered_learning"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "trading_exprience": tradingExperience,
      "assets_of_interest": assetsOfInterest,
      "main_goal": mainGoal,
      "risk_appetite": riskAppetite,
      "preffered_learning": preferredLearning,
    };
  }
}
