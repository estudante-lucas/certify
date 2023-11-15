import 'dart:async';

import 'package:certify/shared/models/collaborator/collaborator_model.dart';
import 'package:certify/shared/routes/app_routes.dart';
import 'package:certify/shared/services/collaborator/collaborator_service.dart';
import 'package:certify/shared/services/recents_storage/recents_storage_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchSuggestionBar extends StatefulWidget {
  const SearchSuggestionBar({super.key});

  @override
  State<SearchSuggestionBar> createState() => _SearchSuggestionBarState();
}

class _SearchSuggestionBarState extends State<SearchSuggestionBar> {
  List<Collaborator>? _suggestions = [];
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          backgroundColor: const MaterialStatePropertyAll(
            Color.fromRGBO(236, 230, 240, 1),
          ),
          padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
          controller: controller,
          onSubmitted: (_) {
            controller.openView();
          },
          onChanged: (value) {
            _debounceTimer?.cancel();

            _debounceTimer = Timer(const Duration(milliseconds: 500), () {
              CollaboratorService.findByTerm(value).then((collaborators) => setState(() => _suggestions = collaborators));
            });
          },
          hintStyle: const MaterialStatePropertyAll(TextStyle(color: AppColors.fontOnSurface)),
          hintText: "Nome ou matrícula",
          trailing: const <Widget>[
            Icon(Icons.search),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
        CollaboratorService.findAll().then((collaborators) => setState(() => _suggestions = collaborators));

        if (_suggestions != null && _suggestions!.isNotEmpty) {
          return _suggestions!.map((collaborator) {
            final Widget userImage = collaborator.image != null
                ? const Text("IM")
                : Text(
                    collaborator.getInitials(),
                    style: const TextStyle(color: AppColors.fontSecondary),
                  );

            return ListTile(
              leading: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.circle, size: 45, color: AppColors.backgroundSecondary),
                  userImage,
                ],
              ),
              title: Text(collaborator.name),
              onTap: () {
                RecentsStorageService.add(collaborator);
                Navigator.pushNamed(context, AppRoutes.worker, arguments: collaborator);
              },
            );
          });
        } else {
          return [const Text("Nenhum resultado encontrado")];
        }
      },
    );
  }
}
