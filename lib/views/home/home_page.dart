import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/controllers/controller.dart';
import 'package:store_db/routes/routes.dart';
import 'package:store_db/services/isar_service.dart';
import 'package:store_db/widgets/widget.dart';

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
            PopupMenuButton(
              child: const Icon(Icons.menu, color: Colors.deepPurple),
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
              leading: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () => addWidget(itemData),
              ),
              onTap: () => Get.toNamed(Routes.detailPage, arguments: itemData),
            );
          },
        ),
      );
    });
  }
}
