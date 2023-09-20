import 'package:flutter/material.dart';

class MovieLikeButton extends StatefulWidget {
  final Key _likeButtonKey = const Key('LikeButtonKey');

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
    } else {
      isLikeTapped = true;
      likesAmount++;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: widget._likeButtonKey,
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
