import 'dart:async';

import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          alignment: Alignment.center,
          height: size.height * 0.15,
          width: 30,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(), // Your circular indicator
              const SizedBox(height: 20),
              Text(
                'Loading...',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<T?> showLoadingDialog<T>(
    BuildContext context, Future<T> Function() function) async {
  Completer<T?> completer = Completer<T?>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          // Disable back button when dialog is open
          return false;
        },
        child: LoadingDialog(),
      );
    },
  );

  try {
    T result = await function();
    print("$result");
    completer.complete(result);
  } catch (error) {
    completer.completeError(error);
  }
  completer.future.whenComplete(() {
    Navigator.of(context).pop();
  });

  return completer.future;
}
