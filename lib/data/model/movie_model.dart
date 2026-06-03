// import 'dart:convert';

// MoviesModel moviesModelFromJson(String str) =>
//     MoviesModel.fromJson(json.decode(str));

// String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

// class MoviesModel {
//   int page;
//   List<Result> results;
//   int totalPages;
//   int totalResults;

//   MoviesModel({
//     required this.page,
//     required this.results,
//     required this.totalPages,
//     required this.totalResults,
//   });

//   factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
//     page: json["page"],
//     results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//     totalPages: json["total_pages"],
//     totalResults: json["total_results"],
//   );

//   Map<String, dynamic> toJson() => {
//     "page": page,
//     "results": List<dynamic>.from(results.map((x) => x.toJson())),
//     "total_pages": totalPages,
//     "total_results": totalResults,
//   };
// }

// class Result {
//   bool adult;
//   String backdropPath;
//   int id;
//   String? name;
//   String? originalName;
//   String overview;
//   String posterPath;
//   MediaType mediaType;
//   OriginalLanguage originalLanguage;
//   List<int> genreIds;
//   double popularity;
//   DateTime? firstAirDate;
//   bool softcore;
//   double voteAverage;
//   int voteCount;
//   List<String>? originCountry;
//   String? title;
//   String? originalTitle;
//   DateTime? releaseDate;
//   bool? video;

//   Result({
//     required this.adult,
//     required this.backdropPath,
//     required this.id,
//     this.name,
//     this.originalName,
//     required this.overview,
//     required this.posterPath,
//     required this.mediaType,
//     required this.originalLanguage,
//     required this.genreIds,
//     required this.popularity,
//     this.firstAirDate,
//     required this.softcore,
//     required this.voteAverage,
//     required this.voteCount,
//     this.originCountry,
//     this.title,
//     this.originalTitle,
//     this.releaseDate,
//     this.video,
//   });

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     adult: json["adult"],
//     backdropPath: json["backdrop_path"],
//     id: json["id"],
//     name: json["name"],
//     originalName: json["original_name"],
//     overview: json["overview"],
//     posterPath: json["poster_path"],
//     mediaType: mediaTypeValues.map[json["media_type"]]!,
//     originalLanguage: originalLanguageValues.map[json["original_language"]]!,
//     genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//     popularity: json["popularity"]?.toDouble(),
//     firstAirDate: json["first_air_date"] == null
//         ? null
//         : DateTime.parse(json["first_air_date"]),
//     softcore: json["softcore"],
//     voteAverage: json["vote_average"]?.toDouble(),
//     voteCount: json["vote_count"],
//     originCountry: json["origin_country"] == null
//         ? []
//         : List<String>.from(json["origin_country"]!.map((x) => x)),
//     title: json["title"],
//     originalTitle: json["original_title"],
//     releaseDate: json["release_date"] == null
//         ? null
//         : DateTime.parse(json["release_date"]),
//     video: json["video"],
//   );

//   Map<String, dynamic> toJson() => {
//     "adult": adult,
//     "backdrop_path": backdropPath,
//     "id": id,
//     "name": name,
//     "original_name": originalName,
//     "overview": overview,
//     "poster_path": posterPath,
//     "media_type": mediaTypeValues.reverse[mediaType],
//     "original_language": originalLanguageValues.reverse[originalLanguage],
//     "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
//     "popularity": popularity,
//     "first_air_date":
//         "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
//     "softcore": softcore,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//     "origin_country": originCountry == null
//         ? []
//         : List<dynamic>.from(originCountry!.map((x) => x)),
//     "title": title,
//     "original_title": originalTitle,
//     "release_date":
//         "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
//     "video": video,
//   };
// }

// enum MediaType { MOVIE, TV }

// final mediaTypeValues = EnumValues({
//   "movie": MediaType.MOVIE,
//   "tv": MediaType.TV,
// });

// enum OriginalLanguage { EN }

// final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

class MoviesModel {
  final int page;
  final List<Movie> results;

  MoviesModel({required this.page, required this.results});

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      page: json['page'],
      results: (json['results'] as List).map((e) => Movie.fromJson(e)).toList(),
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final DateTime? releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
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
