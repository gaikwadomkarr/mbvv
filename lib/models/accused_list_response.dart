class Accused {
  String? sId;
  String? criminalFullName;
  List<String>? criminalAddress;
  List<String>? roles;
  String? criminalGender;
  String? criminalAliasName;
  List<String>? criminalMobileNo;
  String? criminalPassportNo;
  String? criminalBankAccNo;
  String? criminalPanCardNo;
  String? criminalAadharIdNo;
  String? criminalDOB;
  String? criminalElectionId;
  String? createdAt;
  List<String>? modusOperandi;
  List<String>? criminalPhoto;
  CurrentlyUsedVehicles? currentlyUsedVehicles;
  List<CurrentJobDetails>? currentJobDetails;
  List<Relations>? relations;

  Accused(
      {this.sId,
      this.criminalFullName,
      this.criminalAddress,
      this.roles,
      this.criminalGender,
      this.criminalAliasName,
      this.criminalMobileNo,
      this.criminalPassportNo,
      this.criminalBankAccNo,
      this.criminalPanCardNo,
      this.criminalElectionId,
      this.createdAt,
      this.modusOperandi,
      this.criminalPhoto,
      this.currentlyUsedVehicles,
      this.criminalAadharIdNo,
      this.criminalDOB,
      this.currentJobDetails,
      this.relations});

  Accused.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    criminalFullName = json['criminalFullName'];
    criminalAddress = json['criminalAddress'].cast<String>();
    roles = json['roles'].cast<String>();
    criminalGender = json['criminalGender'];
    criminalAliasName = json['criminalAliasName'];
    criminalMobileNo = json['criminalMobileNo'].cast<String>();
    criminalPassportNo = json['criminalPassportNo'];
    criminalBankAccNo = json['criminalBankAccNo'];
    criminalPanCardNo = json['criminalPanCardNo'];
    criminalElectionId = json['criminalElectionId'];
    createdAt = json['createdAt'];
    criminalAadharIdNo = json['criminalAadharIdNo'];
    criminalDOB = json['criminalDOB'];
    modusOperandi = json['modusOperandi'].cast<String>();
    criminalPhoto = json['criminalPhoto'].cast<String>();
    currentlyUsedVehicles = json['currentlyUsedVehicles'] != null
        ? CurrentlyUsedVehicles.fromJson(json['currentlyUsedVehicles'])
        : null;
    if (json['currentJobDetails'] != null) {
      currentJobDetails = <CurrentJobDetails>[];
      json['currentJobDetails'].forEach((v) {
        currentJobDetails!.add(CurrentJobDetails.fromJson(v));
      });
    }
    if (json['relations'] != null) {
      relations = <Relations>[];
      json['relations'].forEach((v) {
        relations!.add(Relations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['criminalFullName'] = criminalFullName;
    data['criminalAddress'] = criminalAddress;
    data['roles'] = roles;
    data['criminalGender'] = criminalGender;
    data['criminalAliasName'] = criminalAliasName;
    data['criminalMobileNo'] = criminalMobileNo;
    data['criminalPassportNo'] = criminalPassportNo;
    data['criminalBankAccNo'] = criminalBankAccNo;
    data['criminalPanCardNo'] = criminalPanCardNo;
    data['criminalElectionId'] = criminalElectionId;
    data['createdAt'] = createdAt;
    data['modusOperandi'] = modusOperandi;
    data['criminalPhoto'] = criminalPhoto;
    data['criminalAadharIdNo'] = criminalAadharIdNo;
    data['criminalDOB'] = criminalDOB;
    if (currentlyUsedVehicles != null) {
      data['currentlyUsedVehicles'] = currentlyUsedVehicles!.toJson();
    }
    if (currentJobDetails != null) {
      data['currentJobDetails'] =
          currentJobDetails!.map((v) => v.toJson()).toList();
    }
    if (relations != null) {
      data['relations'] = relations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentlyUsedVehicles {
  String? vehicleType;
  String? vehicleNo;

  CurrentlyUsedVehicles({this.vehicleType, this.vehicleNo});

  CurrentlyUsedVehicles.fromJson(Map<String, dynamic> json) {
    vehicleType = json['vehicleType'];
    vehicleNo = json['vehicleNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleType'] = vehicleType;
    data['vehicleNo'] = vehicleNo;
    return data;
  }
}

class CurrentJobDetails {
  String? jobProfile;
  String? companyName;

  CurrentJobDetails({this.jobProfile, this.companyName});

  CurrentJobDetails.fromJson(Map<String, dynamic> json) {
    jobProfile = json['jobProfile'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobProfile'] = this.jobProfile;
    data['companyName'] = this.companyName;
    return data;
  }
}

class Relations {
  String? sId;
  String? relationWithAccused;
  String? name;
  String? mobileNo;
  String? address;
  String? accusedId;
  int? iV;

  Relations(
      {this.sId,
      this.relationWithAccused,
      this.name,
      this.mobileNo,
      this.address,
      this.accusedId,
      this.iV});

  Relations.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    relationWithAccused = json['relationWithAccused'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    accusedId = json['accusedId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['relationWithAccused'] = this.relationWithAccused;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['accusedId'] = this.accusedId;
    data['__v'] = this.iV;
    return data;
  }
}
