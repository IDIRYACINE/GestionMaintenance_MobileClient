import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/components/widgets/custom_texts.dart';

class ClickableRow extends StatelessWidget {
  const ClickableRow(
      {super.key,
      this.onTap,
      required this.title,
      this.leading,
      this.trailling,
      this.description});

  final VoidCallback? onTap;
  final Widget? leading;
  final Widget title;
  final Widget? trailling;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: leading,
            title: title,
            subtitle: description,
            trailing: trailling,
          )),
    );
  }
}

class SettingsRow extends StatelessWidget {
  const SettingsRow(
      {super.key,
      required this.title,
      this.description,
      this.icon,
      this.onTap,
      this.isEnabled});

  final String title;
  final String? description;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return ClickableRow(
      title: SettingTitle(
        title: title,
      ),
      description: description != null
          ? SettingsDescription(description: description!)
          : null,
      leading: icon,
      trailling: isEnabled != null
          ? Switch(
              value: isEnabled!,
              onChanged: (value) {
                onTap!();
              },
            )
          : null,
      onTap: onTap,
    );
  }
}

class RadioRow<T> extends StatelessWidget {
  const RadioRow(
      {super.key,
      required this.title,
      required this.rowValue,
      required this.groupValue,
      required this.onSelected});

  final String title;
  final T rowValue;
  final T groupValue;
  final Function(T?) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Radio<T>(
        groupValue: groupValue,
        onChanged: onSelected,
        value: rowValue,
      ),
    );
  }
}
