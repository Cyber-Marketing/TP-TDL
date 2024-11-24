import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
  });

  final int rating;

  @override
  Widget build(BuildContext context) {
    List<Icon> stars = [];

    for (var i = 1; i <= 5; i++) {
      var starIcon =
          i <= rating ? Icons.star_outlined : Icons.star_outline_outlined;
      stars.add(Icon(starIcon));
    }

    return Row(
      children: stars,
    );
  }
}
