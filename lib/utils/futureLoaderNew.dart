// Copyright (c) 2024 Suryakant
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

Future<Result<T>> customFutureLoader<T>({
  required BuildContext context,
  required Future<T> Function() future,
  String? title,
  String? backLabel,
  String Function(dynamic exception)? onError,
  bool barrierDismissible = false,
}) async {
  final result = await showAdaptiveDialog<Result<T>>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => LoadingDialog<T>(
      future: future,
      title: title,
      backLabel: backLabel,
      onError: onError,
    ),
  );
  return result ??
      Result.error(
        Exception(' FutureDialog canceled'),
        StackTrace.current,
      );
}

class LoadingDialog<T> extends StatefulWidget {
  final String? title;
  final String? backLabel;
  final Future<T> Function() future;
  final String Function(dynamic exception)? onError;

  static String defaultTitle = 'Loading... Please Wait!';
  static String defaultBackLabel = 'Back';
  // ignore: prefer_function_declarations_over_variables
  static String Function(dynamic exception) defaultOnError =
      (exception) => exception.toString();

  const LoadingDialog({
    Key? key,
    required this.future,
    this.title,
    this.onError,
    this.backLabel,
  }) : super(key: key);
  @override
  LoadingDialogState<T> createState() => LoadingDialogState<T>();
}

class LoadingDialogState<T> extends State<LoadingDialog> {
  dynamic exception;
  StackTrace? stackTrace;

  @override
  void initState() {
    super.initState();
    widget.future().then(
        (result) => Navigator.of(context).pop<Result<T>>(Result.value(result)),
        onError: (e, s) => setState(() {
              exception = e;
              stackTrace = s;
            }));
  }

  @override
  Widget build(BuildContext context) {
    final titleLabel = exception != null
        ? widget.onError?.call(exception) ??
            LoadingDialog.defaultOnError(exception)
        : widget.title ?? LoadingDialog.defaultTitle;

    return AlertDialog.adaptive(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (exception == null)
            const CircularProgressIndicator.adaptive()
          else
            const Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
            ),
          const SizedBox(width: 20),
          SizedBox(
            width: 150,
            child: Text(
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              titleLabel,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
      actions: exception == null
          ? null
          : [
              TextButton(
                onPressed: () => Navigator.of(context).pop<Result<T>>(
                  Result.error(
                    exception,
                    stackTrace,
                  ),
                ),
                child: Text(widget.backLabel ?? LoadingDialog.defaultBackLabel),
              ),
            ],
    );
  }
}

extension DeprecatedApiAccessExtension<T> on Result<T> {
  T? get result => asValue?.value;

  Object? get error => asError?.error;
}
