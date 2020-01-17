class Series {
  final String seriesImage;
  final String seriesName;
  final String synopsis;
  final List seriesCast;
  final double rating;
  final String seriesGenre;
  final int seriesSeason;
  final String seriesFirstEpsiode;
  final String seriesFinalEpisode;

  Series(
      {this.seriesImage,
      this.seriesName,
      this.synopsis,
      this.seriesCast,
      this.rating,
      this.seriesGenre,
      this.seriesSeason,
      this.seriesFirstEpsiode,
      this.seriesFinalEpisode});

  List<Series> series = [];

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      seriesImage: json['seriesImage'] as String,
      seriesName: json['seriesName'] as String,
      synopsis: json['synopsis'] as String,
      seriesCast: json['seriesCast'] as List,
      rating: json['rating'] as double,
      seriesGenre: json['seriesGenre'] as String,
      seriesSeason: json['seriesSeason'] as int,
      seriesFirstEpsiode: json['seriesFirstEpsiode'] as String,
      seriesFinalEpisode: json['seriesFinalEpisode'] as String,
    );
  }
}
