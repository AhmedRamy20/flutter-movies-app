class MoviesModel {
  final List<Movie> results;
  // kept to help in pagination
  final int page;
  final int totalPages;
  MoviesModel({
    required this.page,
    required this.results,
    required this.totalPages,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json['page'],
      results: (json['results'] as List).map((e) => Movie.fromJson(e)).toList(),
      totalPages: json['total_pages'] ?? 1,
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final DateTime? releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate:
          (json["release_date"] == null ||
              json["release_date"].toString().isEmpty)
          ? null
          : DateTime.tryParse(json["release_date"]),
    );
  }
}
