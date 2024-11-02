class MetaModel {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String previousPageUrl;

  MetaModel({
    required this.currentPage,
    required this.firstPage,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.previousPageUrl,
    required this.perPage,
    required this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
        currentPage: json["currentPage"],
        firstPage: json["firstPage"],
        lastPage: json["lastPage"],
        lastPageUrl: json["lastPageUrl"],
        nextPageUrl: json["nextPageUrl"],
        previousPageUrl: json["previousPageUrl"],
        perPage: json["perPage"],
        total: json["total"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "total": total,
      "currentPage": currentPage,
      "firstPage": firstPage,
      "lastPage": lastPage,
      "nextPageUrl": nextPageUrl,
      "lastPageUrl": lastPageUrl,
      "perPage": perPage,
      "previousPageUrl": previousPageUrl,
    };
  }
}

/**
 * 
 * "meta": {
		"total": 5000,
		"perPage": 5,
		"currentPage": 1,
		"lastPage": 1000,
		"firstPage": 1,
		"firstPageUrl": "/?page=1",
		"lastPageUrl": "/?page=1000",
		"nextPageUrl": "/?page=2",
		"previousPageUrl": null
	},
 */