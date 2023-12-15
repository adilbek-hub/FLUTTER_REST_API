class TopNews {
  const TopNews(
      {required this.status,
      required this.totalResults,
      required this.id,
      required this.name,
      required this.author,
      required this.title,
      required this.url,
      required this.description,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});
  final String status;
  final int totalResults;
  final String id;
  final String name;
  final String? author;
  final String title;
  final String url;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;
}
