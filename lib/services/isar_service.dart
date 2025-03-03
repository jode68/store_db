import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_db/models/data_base.dart';

class IsarService extends GetxController {
  Isar? isar = Isar.getInstance();
  final dataBase = <DataBase>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await init();
    await getIsar();
  }

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([DataBaseSchema], directory: dir.path);
  }

  Future<void> getIsar() async {
    dataBase.value = await isar!.dataBases.where().findAll();
    dataBase.refresh();
  }

  Future<void> saveIsar() async {
    await isar!.writeTxn(() async {
      await isar!.dataBases.putAll(dataBase);
    });
    await getIsar();
  }

  Future<void> deleteIsar(DataBase data) async {
    await isar!.writeTxn(() async {
      await isar!.dataBases.delete(data.id);
    });
    await getIsar();
  }

  Future<void> clearIsar() async {
    await isar!.writeTxn(() async {
      await isar!.dataBases.clear();
    });
    await getIsar();
  }

  void saveDemoList() async {
    dataBase.clear();
    dataBase.addAll(demoList);
    await saveIsar();
  }
}

final demoList = [
  DataBase(
    article: 'Article 1',
    type: 'Type A',
    description: 'Description 1',
    quantity: 1,
    foto: 'Foto 1',
    sheet: 'Sheet 1',
  ),
  DataBase(
    article: 'Article 2',
    type: 'Type A',
    description: 'Description 2',
    quantity: 2,
    foto: 'Foto 2',
    sheet: 'Sheet 2',
  ),
  DataBase(
    article: 'Article 3',
    type: 'Type B',
    description: 'Description 3',
    quantity: 3,
    foto: 'Foto 3',
    sheet: 'Sheet 3',
  ),
  DataBase(
    article: 'Article 4',
    type: 'Type A',
    description: 'Description 4',
    quantity: 4,
    foto: 'Foto 4',
    sheet: 'Sheet 4',
  ),
  DataBase(
    article: 'Article 5',
    type: 'Type C',
    description: 'Description 5',
    quantity: 5,
    foto: 'Foto 5',
    sheet: 'Sheet 5',
  ),
  DataBase(
    article: 'Article 6',
    type: 'Type D',
    description: 'Description 6',
    quantity: 6,
    foto: 'Foto 6',
    sheet: 'Sheet 6',
  ),
  DataBase(
    article: 'Article 7',
    type: 'Type B',
    description: 'Description 7',
    quantity: 7,
    foto: 'Foto 7',
    sheet: 'Sheet 7',
  ),
  DataBase(
    article: 'Article 8',
    type: 'Type C',
    description: 'Description 8',
    quantity: 8,
    foto: 'Foto 8',
    sheet: 'Sheet 8',
  ),
];
