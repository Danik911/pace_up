import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/models/sneakers.dart';
import '../configs/colors.dart';
import '../configs/images.dart';
import '../theme/theme_cubit.dart';

class GenerationCard extends StatelessWidget {
  const GenerationCard(this.sneakers, {super.key});

  final Sneakers sneakers;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;

      return Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black87 : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 8),
              blurRadius: 15,
              color: AppColors.black.withOpacity(0.12),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    sneakers.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: sneakers.pokemons
                        .map(
                          (pokemon) => Expanded(
                            child: Image.asset(
                              pokemon,
                              fit: BoxFit.contain,
                              width: height * 0.41,
                              height: height * 0.41,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -height * 0.136,
              right: -height * 0.03,
              child: Image(
                image: AppImages.pokeball,
                width: height * 0.754,
                height: height * 0.754,
                color: AppColors.black.withOpacity(0.05),
              ),
            ),
          ],
        ),
      );
    });
  }
}
