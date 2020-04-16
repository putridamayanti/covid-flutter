class News {
  final image;
  final title;
  final description;
  final source;
  final published;

  News({
    this.image,
    this.title,
    this.description,
    this.source,
    this.published
  });

  factory News.fromJson(Map json) {
    return new News(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        source: json['source'],
        published: json['published']
    );
  }
}