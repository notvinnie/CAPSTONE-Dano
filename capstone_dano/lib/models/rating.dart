class Rating {
  const Rating(this.target, this.stars, this.comment, {this.id});

  final String target;
  final double stars;
  final String comment;
  final String? id;

  Map<String, dynamic> toMap() => {
        'target': target,
        'stars': stars,
        'comment': comment,
      };

  factory Rating.fromMap(String id, Map<String, dynamic> map) => Rating(
        map['target'] as String,
        (map['stars'] as num).toDouble(),
        (map['comment'] as String?) ?? '',
        id: id,
      );
}
