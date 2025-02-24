import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_db/models/data_base.dart';

class IsarService extends GetxController {
  late Isar isar;
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
    dataBase.value = await isar.dataBases.where().findAll();
    dataBase.refresh();
  }

  void saveIsar(DataBase data) async {
    await isar.writeTxn(() async {
      await isar.dataBases.put(data);
    });
    await getIsar();
  }

  Future<void> deleteIsar(DataBase data) async {
    await isar.writeTxn(() async {
      await isar.dataBases.delete(data.id);
    });
    await getIsar();
  }

  Future<void> clearIsar() async {
    await isar.writeTxn(() async {
      await isar.dataBases.clear();
    });
    await getIsar();
  }
}
