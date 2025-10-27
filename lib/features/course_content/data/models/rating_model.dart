class Rating {
  final int star;
  final String comment;

  Rating({required this.star, required this.comment});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(star: json["star"], comment: json["comment"]);

  Map<String, dynamic> toJson() => {"star": star, "comment": comment};
}
