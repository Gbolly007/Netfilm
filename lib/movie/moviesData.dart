class Movies {
  final String movieImage;
  final String movieName;
  final String synopsis;
  final List movieCast;
  final double rating;
  final String movieGenre;
  final String movieDuration;

  Movies(
      {this.movieImage,
      this.movieName,
      this.synopsis,
      this.movieCast,
      this.rating,
      this.movieGenre,
      this.movieDuration});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      movieImage: json['movieImage'] as String,
      movieName: json['movieName'] as String,
      synopsis: json['synopsis'] as String,
      movieCast: json['movieCast'] as List,
      rating: json['rating'] as double,
      movieGenre: json['movieGenre'] as String,
      movieDuration: json['movieDuration'] as String,
    );
  }
}
