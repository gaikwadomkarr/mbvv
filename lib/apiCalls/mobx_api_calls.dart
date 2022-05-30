import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mbvv/apiCalls/api_basic_call.dart';
import 'package:mbvv/models/accused_list_response.dart';
import 'package:mbvv/screens/authentication/login.dart';
import 'package:mbvv/screens/main_screen.dart';
import 'package:mbvv/utils/controller.dart';
import 'package:mbvv/utils/data_constants.dart';
import 'package:mbvv/utils/preferences.dart';
import 'package:mbvv/utils/snackbars.dart';
import 'package:mbvv/utils/string_constants.dart';

import '../screens/criminal/add_criminal.dart';

class AllApisHandling {
  JsonEncoder json = JsonEncoder();
  Future<void> login(var data, BuildContext context) async {
    String url = loginUrl;

    DataConstants.loginController.showLoginLoader = true;
    try {
      var response = await ApiBasicCalls().getDio('json').post(url, data: data);

      log(response.data.toString());

      if (response.statusCode == 200) {
        // Preferences.saveUserLoggedIn(true);
        Preferences.saveToken(response.data["token"]);
        TOKEN = response.data["token"];
        // log(Preferences.getUserLoggedIn().toString());
        log(Preferences.getToken().toString());
        Controller.showSuccessToast1('Logged in succesfully.', context);
        var loggedIn = await Preferences.getUserLoggedIn();
        log(loggedIn.toString());
        DataConstants.loginController.showLoginLoader = false;
        Get.offAll(MainScreen());
        // return 'Accused added successfully.';
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.loginController.showLoginLoader = false;
        // return response.data["messaage"].toString();
      }
    } on DioError catch (e) {
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.loginController.showLoginLoader = false;
      // return e.response!.data["messaage"].toString();
    } finally {
      DataConstants.loginController.showLoginLoader = false;
    }
  }

  Future<String> addNewAccused(var data, BuildContext context) async {
    String url = addNewCriminal;

    DataConstants.criminalControllerMobx.showLoader = true;
    try {
      var response = await ApiBasicCalls().getDio('json').post(url, data: data);

      log(response.data.toString());

      if (response.statusCode == 200) {
        Controller.showSuccessToast1('Accused added succesfully.', context);
        DataConstants.criminalControllerMobx.showLoader = false;
        log(response.data.toString());
        Accused accused = Accused.fromJson(response.data);
        Get.off(AddEditCriminalRecord(
          accused: accused,
        ));
        getAccusedList(context, true);
        return 'Accused added successfully.';
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.criminalControllerMobx.showLoader = false;
        return response.data["messaage"].toString();
      }
    } on DioError catch (e) {
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.criminalControllerMobx.showLoader = false;
      return e.response!.data["messaage"].toString();
    } finally {
      DataConstants.criminalControllerMobx.showLoader = false;
    }
  }

  Future<void> addCheckUpForm(var data, BuildContext context, String accusedID,
      {bool fromCheckUpHistory = false}) async {
    String url = addcheckupFormUrl + accusedID;
    log(url);
    DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = true;
    if (fromCheckUpHistory) {
      Get.back();
      DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading = true;
    }
    try {
      var response = await ApiBasicCalls().getDio('json').post(url, data: data);

      log(response.data.toString());

      if (response.statusCode == 200) {
        Controller.showSuccessToast1(
            'Check-Up Information added succesfully', context);
        DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
        if (fromCheckUpHistory) {
          DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
              false;
        }
      } else {
        Get.back();
        Controller.showErrorToast(response.data["message"], context);
        log(response.data.toString());
        DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
        if (fromCheckUpHistory) {
          DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
              false;
        }
      }
    } on DioError catch (e) {
      Get.back();
      // Controller.showErrorToast(e.response!.data["message"], context);
      log(e.response!.data.toString());
      if (e.response!.data.toString().contains('JWT')) {
        Controller.showErrorToast(
            'Your session is expired. Please login again', context);
        Get.offAll(Login());
      } else {
        Controller.showErrorToast(e.response!.data["message"], context);
      }
      DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
      if (fromCheckUpHistory) {
        DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
            false;
      }
    } finally {
      DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
      if (fromCheckUpHistory) {
        DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
            false;
      }
      getAccusedCheckupHistory(context, accusedID);
    }
  }

  Future<bool?> checkUniqueid(var data, BuildContext context) async {
    String url = addNewCriminal + '/check-unique-identification';
    log(url);
    DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = true;
    try {
      var response = await ApiBasicCalls().getDio('json').post(url, data: data);

      log(response.data.toString());

      if (response.statusCode == 200) {
        DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
        return true;
      } else {
        Controller.showErrorToast(response.data["message"], context);
        log(response.data.toString());
        DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
        return false;
      }
    } on DioError catch (e) {
      // Controller.showErrorToast(e.response!.data["message"], context);
      log(e.response!.data.toString());
      if (e.response!.data.toString().contains('JWT')) {
        // Controller.showErrorToast(
        //     'Your session is expired. Please login again', context);
        Get.showSnackbar(
            errorSnackBar('Your session is expired. Please login again'));
        Get.offAll(Login());
      } else {
        // Controller.showErrorToast(e.response!.data["message"], context);
        Get.showSnackbar(errorSnackBar(e.response!.data["message"]));
      }
      DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
      return false;
    } finally {
      DataConstants.criminalControllerMobx.showCheckUpFormUpLoading = false;
    }
  }

