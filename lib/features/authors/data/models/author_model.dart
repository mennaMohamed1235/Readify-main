import 'package:flutter/foundation.dart';
import 'package:fruit_e_commerce/features/authors/domain/entities/author_entity.dart';

class AuthorModel extends AuthorEntity {
  AuthorModel({required super.authorName, required super.authorImageUrl, required super.id});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(authorName: json['firstName'], authorImageUrl: json['imageUrl']??"https://cdn.vectorstock.com/i/500p/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg", id: json[r"$id"]);
  }
  }
