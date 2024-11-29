import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/widgets/pages/main_page.dart';
import 'package:web_app/widgets/stream_builders/cancelled_stream_builder.dart';
import 'package:web_app/widgets/stream_builders/ended_stream_builder.dart';
import 'package:web_app/widgets/stream_builders/my_services_stream_builder.dart';
import 'package:web_app/widgets/stream_builders/pending_stream_builder.dart';
import 'package:web_app/widgets/stream_builders/service_cancelled_stream_builder.dart';
import 'package:web_app/widgets/stream_builders/service_pending_stream_builder.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.selectedIndex});

  int selectedIndex;

  @override
  String get searchFieldLabel => 'Buscador de ...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String userUid = context.watch<AppState>().currentUser!.uid;

    return switch (selectedIndex) {
      0 => MainPage(),
      1 => PendingStreamBuilder(
          userUid: userUid,
          type: 'businessName',
          name: query,
        ),
      2 => CancelledStreamBuilder(
          userUid: userUid,
          type: 'businessName',
          name: query,
        ),
      3 => EndedStreamBuilder(
          userUid: userUid,
          type: 'businessName',
          name: query,
        ),
      4 => MyServicesStreamBuilder(
          userUid: userUid,
          type: 'businessName',
          name: query,
        ),
      5 => ServicePendingStreamBuilder(
          userUid: userUid,
          type: 'businessName',
          name: query,
        ),
      6 => ServiceCancelledStreamBuilder(
          userUid: userUid,
          type: 'businessName',
          name: query,
        ),
      _ => throw UnimplementedError('no widget for $selectedIndex'),
    };
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: [].length,
      itemBuilder: (context, index) {
        var result = [][index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
