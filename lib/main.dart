import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_up/app.dart';
import 'package:pace_up/data/repositories/item_repository.dart';
import 'package:pace_up/presentation/theme/theme_cubit.dart';
import 'package:pace_up/states/item/item_bloc.dart';

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
       //TODO("Add Network Manager ")
        ///
        /// Data sources
        ///
        RepositoryProvider<LocalDataSource>(
          create: (context) => LocalDataSource(),
        ),

        ///
        /// Repositories
        ///
        //TODO("Add Network DataSource")
        RepositoryProvider<ItemRepository>(
          create: (context) => ItemDefaultRepository(
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
