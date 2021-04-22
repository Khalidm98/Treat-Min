class Reviews {
  final String id;
  final String username;
  final String reviewText;
  final int rating;
  int likes;
  int dislikes;

  Reviews(this.id, this.username, this.reviewText, this.rating, this.likes,
      this.dislikes);
}
