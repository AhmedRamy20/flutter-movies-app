import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movies_app/app_router.dart';
import 'package:movies_app/busieness_logic/cubit/connection/connection_cubit.dart';
import 'package:movies_app/busieness_logic/cubit/favourite/favourite_cubit.dart';
import 'package:movies_app/busieness_logic/bloc/home/home_bloc.dart';
import 'package:movies_app/busieness_logic/bloc/search/search_bloc.dart';
import 'package:movies_app/busieness_logic/cubit/theme/theme_cubit.dart';
import 'package:movies_app/core/confg/theme/app_theme.dart';
import 'package:movies_app/data/firestore_service/favorites_service.dart';

import 'package:movies_app/data/repository/firestore_fav_repo.dart';
import 'package:movies_app/data/repository/movies_repo.dart';
import 'package:movies_app/busieness_logic/bloc/auth/auth_bloc.dart';
import 'package:movies_app/data/web_service/auth/firebase_auth_provider.dart';
import 'package:movies_app/data/web_service/web_service.dart';
import 'package:movies_app/gate_decide.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => MoviesRepo(webService: WebService())),
        RepositoryProvider(
          create: (_) => FireStoreFavoritesRepo(FavoritesService()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ConnectionCubit()),
          BlocProvider(
            create: (context) => HomeBloc(context.read<MoviesRepo>()),
          ),
          BlocProvider(create: (context) => AuthBloc(FirebaseAuthProvider())),

          BlocProvider(
            create: (context) => SearchBloc(context.read<MoviesRepo>()),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(
            create: (context) =>
                FavoritesCubit(context.read<FireStoreFavoritesRepo>())
                  ..loadFavorites(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: AppTheme.lightMode,
              darkTheme: AppTheme.darkMode,
              themeMode: mode,
              home: const GateDecideViews(),
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
