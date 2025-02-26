import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/models/data_base.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    DataBase item = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.article, style: const TextStyle(fontSize: 32)),
            Text(item.type, style: const TextStyle(fontSize: 32)),
            Text(item.description, style: const TextStyle(fontSize: 32)),
            Text(item.quantity.toString(),
                style: const TextStyle(fontSize: 32)),
            Text(item.foto, style: const TextStyle(fontSize: 32)),
            Text(item.scheme, style: const TextStyle(fontSize: 32)),
          ],
        ),
      ),
    );
  }
}