  Future<void> updateAccused(
      var data, BuildContext context, String accusedID) async {
    String url = addNewCriminal + '/$accusedID';
    log(url);
    DataConstants.criminalControllerMobx.showupdateDataLoading = true;
    try {
      var response = await ApiBasicCalls().getDio('json').put(url, data: data);

      log(response.data.toString());

      if (response.statusCode == 200) {
        Get.back();
        Controller.showSuccessToast1('Record updated succesfully', context);
        DataConstants.criminalControllerMobx.showupdateDataLoading = false;
        // Get.back();
        getSingleAccused(context, accusedID);
      } else {
        Controller.showErrorToast(response.data["message"], context);
        log(response.data.toString());
        DataConstants.criminalControllerMobx.showupdateDataLoading = false;
      }
    } on DioError catch (e) {
      Controller.showErrorToast(e.response!.data["message"], context);
      log(e.response!.data.toString());
      DataConstants.criminalControllerMobx.showupdateDataLoading = false;
    } finally {
      DataConstants.criminalControllerMobx.showupdateDataLoading = false;
    }
  }

  Future<void> getAccusedList(BuildContext context, bool isGlobal) async {
    String url = addNewCriminal;

    DataConstants.criminalControllerMobx.showAccusedSearchLoading = true;
    try {
      var response = await ApiBasicCalls().getDio('json').get(url);

      log(response.data.toString());

      if (response.statusCode == 200) {
        DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
        DataConstants.criminalControllerMobx
            .updateaccusedList(response.data, isGlobal);
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
    } finally {
      DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
    }
  }

  Future<void> getSingleAccused(BuildContext context, String id) async {
    String url = addNewCriminal + '/$id';

    DataConstants.criminalControllerMobx.showSingleAccusedLoading = true;
    try {
      var response = await ApiBasicCalls().getDio('json').get(url);

      log(response.data.toString());

      if (response.statusCode == 200) {
        DataConstants.criminalControllerMobx.showSingleAccusedLoading = false;
        DataConstants.criminalControllerMobx
            .updatesingleaccusedData(response.data);
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.criminalControllerMobx.showSingleAccusedLoading = false;
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.criminalControllerMobx.showSingleAccusedLoading = false;
    } finally {
      DataConstants.criminalControllerMobx.showSingleAccusedLoading = false;
    }
  }

  Future<void> getAccusedCheckupHistory(
      BuildContext context, String accusedId) async {
    String url = checkuphistroyUrl + accusedId;
    DataConstants.criminalControllerMobx.checkupForm.clear();

    DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading = true;
    try {
      var response = await ApiBasicCalls().getDio('json').get(url);

      log(response.data.toString());
      log(jsonEncode(response.data));
      if (response.statusCode == 200) {
        DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
            false;
        DataConstants.criminalControllerMobx
            .updatecheckuphistory(response.data);
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading =
            false;
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading = false;
    } finally {
      DataConstants.criminalControllerMobx.showCheckUpHistoryUpLoading = false;
    }
  }

  Future<void> getProfile(BuildContext context) async {
    String url = profileUrl;

    DataConstants.loginController.showViewProfileLoader = true;
    try {
      var response = await ApiBasicCalls().getDio('json').get(url);

      log(response.data.toString());

      if (response.statusCode == 200) {
        DataConstants.loginController.showViewProfileLoader = false;
        DataConstants.loginController.updateProfile(response.data);
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.loginController.showViewProfileLoader = false;
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
      if (e.response != null) {
        if (e.response!.data['message'].toString().contains('jwt')) {
          Controller.showErrorToast(
              'Session expired, please login again', context);
          Get.offAll(Login());
        } else {
          Controller.showErrorToast(e.response!.data["message"], context);
        }
      } else {
        Controller.showErrorToast(e.response!.data["message"], context);
      }
      DataConstants.loginController.showViewProfileLoader = false;
    } finally {
      DataConstants.loginController.showViewProfileLoader = false;
    }
  }

  Future<void> searchaccused(BuildContext context, String name) async {
    String url = searchaccusedUrl + name;

    DataConstants.criminalControllerMobx.showAccusedSearchLoading = true;
    try {
      var response = await ApiBasicCalls().getDio('json').get(url);

      log(response.data.toString());

      if (response.statusCode == 200) {
        DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
        DataConstants.criminalControllerMobx
            .updateaccusedList(response.data, false);
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
      }
    } on DioError catch (e) {
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
    } finally {
      DataConstants.criminalControllerMobx.showAccusedSearchLoading = false;
    }
  }

  Future<String> uploadfile(var data, BuildContext context) async {
    String url = uploadFile;
    DataConstants.criminalControllerMobx.showLoader = true;
    try {
      var response =
          await ApiBasicCalls().getDio('formdata').post(url, data: data);

      log(response.data.toString());

      if (response.statusCode == 200) {
        Controller.showSuccessToast1(response.data["message"], context);
        DataConstants.criminalControllerMobx.showLoader = false;
        return response.data["location"][0];
      } else {
        Controller.showErrorToast(response.data["message"], context);
        DataConstants.criminalControllerMobx.showLoader = false;
        return response.data["messaage"].toString();
      }
    } on DioError catch (e) {
      log(e.response!.data["message"]);
      Controller.showErrorToast(e.response!.data["message"], context);
      DataConstants.criminalControllerMobx.showLoader = false;
      return e.response!.data["messaage"].toString();
    } finally {
      DataConstants.criminalControllerMobx.showLoader = false;
    }
  }
}
