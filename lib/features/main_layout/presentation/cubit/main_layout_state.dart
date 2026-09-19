abstract class MainLayoutState {
  final int currentIndex;
  const MainLayoutState({required this.currentIndex});
}

class MainLayoutInitial extends MainLayoutState {
  const MainLayoutInitial({super.currentIndex = 0});
}

class ChangeBottomNavState extends MainLayoutState {
  const ChangeBottomNavState({required super.currentIndex});
}
