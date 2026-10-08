import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'history_tab.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0; // 0 = Watch List, 1 = History
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.black,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              // 1. Header
              SliverToBoxAdapter(child: buildHeader()),

              // 2. Tabs (pinned: true = they stick to the top)
              SliverAppBar(
                pinned: true,
                primary: false,
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.darkGrey,
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0,
                bottom: buildTabBar(),
              ),

              // 3. Content of the selected tab
              if (selectedTab == 0)
                buildEmptyWatchList()
              else
                const HistoryTab(),
            ],
          ),
        ),
        // bottomNavigationBar: buildBottomNavBar(),
      ),
    );
  }

  // ---------------- Header ----------------

  Widget buildHeader() {
    return Container(
      color: AppColors.darkGrey,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar + name
              const Column(
                children: [
                  CircleAvatar(
                    radius: 59,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage('assets/profile_images/gamer (1).png'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'John Safwat',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(child: buildStatItem('12', 'Wish List')),
              Expanded(child: buildStatItem('10', 'History')),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildButton(
                  text: 'Edit Profile',
                  color: AppColors.yellow,
                  textColor: AppColors.black,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildButton(
                  text: 'Exit',
                  color: AppColors.red,
                  textColor: Colors.white,
                  icon: Icons.logout_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // FittedBox makes the text smaller on small phones instead of overflowing
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required Color textColor,
    IconData? icon,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: const TextStyle(fontSize: 20)),
            if (icon != null) const SizedBox(width: 8),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }

  // ---------------- Tabs ----------------

  TabBar buildTabBar() {
    return TabBar(
      onTap: (index) {
        setState(() {
          selectedTab = index;
        });
      },
      indicatorColor: AppColors.yellow,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.white,
      labelStyle: const TextStyle(fontSize: 20),
      tabs: const [
        Tab(
          icon: Icon(
            Icons.format_list_bulleted_rounded,
            color: AppColors.yellow,
            size: 30,
          ),
          text: 'Watch List',
        ),
        Tab(
          icon: Icon(Icons.folder_rounded, color: AppColors.yellow, size: 30),
          text: 'History',
        ),
      ],
    );
  }

  Widget buildEmptyWatchList() {
    // SliverFillRemaining = take the rest of the screen under the tabs
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Center(
            child:
                Image.asset('assets/profile_images/Empty 1.png', width: 124)),
      ),
    );
  }

  // ---------------- Bottom Navigation Bar ----------------

  Widget buildBottomNavBar() {
    return SafeArea(
      top: false,
      child: Container(
        height: 61,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          color: AppColors.navBarBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavIcon(Icons.home_rounded),
            buildNavIcon(Icons.search_rounded),
            buildNavIcon(Icons.explore_rounded),
            buildNavIcon(Icons.account_circle_outlined, isSelected: true),
          ],
        ),
      ),
    );
  }

  Widget buildNavIcon(IconData icon, {bool isSelected = false}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 30,
        color: isSelected ? AppColors.yellow : Colors.white,
      ),
    );
  }
}
