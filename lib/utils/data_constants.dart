import 'package:mbvv/apiCalls/mobx_api_calls.dart';
import 'package:mbvv/controllers/criminal_controller.dart';
import 'package:mbvv/controllers/login_controller.dart';
import 'package:mbvv/widgets/dynamic_relative_form.dart';

class DataConstants {
  static List<DynamicRelativeForm> familylist = [];
  static CriminalControllerMobx criminalControllerMobx =
      CriminalControllerMobx();
  static AllApisHandling allApisHandling = AllApisHandling();
  static LoginController loginController = LoginController();
  static int globalAccusedCount = 0;
  static String uniqueId = "";
}
