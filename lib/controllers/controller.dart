import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:store_db/models/data_base.dart';
import 'package:store_db/services/isar_service.dart';

class Controller extends GetxController {
  final isarController = Get.find<IsarService>();
  final isar = IsarService().isar;

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

      isarController.saveIsar(dataBase);

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

    isarController.deleteIsar(data);

    addArticle();
  }

  void deleteArticle(DataBase data) {
    isarController.deleteIsar(data);
  }

  void clearArticle() {
    isarController.clearIsar();
  }

  void sortByArticle() {
    final data = isarController.dataBase.map((value) => value).toList();
    data.sort((a, b) => a.article.compareTo(b.article));
    isarController.dataBase.value = data;
    isarController.dataBase.refresh();
  }

  void sortByType() {
    final data = isarController.dataBase.map((value) => value).toList();
    data.sort((a, b) => a.type.compareTo(b.type));
    isarController.dataBase.value = data;
    isarController.dataBase.refresh();
  }

  void searchArticle(String name) {
    final data = isarController.dataBase.map((value) => value).toList();
    isarController.dataBase.value =
        data.where((element) => element.article.contains(name)).toList();
    isarController.dataBase.refresh();
  }

  void searchName(String name) {
    isar.dataBases.filter().typeEqualTo(name).findAll().then((value) {
      isarController.dataBase.value = value;
      isarController.dataBase.refresh();
    });
  }
}
