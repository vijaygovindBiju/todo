import 'package:flutter/material.dart';

class Myslidabelaction extends StatelessWidget {
  final Widget child;
  final VoidCallback onPress;
  final Color backgroundColor;

  const Myslidabelaction({
    super.key,
    required this.backgroundColor,
    required this.child,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: backgroundColor,
      child: InkWell(
        onTap: onPress,
        child: Center(child: child),
      ),
    );
  }
}
