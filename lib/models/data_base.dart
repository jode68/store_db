import 'package:isar/isar.dart';

part 'data_base.g.dart';

@Collection()
class DataBase {
  Id id = Isar.autoIncrement;
  String? article;
  String? type;
  String? description;
  int? quantity;
  String? foto;
  String? image;
}
