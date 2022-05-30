import 'package:mbvv/models/accused_list_response.dart';
import 'package:mbvv/models/checkup_form_list_response.dart';
import 'package:mbvv/models/single_accused_data.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/widgets/dynamic_firno_textfield.dart';
import 'package:mbvv/widgets/dynamic_officer_form.dart';
import 'package:mbvv/widgets/dynamic_relative_form.dart';
import 'package:mbvv/widgets/dynamic_section_textfield.dart';
import 'package:mobx/mobx.dart';
part 'criminal_controller.g.dart';

class CriminalControllerMobx = _CriminalControllerMobxBase
    with _$CriminalControllerMobx;

abstract class _CriminalControllerMobxBase with Store {
  @observable
  List<DynamicRelativeForm> familyList = ObservableList();
  @observable
  List<DynamicOfficerForm> officerList = ObservableList();
  @observable
  List<DynamicFIRnoTextField> firnoList = ObservableList();
  @observable
  List<DynamicSectionTextField> sectionList = ObservableList();
  @observable
  bool showLoader = false;
  @observable
  List<Accused> accusedList = ObservableList();
  @observable
  List<CheckUpForm> checkupForm = ObservableList();
  @observable
  bool showAccusedSearchLoading = false;
  @observable
  bool showSingleAccusedLoading = false;
  @observable
  List<SingleAccusedData> singleAccusedDataList = ObservableList();
  @observable
  SingleAccusedData singleAccusedData = SingleAccusedData();
  @observable
  bool showCheckUpFormUpLoading = false;
  @observable
  bool showCheckUpHistoryUpLoading = false;
  @observable
  bool showFloatingbutton = true;
  @observable
  bool showupdateDataLoading = false;
  @observable
  int globalAccusedCount = 0;

  @action
  void updateaccusedList(List<dynamic> data, bool isGlobal) {
    accusedList.clear();
    accusedList = data.map((e) => Accused.fromJson(e)).toList();
    if (isGlobal) globalAccusedCount = accusedList.length;
    showFloatingbutton = accusedList.isNotEmpty;
  }

  @action
  void updatesingleaccusedData(List<dynamic> data) {
    singleAccusedDataList =
        data.map((e) => SingleAccusedData.fromJson(e)).toList();
    if (singleAccusedDataList.isNotEmpty) {
      singleAccusedData = singleAccusedDataList.first;
    }
  }

  @action
  void updatecheckuphistory(List<dynamic> data) {
    checkupForm.clear();
    checkupForm = data.map((e) => CheckUpForm.fromJson(e)).toList();
  }

  @action
  void addNewRelation(int index) {
    familyList.insert(
        0,
        DynamicRelativeForm(
          index: 0,
        ));
  }

  @action
  void removeRelation(int index) {
    familyList.removeAt(index);
  }

  @action
  void addNewFIR(int index) {
    firnoList.insert(
        0,
        DynamicFIRnoTextField(
          index: 0,
        ));
  }

  @action
  void removeFIR(int index) {
    firnoList.removeAt(index);
  }

  @action
  void addNewSection(int index) {
    sectionList.insert(
        0,
        DynamicSectionTextField(
          index: 0,
        ));
  }

  @action
  void removeSection(int index) {
    sectionList.removeAt(index);
  }

  @action
  void addNewOfficer(int index) {
    officerList.insert(
        0,
        DynamicOfficerForm(
          index: 0,
        ));
  }

  @action
  void removeOfficer(int index) {
    officerList.removeAt(index);
  }
}
