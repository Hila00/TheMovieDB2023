// import 'package:flutter/material.dart';
// import '../app_header.dart';
// import 'related_genres_title.dart';
// import 'genres_list.dart';
// import 'movie_description.dart';
// import 'movie_info_container.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   static const String backDropImagePath = 'assets/images/backdropImage.jpg';
//   static const double sizedBoxHeight = 10;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           children: [
//             const AppHeader(),
//             Image.asset(backDropImagePath),
//             const RelatedGenresTitle(),
//             const GenresList(),
//             const SizedBox(
//               height: sizedBoxHeight,
//             ),
//             const MovieInfoContainer(),
//             const MovieDescription(),
//           ],
//         ),
//       ),
//     );
//   }
// }
