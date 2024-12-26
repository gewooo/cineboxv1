class MovieDetails {
  int? id;
  late String title;
  late String genre;
  late String status;
  late String? description;
  late String? imageUrl;

  MovieDetails(
      {this.id,
      required this.title,
      required this.genre,
      required this.status,
      this.imageUrl,
      this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'movieTitle': title,
      'movieGenre': genre,
      'movieStatus': status,
      'movieDescription': description,
      'movieImageUrl': imageUrl,
    };
  }

  factory MovieDetails.fromMap(Map<String, dynamic> map) {
    return MovieDetails(
        id: map['id'],
        title: map['movieTitle'],
        genre: map['movieGenre'],
        status: map['movieStatus'],
        description: map['movieDescription'],
        imageUrl: map['movieImageUrl']);
  }
}
