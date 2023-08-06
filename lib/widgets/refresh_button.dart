import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  final bool? isLoading;
  final void Function()? onPressed;

  const RefreshButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: isLoading!,
        replacement: IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: onPressed,
          color: Colors.white,
        ),
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }
}
