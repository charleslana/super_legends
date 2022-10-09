import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.title,
    required this.callback,
    this.disableActionButton = false,
  }) : super(key: key);

  final String title;
  final VoidCallback callback;
  final bool disableActionButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: IgnorePointer(
        ignoring: disableActionButton,
        child: ElevatedButton(
          onPressed: callback,
          child: Text(title),
        ),
      ),
    );
  }
}
