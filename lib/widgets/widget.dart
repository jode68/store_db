import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/controllers/controller.dart';
import 'package:store_db/models/data_base.dart';

void addWidget([DataBase? data]) {
  final controller = Get.find<Controller>();
  Get.bottomSheet(
    Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.articleEdit..text = data?.article ?? '',
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Article'),
          ),
          TextField(
            controller: controller.typeEdit..text = data?.type ?? '',
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          TextField(
            controller: controller.descriptionEdit
              ..text = data?.description ?? '',
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: controller.quantityEdit
              ..text = data?.quantity.toString() ?? '',
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          TextField(
            controller: controller.fotoEdit..text = data?.foto ?? '',
            decoration: const InputDecoration(labelText: 'Foto'),
          ),
          TextField(
            controller: controller.sheetEdit..text = data?.sheet ?? '',
            decoration: const InputDecoration(labelText: 'Sheet'),
          ),
          ElevatedButton(
            child: data != null
                ? const Text('Update Article')
                : const Text('Add Article'),
            onPressed: () {
              if (data != null) {
                controller.updateArticle(data);
              } else {
                controller.addArticle();
              }
              Get.back();
            },
          ),
        ],
      ),
    ),
  );
}
