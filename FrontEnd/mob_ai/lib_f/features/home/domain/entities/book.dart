// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  final int id;
  final String title;
  final String url;
  final String description;
  final double price;
  final String publisher;
  final String publicationDate;

  Book( {
    required this.publisher,required this.publicationDate,
    required this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
      'description': description,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id']  ?? 0,
      title: map['title']?? 'Untitled',
      url: map['url']  ?? 'no url',
      description: map['description'] ?? 'no description',
      price: map['price']  ?? 0, publisher: map['publisher'] ?? '', publicationDate: map['published_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

     
  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
