import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/controllers/controller.dart';
import 'package:store_db/routes/routes.dart';
import 'package:store_db/services/isar_service.dart';

class HomePage extends GetView<IsarService> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final listData = controller.dataBase;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              onPressed: () => controller.clearIsar(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => addWidget(),
        ),
        body: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            final itemData = listData[index];
            return ListTile(
              title: Text(itemData.article),
              subtitle: Text(itemData.type),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.deepOrange),
                onPressed: () => controller.deleteIsar(itemData),
              ),
              onTap: () {
                Get.toNamed(Routes.detailPage, arguments: itemData);
              },
            );
          },
        ),
      );
    });
  }
}

void addWidget() {
  final controller = Get.find<Controller>();
  Get.bottomSheet(
    Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.articleEdit,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Article'),
          ),
          TextField(
            controller: controller.typeEdit,
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          TextField(
            controller: controller.descriptionEdit,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: controller.quantityEdit,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
          TextField(
            controller: controller.fotoEdit,
            decoration: const InputDecoration(labelText: 'Foto'),
          ),
          TextField(
            controller: controller.sheetEdit,
            decoration: const InputDecoration(labelText: 'Sheet'),
          ),
          ElevatedButton(
            child: const Text('Add Article'),
            onPressed: () {
              controller.addArticle();
              Get.back();
            },
          ),
        ],
      ),
    ),
  );
}
