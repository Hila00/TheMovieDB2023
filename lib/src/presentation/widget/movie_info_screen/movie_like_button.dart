import 'package:flutter/material.dart';

class MovieLikeButton extends StatefulWidget {
  const MovieLikeButton({
    super.key,
  });

  @override
  State<MovieLikeButton> createState() => _MovieLikeButtonState();
}

class _MovieLikeButtonState extends State<MovieLikeButton> {
  int likesAmount = 2341;
  bool isLikeTapped = false;

  void toggleLike() {
    if (isLikeTapped) {
      isLikeTapped = false;
      likesAmount--;
    }
    else {
      isLikeTapped = true;
      likesAmount++;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        toggleLike();
      },
      icon: Icon(
        isLikeTapped ? Icons.favorite : Icons.favorite_border,
      ),
      label: Text(
        likesAmount.toString(),
      ),
    );
  }
}
