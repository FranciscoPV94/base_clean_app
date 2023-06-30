import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/loader-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FadeIn(
        child: Platform.isIOS
            ? const CupertinoActivityIndicator()
            : CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
      )),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kPadding,
          ),
          child: FadeIn(
            child: Platform.isIOS
                ? const CupertinoActivityIndicator()
                : CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
          )),
    );
  }
}
