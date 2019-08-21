import 'package:flutter/material.dart';

/**
 * Default manually triggered circle
 */

///
class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 30.0,
        height: 30.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
      ),
    );
  }
}
