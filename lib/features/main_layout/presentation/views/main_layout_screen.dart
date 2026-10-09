import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:movies_app/features/main_layout/presentation/cubit/main_layout_state.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/browse_tab/presentation/pages/browse_tab_body.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:movies_app/features/main_layout/presentation/widgets/home_tab/presentation/pages/home_tab_body.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  List<Widget> _getScreens(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      const HomeTabBody(),
      Center(
        child: Text(
          l10n.searchScreen,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Center(
        child: Text(
          l10n.exploreScreen,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Center(
        child: Text(
          l10n.profileScreen,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            extendBody: true,
            body: IndexedStack(
              index: state.currentIndex,
              children: _getScreens(context),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<MainLayoutCubit>().changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
