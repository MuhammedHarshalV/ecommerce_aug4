import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  String? slug;
  String? name;
  String? url;

  Category({this.slug, this.name, this.url});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(slug: json["slug"], name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"slug": slug, "name": name, "url": url};
}
