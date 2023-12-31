import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/app.dart';
import 'package:pace_up/data/repositories/item_repository.dart';
import 'package:pace_up/data/source/api/github_data_source.dart';
import 'package:pace_up/presentation/theme/theme_cubit.dart';
import 'package:pace_up/states/item/item_bloc.dart';
import 'core/network_manager.dart';
import 'data/source/local/hive/local_data_source_impl_hive.dart';
import 'data/source/local/local_data_source.dart';
import 'data/source/local/sqflite/local_datasource_impl_sqf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalDataSourceImplHive.initialize();

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
          //Here you can switch between data sources
          create: (context) => LocalDataSourceImplSq(),
        ),
        RepositoryProvider<GithubDataSource>(
          create: (context) => GithubDataSource(context.read<NetworkManager>()),
        ),
        ///
        /// Repositories
        ///
        RepositoryProvider<ItemRepository>(
          create: (context) => ItemDefaultRepository(
            localDataSource: context.read<LocalDataSource>(),
            remoteDataSource: context.read<GithubDataSource>()

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
