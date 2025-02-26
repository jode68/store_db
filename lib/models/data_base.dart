import 'package:isar/isar.dart';

part 'data_base.g.dart';

@Collection()
class DataBase {
  Id id = Isar.autoIncrement;
  String article;
  String type;
  String description;
  int quantity;
  String foto;
  String image;

  DataBase({
    required this.article,
    required this.type,
    required this.description,
    required this.quantity,
    required this.foto,
    required this.image,
  });
}
