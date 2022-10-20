import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/types.dart';

abstract class Toaster {
  void show(String message);
}

class ToasterExtension implements Toaster , BarcodeCenterExtension{
  late FToast fToast;

  ToasterExtension(BuildContext appContext){
    fToast = FToast();
    fToast.init(appContext);
  }

  @override
  void show(String message) {
    fToast.showToast(child: _ToastWidget(message));
  }
  
  @override
  void onBarcode(String barcode) {
    show(barcode);
  }
}

class _ToastWidget extends StatelessWidget{
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
      child: Text(message,style: theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onSecondaryContainer
      ),),
    );
  }
}