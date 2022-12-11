import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/components/widgets/scanned_item.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Localisations.of(context)!.title),
        ),
        body: BlocBuilder<RecordsBloc, RecordState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.records.length,
              itemBuilder: (context, index) {
                return ScannedLocation(id: index);
              },
            );
          },
        ));
  }
}
