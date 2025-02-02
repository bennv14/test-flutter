import 'package:flutter/material.dart';
import 'package:test/widgets/loading_widget.dart';

class BaseLoadingScreen extends StatelessWidget {
  const BaseLoadingScreen({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const PopScope(
            canPop: true,
            child: LoadingWidget(),
          )
        : const SizedBox();
  }
}
