import 'package:flutter/material.dart';
import 'features/profile/presentation/screens/update_profile_screen.dart';
void main(){
  runApp(const MoviesApp());

}
class MoviesApp extends StatelessWidget{
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies app',
      theme: ThemeData(
        useMaterial3: true
      ),
      home: UpdateProfileScreen(),
    );
  }
}