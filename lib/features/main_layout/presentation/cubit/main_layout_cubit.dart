import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(const MainLayoutInitial());

  static MainLayoutCubit get(BuildContext context) =>
      BlocProvider.of<MainLayoutCubit>(context);

  int currentIndex = 0;

  void changeIndex(int newIndex) {
    if (currentIndex == newIndex) return;
    currentIndex = newIndex;
    emit(ChangeBottomNavState(currentIndex: currentIndex));
  }

  void changeBottomNav(int index) => changeIndex(index);
}
