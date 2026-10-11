import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/cubit/main_layout_cubit.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/cubit/main_layout_state.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/browse_tab/browse_tab_body.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/widgets/custom_bottom_nav_bar.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/home_tab/home_tab_body.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/profile_tab/profile_screen.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/search_tab/search_tab.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  List<Widget> _getScreens() {
    return [
      const HomeTabBody(),
      const SearchTab(),
      const BrowseTabBody(),
      const ProfileScreen(),
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
              children: _getScreens(),
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
