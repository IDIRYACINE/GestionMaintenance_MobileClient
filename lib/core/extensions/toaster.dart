import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/types.dart';


abstract class Toaster {
  void show(String message);
}

class ToasterExtension implements Toaster, BarcodeCenterExtension {
  late FToast fToast;
  static ToasterExtension? _instance;
  late BuildContext _appContext;

  ToasterExtension._();

  factory ToasterExtension.instance() {
   

    _instance ??= ToasterExtension._();

    return _instance!;
  }

  @override
  void show(String message) {
    FToast.toast(_appContext,
    msg: message);
  }

  @override
  void onBarcode(String barcode) {
    show(barcode);
  }

  void setBuildContext(BuildContext context) {
    _appContext = context;
  }

}

// ignore: unused_element
class _ToastWidget extends StatelessWidget {
  final String message;
  const _ToastWidget(this.message);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: theme.colorScheme.secondaryContainer,
        child: Text(
          message,
          style: theme.textTheme.bodySmall!
              .copyWith(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
