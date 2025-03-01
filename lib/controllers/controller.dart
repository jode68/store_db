import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:store_db/models/data_base.dart';
import 'package:store_db/services/isar_service.dart';

class Controller extends GetxController {
  final isarController = Get.find<IsarService>();

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

      isarController.dataBase.add(dataBase);
      isarController.saveAllIsar();

      articleEdit.clear();
      typeEdit.clear();
      descriptionEdit.clear();
      quantityEdit.clear();
      fotoEdit.clear();
      sheetEdit.clear();
    }
  }

  void updateArticle(DataBase data) {
    isarController.isar!.writeTxnSync(() {
      final isarData = isarController.isar!.dataBases.getSync(data.id);

      isarData!.article = articleEdit.value.text;
      isarData.type = typeEdit.value.text;
      isarData.description = descriptionEdit.value.text;
      isarData.quantity = int.parse(quantityEdit.value.text);
      isarData.foto = fotoEdit.value.text;
      isarData.sheet = sheetEdit.value.text;

      isarController.isar!.dataBases.putSync(isarData);
    });
    isarController.getIsar();
  }

  void sortToggle() {
    final data = isarController.dataBase.reversed.toList();
    isarController.dataBase.value = data;
    isarController.dataBase.refresh();
  }

  void sortList() {
    isarController.dataBase.sort((a, b) => a.article.compareTo(b.article));
    isarController.dataBase.refresh();
  }

  void searchName(String name) {
    final isar = IsarService().isar;
    isar!.dataBases.filter().typeEqualTo(name).findAll().then((value) {
      isarController.dataBase.value = value;
      isarController.dataBase.refresh();
    });
  }
}
