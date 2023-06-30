import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: TextButton(
        style: TextButton.styleFrom(
          enableFeedback: true,
          padding: const EdgeInsets.symmetric(
            vertical: kPadding,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: TextButton(
        style: TextButton.styleFrom(
          enableFeedback: true,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColorLight,
            )
          ],
        ),
      ),
    );
  }
}
