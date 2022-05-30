class CheckUpForm {
  String? sId;
  CheckedBy? checkedBy;
  String? accusedId;
  AccusedInfo? accusedInfo;
  String? policeStation;
  double? long;
  double? lat;
  DateTime? createdAt;
  ConsumptionOrInfluenceOfNDPSDrugs? consumptionOrInfluenceOfNDPSDrugs;
  bool? isAccusedCarryingHarmfulWeapon;
  List<OfficerOrPolicemanKnowingAccused>? officerOrPolicemanKnowingAccused;
  CurrentlyUsedVehicleDetails? currentlyUsedVehicleDetails;
  CurrentJobDetails? currentJobDetails;
  List<String>? crimeSection;
  DeportedAccused? deportedAccused;
  List<String>? firstInformationReport;
  List<Relations>? relations;

  CheckUpForm(
      {this.sId,
      this.checkedBy,
      this.accusedId,
      this.accusedInfo,
      this.policeStation,
      this.long,
      this.lat,
      this.createdAt,
      this.consumptionOrInfluenceOfNDPSDrugs,
      this.officerOrPolicemanKnowingAccused,
      this.currentlyUsedVehicleDetails,
      this.isAccusedCarryingHarmfulWeapon,
      this.currentJobDetails,
      this.crimeSection,
      this.deportedAccused,
      this.firstInformationReport,
      this.relations});

  CheckUpForm.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    checkedBy = json['checkedBy'] != null
        ? new CheckedBy.fromJson(json['checkedBy'])
        : null;
    accusedId = json['accusedId'];
    accusedInfo = json['accusedInfo'] != null
        ? new AccusedInfo.fromJson(json['accusedInfo'])
        : null;
    policeStation = json['policeStation'];
    long = json['long'];
    lat = json['lat'];
    isAccusedCarryingHarmfulWeapon = json['isAccusedCarryingHarmfulWeapon'];
    createdAt = DateTime.parse(json['createdAt']);
    consumptionOrInfluenceOfNDPSDrugs =
        json['consumptionOrInfluenceOfNDPSDrugs'] != null
            ? new ConsumptionOrInfluenceOfNDPSDrugs.fromJson(
                json['consumptionOrInfluenceOfNDPSDrugs'])
            : null;
    if (json['officerOrPolicemanKnowingAccused'] != null) {
      officerOrPolicemanKnowingAccused = <OfficerOrPolicemanKnowingAccused>[];
      json['officerOrPolicemanKnowingAccused'].forEach((v) {
        officerOrPolicemanKnowingAccused!
            .add(new OfficerOrPolicemanKnowingAccused.fromJson(v));
      });
    }
    currentlyUsedVehicleDetails = json['currentlyUsedVehicleDetails'] != null
        ? new CurrentlyUsedVehicleDetails.fromJson(
            json['currentlyUsedVehicleDetails'])
        : null;
    currentJobDetails = json['currentJobDetails'] != null
        ? new CurrentJobDetails.fromJson(json['currentJobDetails'])
        : null;
    crimeSection = json['crimeSection'].cast<String>();
    deportedAccused = json['deportedAccused'] != null
        ? new DeportedAccused.fromJson(json['deportedAccused'])
        : null;
    firstInformationReport = json['firstInformationReport'].cast<String>();
    if (json['relations'] != null) {
      relations = <Relations>[];
      json['relations'].forEach((v) {
        relations!.add(new Relations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkedBy != null) {
      data['checkedBy'] = checkedBy!.toJson();
    }
    data['accusedId'] = accusedId;
    if (this.accusedInfo != null) {
      data['accusedInfo'] = accusedInfo!.toJson();
    }
    data['policeStation'] = policeStation;
    data['long'] = long;
    data['lat'] = lat;
    data["isAccusedCarryingHarmfulWeapon"] = isAccusedCarryingHarmfulWeapon;
    if (consumptionOrInfluenceOfNDPSDrugs != null) {
      data['consumptionOrInfluenceOfNDPSDrugs'] =
          consumptionOrInfluenceOfNDPSDrugs!.toJson();
    }
    if (officerOrPolicemanKnowingAccused != null) {
      data['officerOrPolicemanKnowingAccused'] = this
          .officerOrPolicemanKnowingAccused!
          .map((v) => v.toJson())
          .toList();
    }
    if (currentlyUsedVehicleDetails != null) {
      data['currentlyUsedVehicleDetails'] =
          currentlyUsedVehicleDetails!.toJson();
    }
    if (currentJobDetails != null) {
      data['currentJobDetails'] = currentJobDetails!.toJson();
    }
    data['crimeSection'] = crimeSection;
    if (deportedAccused != null) {
      data['deportedAccused'] = deportedAccused!.toJson();
    }
    data['firstInformationReport'] = firstInformationReport;
    if (relations != null) {
      data['relations'] = relations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckedBy {
  String? sId;
  String? displayName;
  String? isFromDepartment;
  String? department;
  String? username;

  CheckedBy(
      {this.sId,
      this.displayName,
      this.isFromDepartment,
      this.department,
      this.username});

  CheckedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['displayName'];
    isFromDepartment = json['isFromDepartment'];
    department = json['department'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['displayName'] = this.displayName;
    data['isFromDepartment'] = this.isFromDepartment;
    data['department'] = this.department;
    data['username'] = this.username;
    return data;
  }
}

class AccusedInfo {
  String? sId;
  List<String>? criminalPhoto;
  List<String>? criminalAddress;
  List<String>? criminalMobileNo;
  List<String>? modusOperandi;
  List<String>? roles;
  List<CurrentJobDetails>? currentJobDetails;
  String? criminalFullName;
  String? criminalGender;
  String? criminalAliasName;
  String? criminalPassportNo;
  String? criminalBankAccNo;
  String? criminalPanCardNo;
  String? criminalElectionId;
  CurrentlyUsedVehicleDetails? currentlyUsedVehicleDetails;
  String? createdAt;
  int? iV;

  AccusedInfo(
      {this.sId,
      this.criminalPhoto,
      this.criminalAddress,
      this.criminalMobileNo,
      this.modusOperandi,
      this.roles,
      this.currentJobDetails,
      this.criminalFullName,
      this.criminalGender,
      this.criminalAliasName,
      this.criminalPassportNo,
      this.criminalBankAccNo,
      this.criminalPanCardNo,
      this.criminalElectionId,
      this.currentlyUsedVehicleDetails,
      this.createdAt,
      this.iV});

  AccusedInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    criminalPhoto = json['criminalPhoto'].cast<String>();
    criminalAddress = json['criminalAddress'].cast<String>();
    criminalMobileNo = json['criminalMobileNo'].cast<String>();
    modusOperandi = json['modusOperandi'].cast<String>();
    roles = json['roles'].cast<String>();
    if (json['currentJobDetails'] != null) {
      currentJobDetails = <CurrentJobDetails>[];
      json['currentJobDetails'].forEach((v) {
        currentJobDetails!.add(new CurrentJobDetails.fromJson(v));
      });
    }
    criminalFullName = json['criminalFullName'];
    criminalGender = json['criminalGender'];
    criminalAliasName = json['criminalAliasName'];
    criminalPassportNo = json['criminalPassportNo'];
    criminalBankAccNo = json['criminalBankAccNo'];
    criminalPanCardNo = json['criminalPanCardNo'];
    criminalElectionId = json['criminalElectionId'];
    currentlyUsedVehicleDetails = json['currentlyUsedVehicleDetails'] != null
        ? new CurrentlyUsedVehicleDetails.fromJson(
            json['currentlyUsedVehicleDetails'])
        : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['criminalPhoto'] = this.criminalPhoto;
    data['criminalAddress'] = this.criminalAddress;
    data['criminalMobileNo'] = this.criminalMobileNo;
    data['modusOperandi'] = this.modusOperandi;
    data['roles'] = this.roles;
    if (this.currentJobDetails != null) {
      data['currentJobDetails'] =
          this.currentJobDetails!.map((v) => v.toJson()).toList();
    }
    data['criminalFullName'] = this.criminalFullName;
    data['criminalGender'] = this.criminalGender;
    data['criminalAliasName'] = this.criminalAliasName;
    data['criminalPassportNo'] = this.criminalPassportNo;
    data['criminalBankAccNo'] = this.criminalBankAccNo;
    data['criminalPanCardNo'] = this.criminalPanCardNo;
    data['criminalElectionId'] = this.criminalElectionId;
    if (this.currentlyUsedVehicleDetails != null) {
      data['currentlyUsedVehicleDetails'] =
          this.currentlyUsedVehicleDetails!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ConsumptionOrInfluenceOfNDPSDrugs {
  String? drugsConsumed;
  String? doesCriminalConsumesDrugs;

  ConsumptionOrInfluenceOfNDPSDrugs(
      {this.drugsConsumed, this.doesCriminalConsumesDrugs});

  ConsumptionOrInfluenceOfNDPSDrugs.fromJson(Map<String, dynamic> json) {
    drugsConsumed = json['drugsConsumed'];
    doesCriminalConsumesDrugs = json['doesCriminalConsumesDrugs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drugsConsumed'] = this.drugsConsumed;
    data['doesCriminalConsumesDrugs'] = this.doesCriminalConsumesDrugs;
    return data;
  }
}

class OfficerOrPolicemanKnowingAccused {
  String? policeStationOrBranch;
  String? department;
  String? isFromDepartment;

  String? officerOrPolicemanMobileNo;
  String? officerOrPolicemanName;
  String? relationWithAccused;

  OfficerOrPolicemanKnowingAccused(
      {this.policeStationOrBranch,
      this.department,
      this.isFromDepartment,
      this.officerOrPolicemanMobileNo,
      this.officerOrPolicemanName,
      this.relationWithAccused});

  OfficerOrPolicemanKnowingAccused.fromJson(Map<String, dynamic> json) {
    policeStationOrBranch = json['policeStationOrBranch'];
    department = json['department'];
    isFromDepartment = json['isFromDepartment'];
    officerOrPolicemanMobileNo = json['officerOrPolicemanMobileNo'];
    officerOrPolicemanName = json['officerOrPolicemanName'];
    relationWithAccused = json['relationWithAccused'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['policeStationOrBranch'] = policeStationOrBranch;
    data['department'] = department;
    data['isFromDepartment'] = isFromDepartment;
    data['officerOrPolicemanMobileNo'] = officerOrPolicemanMobileNo;
    data['officerOrPolicemanName'] = officerOrPolicemanName;
    data['relationWithAccused'] = relationWithAccused;
    return data;
  }
}

class CurrentlyUsedVehicleDetails {
  String? vehicleType;
  String? vehicleNo;

  CurrentlyUsedVehicleDetails({this.vehicleType, this.vehicleNo});

  CurrentlyUsedVehicleDetails.fromJson(Map<String, dynamic> json) {
    vehicleType = json['vehicleType'];
    vehicleNo = json['vehicleNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleType'] = this.vehicleType;
    data['vehicleNo'] = this.vehicleNo;
    return data;
  }
}

class CurrentJobDetails {
  String? companyLocation;
  String? companyName;
  String? companyOwnerName;

  CurrentJobDetails(
      {this.companyLocation, this.companyName, this.companyOwnerName});

  CurrentJobDetails.fromJson(Map<String, dynamic> json) {
    companyLocation = json['companyLocation'];
    companyName = json['companyName'];
    companyOwnerName = json['companyOwnerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyLocation'] = this.companyLocation;
    data['companyName'] = this.companyName;
    data['companyOwnerName'] = this.companyOwnerName;
    return data;
  }
}

class Relations {
  String? sId;
  String? checkupFormId;
  String? accusedId;
  String? relationWithAccused;
  String? name;
  String? mobileNo;
  String? address;
  int? iV;

  Relations(
      {this.sId,
      this.checkupFormId,
      this.accusedId,
      this.relationWithAccused,
      this.name,
      this.mobileNo,
      this.address,
      this.iV});

  Relations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    checkupFormId = json['checkupFormId'];
    accusedId = json['accusedId'];
    relationWithAccused = json['relationWithAccused'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['checkupFormId'] = this.checkupFormId;
    data['accusedId'] = this.accusedId;
    data['relationWithAccused'] = this.relationWithAccused;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['__v'] = this.iV;
    return data;
  }
}

class DeportedAccused {
  bool? isAccusedDeported;
  String? orderNo;
  DateTime? fromDate;
  DateTime? toDate;

  DeportedAccused(
      {this.isAccusedDeported, this.orderNo, this.fromDate, this.toDate});

  DeportedAccused.fromJson(Map<String, dynamic> json) {
    isAccusedDeported = json['isAccusedDeported'];
    orderNo = json['orderNo'];
    fromDate =
        json["fromDate"] != null ? DateTime.parse(json['fromDate']) : null;
    toDate = json["toDate"] != null ? DateTime.parse(json['toDate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAccusedDeported'] = this.isAccusedDeported;
    data['orderNo'] = this.orderNo;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
