import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_bloc.dart';
import 'package:movies_app/constents/routes.dart';
import 'package:movies_app/data/model/movie_hive_model.dart';
import 'package:movies_app/data/repository/fav_repo.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/data/web_service/web_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieHiveModelAdapter());

  await Hive.openBox<MovieHiveModel>('favorites');

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => MoviesRepo(webService: WebService())),
        RepositoryProvider(create: (_) => FavoritesRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(context.read<MoviesRepo>()),
          ),

          BlocProvider(
            create: (context) => SearchBloc(context.read<MoviesRepo>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.dark,
            ),
          ),
          // home: const BottomNavEntry(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: Routes.home,
        ),
      ),
    );
  }
}
