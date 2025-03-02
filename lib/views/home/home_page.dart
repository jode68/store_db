import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/controllers/controller.dart';
import 'package:store_db/models/data_base.dart';
import 'package:store_db/routes/routes.dart';
import 'package:store_db/services/isar_service.dart';

class HomePage extends GetView<IsarService> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final operation = Get.find<Controller>();
    final listData = controller.dataBase;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () => controller.clearIsar(),
            ),
            IconButton(
              icon: const Icon(Icons.save, color: Colors.yellow),
              onPressed: () => controller.saveDemoList(),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.deepPurple),
              onPressed: () => operation.sortToggle(),
            ),
            IconButton(
              icon: const Icon(Icons.book, color: Colors.deepPurple),
              onPressed: () => controller.getIsar(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => addWidget(),
        ),
        body: Column(
          children: [
            PopupMenuButton(
              itemBuilder: (context) {
                final menuList = listData.map((e) => e.type).toSet().toList();
                return [
                  PopupMenuItem(
                    child: Text('All Item'),
                    onTap: () => controller.getIsar(),
                  ),
                  for (int i = 0; i < menuList.length; i++)
                    PopupMenuItem(
                      value: i,
                      child: Text(menuList[i]),
                      onTap: () => operation.searchName(menuList[i]),
                    ),
                ];
              },
            ),
            Expanded(
              child: ListView.builder(
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
                    leading: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () => addWidget(itemData),
                    ),
                    onTap: () =>
                        Get.toNamed(Routes.detailPage, arguments: itemData),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

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
