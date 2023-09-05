// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vsss/app.dart';
import 'package:vsss/injection_container.dart';
import 'package:vsss/models/chat.dart';

void main() => initializeImportantResources().then(
      (_) => runApp(
        const App(),
      ),
    );

Future<void> initializeImportantResources() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: directory,
  );

  Hive
    ..init(
      directory.path,
    )
    ..registerAdapter(
      ChatAdapter(),
    );

  await dotenv.load();

  registerServices();
}
