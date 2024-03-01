import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final void Function() onPressed;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onPressed,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          widget.onPressed();

          setState(() => _scale = 1.2);
        },
        iconSize: 34,
        icon: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          onEnd: () {
            setState(() => _scale = 1.0);
          },
          scale: _scale,
          child: Icon(
            Icons.favorite,
            color: widget.isLiked ? Colors.red : Colors.blueGrey[300],
          ),
        ),
      ),
    );
  }
}
