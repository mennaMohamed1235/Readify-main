import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String categoryId;
  final String name;
  final String imageUrl;

  const CategoryEntity({required this.categoryId, required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [categoryId, name];
}
