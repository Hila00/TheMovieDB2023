import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/util/notification_service.dart';
import '../../../domain/entity/movie.dart';
import '../../bloc/favorites_bloc.dart';

class FavoriteButton extends StatefulWidget {
  static const String notificationTitle = 'Favorites';
  static const String addedMovieNotificationDescription =
      'You added a Movie to favorites';
  static const String removedMoviesNotificationDescription =
      'You removed a movie from favorites';
  static const String addToFavorites = 'Add to favorites';
  static const String removeFromFavorites = 'Remove from favorites';
  final Movie attachedMovie;

  const FavoriteButton({
    required this.attachedMovie,
    super.key,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavoriteStatus();
  }

  void loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        isFavorite =
            prefs.getBool('isFavorite_${widget.attachedMovie.id}') ?? false;
      },
    );
  }

  void saveFavoriteStatus(bool newStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite_${widget.attachedMovie.id}', newStatus);
  }

  void toggleFav(FavoritesBloc favoritesBloc) {
    if (isFavorite) {
      isFavorite = false;
      favoritesBloc.removeFavoriteUseCase(widget.attachedMovie);
      NotificationService().showNotification(
        title: FavoriteButton.notificationTitle,
        body: FavoriteButton.removedMoviesNotificationDescription,
      );
    } else {
      isFavorite = true;
      favoritesBloc.addMovieToFavorites(widget.attachedMovie);
      NotificationService().showNotification(
        title: FavoriteButton.notificationTitle,
        body: FavoriteButton.addedMovieNotificationDescription,
      );
    }

    saveFavoriteStatus(isFavorite);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FavoritesBloc favoritesBloc = Provider.of<FavoritesBloc>(context);
    return ElevatedButton.icon(
      onPressed: () {
        toggleFav(favoritesBloc);
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
      label: Text(
        isFavorite
            ? FavoriteButton.removeFromFavorites
            : FavoriteButton.addToFavorites,
      ),
    );
  }
}
