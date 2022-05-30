class UserProfile {
  String? sId;
  String? firstName;
  String? lastName;
  String? timezone;
  String? email;
  String? username;
  String? displayName;
  String? profileImageURL;
  List<String>? roles;
  String? isFromDepartment;
  String? department;
  bool? lock;

  UserProfile(
      {this.sId,
      this.firstName,
      this.lastName,
      this.timezone,
      this.email,
      this.username,
      this.displayName,
      this.profileImageURL,
      this.roles,
      this.isFromDepartment,
      this.department,
      this.lock});

  UserProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    timezone = json['timezone'];
    email = json['email'];
    username = json['username'];
    displayName = json['displayName'];
    profileImageURL = json['profileImageURL'];
    roles = json['roles'].cast<String>();
    isFromDepartment = json['isFromDepartment'];
    department = json['department'];
    lock = json['lock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['timezone'] = timezone;
    data['email'] = email;
    data['username'] = username;
    data['displayName'] = displayName;
    data['profileImageURL'] = profileImageURL;
    data['roles'] = roles;
    data['isFromDepartment'] = isFromDepartment;
    data['department'] = department;
    data['lock'] = lock;
    return data;
  }
}
