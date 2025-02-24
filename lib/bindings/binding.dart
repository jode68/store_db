import 'package:get/get.dart';
import 'package:store_db/controllers/controller.dart';
import 'package:store_db/services/isar_service.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Controller());
    Get.lazyPut(() => IsarService());
  }
}
