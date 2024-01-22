class ApiConst {
  static const apiKey = '2d01e9e3d28d4189b48461be856e9655';
  static String newsApi([String? domain]) =>
      'https://newsapi.org/v2/top-headlines?country=${domain ?? 'us'}&apiKey=$apiKey';
}
