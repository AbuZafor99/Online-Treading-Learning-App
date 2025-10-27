class TredingProfile {
  final String tradingExperience;
  final String assetsOfInterest;
  final String mainGoal;
  final String riskAppetite;
  final List<String> prefferedLearning;

  TredingProfile({
    required this.tradingExperience,
    required this.assetsOfInterest,
    required this.mainGoal,
    required this.riskAppetite,
    required this.prefferedLearning,
  });

  factory TredingProfile.fromJson(Map<String, dynamic> json) => TredingProfile(
    tradingExperience: json["trading_exprience"],
    assetsOfInterest: json["assets_of_interest"],
    mainGoal: json["main_goal"],
    riskAppetite: json["risk_appetite"],
    prefferedLearning: List<String>.from(
      json["preffered_learning"].map((x) => x),
    ),
  );

  Map<String, dynamic> toJson() => {
    "trading_exprience": tradingExperience,
    "assets_of_interest": assetsOfInterest,
    "main_goal": mainGoal,
    "risk_appetite": riskAppetite,
    "preffered_learning": List<dynamic>.from(prefferedLearning.map((x) => x)),
  };
}
