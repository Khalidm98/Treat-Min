import 'dart:convert';

Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));

String reviewsToJson(Reviews data) => json.encode(data.toJson());

class Reviews {
  Reviews({
    this.reviews,
  });

  List<Review> reviews;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Review {
  Review({
    this.name,
    this.date,
    this.rating,
    this.review,
  });

  String name;
  String date;
  String rating;
  String review;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        date: json["date"],
        rating: json["rating"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "rating": rating,
        "review": review,
      };
}
