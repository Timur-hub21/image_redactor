import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: onTap,
          child: icon,
        ),
      ),
    );
  }
}
