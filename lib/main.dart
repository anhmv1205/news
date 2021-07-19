import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/core/util/dependency.dart';
import 'package:news/core/util/local_storage.dart';
import 'package:news/presentation/app.dart';

void main() async {
  DenpendencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(App());
}

initServices() async {
  print('starting services ...');
  await Get.putAsync(() => LocalStorage().init());
  print('All services started...');
}
