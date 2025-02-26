import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/models/data_base.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    DataBase itemData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(itemData.article, style: const TextStyle(fontSize: 32)),
            Text(itemData.type, style: const TextStyle(fontSize: 32)),
            Text(itemData.description, style: const TextStyle(fontSize: 32)),
            Text(itemData.quantity.toString(),
                style: const TextStyle(fontSize: 32)),
            Text(itemData.foto, style: const TextStyle(fontSize: 32)),
            Text(itemData.scheme, style: const TextStyle(fontSize: 32)),
          ],
        ),
      ),
    );
  }
}
