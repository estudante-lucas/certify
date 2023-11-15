import 'package:certify/app/components/recent_card.dart';
import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/services/recents_storage/recents_storage_service.dart';
import 'package:flutter/material.dart';

class RecentCards extends StatefulWidget {
  const RecentCards({super.key});

  @override
  State<RecentCards> createState() => _RecentCardsState();
}

class _RecentCardsState extends State<RecentCards> with RouteAware {
  Future<List<Collaborator>?> recents = RecentsStorageService.get();

  @override
  void didPop() {
    recents = RecentsStorageService.get();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: recents,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Collaborator> collaborators = snapshot.data!;
            return Column(
              children: collaborators
                  .map<RecentCard>(
                    (user) => RecentCard(user: user),
                  )
                  .toList(),
            );
          } else {
            return const Column(
              children: [Text("Nenhuma pesquisa recente!")],
            );
          }
        },
      ),
    );
  }
}
