class MovieListModel {
  MovieListModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String backdropPath;
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? '',
        backdropPath: json["backdrop_path"] ?? '',

        id: json["id"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? '',
        posterPath: json["poster_path"] ?? '',
        releaseDate: DateTime.parse(json["release_date"] ?? ''),
        title: json["title"] ?? '',
        video: json["video"] ?? '',
        voteAverage: json["vote_average"]?.toDouble() ?? '',
        voteCount: json["vote_count"] ?? '',
      );
}
