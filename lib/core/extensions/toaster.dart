import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/types.dart';
import 'dart:developer' as dev;

abstract class Toaster {
  void show(String message);
}

class ToasterExtension implements Toaster, BarcodeCenterExtension {
  late FToast fToast;
  static ToasterExtension? _instance;

  ToasterExtension._(BuildContext appContext) {
    fToast = FToast();
    fToast.init(appContext);
  }

  factory ToasterExtension.instance(BuildContext? appContext) {
    assert(
      (appContext == null) && (_instance != null),
      '''ToasterExtension.instance() must be initialised with a valid BuildContext before 
        calling it without a BuildContext''',
    );

    _instance ??= ToasterExtension._(appContext!);
    return _instance!;
  }

  @override
  void show(String message) {
    fToast.showToast(child: _ToastWidget(message));
  }

  @override
  void onBarcode(String barcode) {
    dev.log(barcode, name: "idir.app");
    show(barcode);
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  const _ToastWidget(this.message);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: theme.colorScheme.secondaryContainer,
      child: Text(
        message,
        style: theme.textTheme.bodySmall!
            .copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
