import 'package:certify/app/components/recent_card.dart';
import 'package:certify/shared/models/worker/worker_model.dart';
import 'package:certify/shared/services/worker/worker_service.dart';
import 'package:flutter/material.dart';

class RecentCards extends StatefulWidget {
  const RecentCards({super.key});

  @override
  State<RecentCards> createState() => _RecentCardsState();
}

class _RecentCardsState extends State<RecentCards> {
  Future<List<Worker>> recents = WorkerService.findAllWorkers();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: recents,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Worker> workers = snapshot.data!;
            return Column(
              children: workers
                  .map<RecentCard>(
                    (user) => RecentCard(user: user),
                  )
                  .toList(),
            );
          } else {
            return const Column(
              children: [Text("Nenhum resultado encontrado!")],
            );
          }
        },
      ),
    );
  }
}
