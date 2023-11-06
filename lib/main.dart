import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';
import 'src/core/util/bloc_singleton_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSingletonDependencies singletonDependencies = BlocSingletonDependencies();
  await singletonDependencies.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => singletonDependencies.moviesBloc,
        ),
        Provider(
          create: (_) => singletonDependencies.genresBloc,
        ),
        Provider(
          create: (_) => singletonDependencies.trailersBloc,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
