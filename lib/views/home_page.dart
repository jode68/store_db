import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/models/data_base.dart';
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
          onPressed: () {
            controller.saveIsar(
              DataBase(
                article: 'article',
                type: 'type',
                description: 'description',
                quantity: 0,
              ),
            );
          },
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
