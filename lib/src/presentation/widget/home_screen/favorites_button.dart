import 'package:flutter/material.dart';

import '../../../core/util/notification_service.dart';

class FavoriteButton extends StatefulWidget {
  static const String notificationTitle = 'Favorites';
  static const String addedMovieNotificationDescription =
      'You added a Movie to favorites';
  static const String removedMoviesNotificationDescription =
      'You removed a movie from favorites';
  static const String addToFavorites = 'Add to favorites';
  static const String removeFromFavorites = 'Remove from favorites';

  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  void toggleFav() {
    if (isFavorite) {
      isFavorite = false;
      NotificationService().showNotification(
        title: FavoriteButton.notificationTitle,
        body: FavoriteButton.removedMoviesNotificationDescription,
      );
    } else {
      isFavorite = true;
      NotificationService().showNotification(
        title: FavoriteButton.notificationTitle,
        body: FavoriteButton.addedMovieNotificationDescription,
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return ElevatedButton.icon(
      onPressed: () {
        toggleFav();
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
