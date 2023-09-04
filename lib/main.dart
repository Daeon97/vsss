// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vsss/app.dart';
import 'package:vsss/injection_container.dart';

void main() => initializeImportantResources().then(
      (_) => runApp(
        const App(),
      ),
    );

Future<void> initializeImportantResources() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  registerServices();
}
