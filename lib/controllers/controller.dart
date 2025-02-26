import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/models/data_base.dart';
import 'package:store_db/services/isar_service.dart';

class Controller extends GetxController {
  final isar = Get.find<IsarService>();

  final articleEdit = TextEditingController();
  final typeEdit = TextEditingController();
  final descriptionEdit = TextEditingController();
  final quantityEdit = TextEditingController();
  final fotoEdit = TextEditingController();
  final sheetEdit = TextEditingController();

  void addArticle() {
    final article = articleEdit.value.text.trim();
    final type = typeEdit.value.text.trim();
    final description = descriptionEdit.value.text.trim();
    final quantity = quantityEdit.value.text.trim();
    final foto = fotoEdit.value.text.trim();
    final sheet = sheetEdit.value.text.trim();

    if (article.isNotEmpty &&
        type.isNotEmpty &&
        description.isNotEmpty &&
        quantity.isNotEmpty &&
        foto.isNotEmpty &&
        sheet.isNotEmpty) {
      final dataBase = DataBase(
        article: article,
        type: type,
        description: description,
        quantity: int.parse(quantity),
        foto: foto,
        sheet: sheet,
      );

      isar.saveIsar(dataBase);

      articleEdit.clear();
      typeEdit.clear();
      descriptionEdit.clear();
      quantityEdit.clear();
      fotoEdit.clear();
      sheetEdit.clear();
    }
  }

  void updateArticle(DataBase data) {
    articleEdit.text = data.article;
    typeEdit.text = data.type;
    descriptionEdit.text = data.description;
    quantityEdit.text = data.quantity.toString();
    fotoEdit.text = data.foto;
    sheetEdit.text = data.sheet;

    isar.deleteIsar(data);

    addArticle();
  }

  void deleteArticle(DataBase data) {
    isar.deleteIsar(data);
  }

  void clearArticle() {
    isar.clearIsar();
  }

  void sortByArticle() {
    final data = isar.dataBase.map((value) => value).toList();
    data.sort((a, b) => a.article.compareTo(b.article));
    isar.dataBase.value = data;
    isar.dataBase.refresh();
  }

  void sortByType() {
    final data = isar.dataBase.map((value) => value).toList();
    data.sort((a, b) => a.type.compareTo(b.type));
    isar.dataBase.value = data;
    isar.dataBase.refresh();
  }

  void searchArticle(String name) {
    final data = isar.dataBase.map((value) => value).toList();
    isar.dataBase.value =
        data.where((element) => element.article.contains(name)).toList();
    isar.dataBase.refresh();
  }
}
