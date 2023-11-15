import 'package:certify/app/worker/page/worker_page.dart';
import 'package:certify/shared/forgot_password/page/forgot_password_page.dart';
import 'package:certify/shared/routes/app_routes.dart';
import 'package:certify/shared/routes/web_routes.dart';
import 'package:certify/web/collaborator/new/new_collaborator_page.dart';
import 'package:certify/web/collaborator_training/new/new_collaborator_training.dart';
import 'package:certify/web/collaborator_trainings/page/collaborator_trainings_page.dart';
import 'package:certify/web/collaborators/page/collaborators_page.dart';
import 'package:certify/web/dashboard/page/dashboard_page.dart';
import 'package:certify/web/staff/new/new_staff_page.dart';
import 'package:certify/web/staffs/page/staffs_page.dart';
import 'package:certify/web/training/new/new_training_page.dart';
import 'package:certify/web/trainings/page/trainings_page.dart';
import 'package:flutter/cupertino.dart';

import '../../app/home/page/home_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> all = {
    AppRoutes.forgotPassword: (BuildContext context) {
      return ForgotPasswordPage();
    },
    AppRoutes.home: (BuildContext context) {
      return const HomePage();
    },
    AppRoutes.worker: (BuildContext context) {
      return const WorkerPage();
    },
    WebRoutes.dashboard: (BuildContext context) {
      return const DashboardPage();
    },
    WebRoutes.staffs: (BuildContext context) {
      return const StaffsPage();
    },
    WebRoutes.newStaff: (BuildContext context) {
      return const NewStaffPage();
    },
    WebRoutes.collaborators: (BuildContext context) {
      return const CollaboratorsPage();
    },
    WebRoutes.newCollaborator: (BuildContext context) {
      return const NewCollaboratorPage();
    },
    WebRoutes.trainings: (BuildContext context) {
      return const TrainingsPage();
    },
    WebRoutes.newTraining: (BuildContext context) {
      return const NewTrainingPage();
    },
    WebRoutes.collaboratorTrainings: (BuildContext context) {
      return const CollaboratorTrainingsPage();
    },
    WebRoutes.newCollaboratorTraining: (BuildContext context) {
      return const NewCollaboratorTrainingPage();
    }
  };
}
