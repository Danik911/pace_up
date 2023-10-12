import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/app.dart';
import 'package:pace_up/data/repositories/cart_repositoty.dart';
import 'package:pace_up/data/repositories/item_repository.dart';
import 'package:pace_up/data/source/api/github_data_source.dart';
import 'package:pace_up/presentation/screens/cart_screen/bloc/cart_bloc.dart';
import 'package:pace_up/presentation/theme/theme_cubit.dart';
import 'package:pace_up/states/item/item_bloc.dart';
import 'core/network_manager.dart';
import 'data/source/local/local_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDataSource.initialize();

  runApp(
    MultiRepositoryProvider(
      providers: [
        ///
        /// Services
        ///
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),
        ///
        /// Data sources
        ///
        RepositoryProvider<LocalDataSource>(
          create: (context) => LocalDataSource(),
        ),
        RepositoryProvider<GithubDataSource>(
          create: (context) => GithubDataSource(context.read<NetworkManager>()),
        ),

        ///
        /// Repositories
        ///
        ///
        RepositoryProvider<ItemRepository>(
          create: (context) => ItemDefaultRepository(
            localDataSource: context.read<LocalDataSource>(),
            remoteDataSource: context.read<GithubDataSource>()

          ),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartDefaultRepository(
              localDataSource: context.read<LocalDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          ///
          /// BLoCs
          ///
          BlocProvider<ItemBloc>(
            create: (context) => ItemBloc(context.read<ItemRepository>()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(context.read<CartRepository>()),
          ),
          ///
          /// Theme Cubit
          ///
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}
