import 'package:certify/shared/models/worker/worker_model.dart';
import 'package:certify/shared/routes/app_routes.dart';
import 'package:certify/shared/services/worker/worker_service.dart';
import 'package:certify/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchSuggestionBar extends StatefulWidget {
  const SearchSuggestionBar({super.key});

  @override
  State<SearchSuggestionBar> createState() => _SearchSuggestionBarState();
}

class _SearchSuggestionBarState extends State<SearchSuggestionBar> {
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
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          hintStyle: const MaterialStatePropertyAll(TextStyle(color: AppColors.fontOnSurface)),
          hintText: "Nome ou matrícula",
          trailing: const <Widget>[
            Icon(Icons.search),
          ],
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
        List<Worker>? suggestions = await WorkerService.findAll();

        if (suggestions != null && suggestions.isNotEmpty) {
          return suggestions.map((user) {
            final Widget userImage = user.image != null
                ? const Text("IM")
                : Text(
                    user.getInitials(),
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
              title: Text(user.name),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.worker, arguments: user);
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
