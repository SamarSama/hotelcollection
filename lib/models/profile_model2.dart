class ProfileModel2 {
  ProfileModel2({
      this.address, 
      this.email,});

  ProfileModel2.fromJson(dynamic json) {
    address = json['address'];
    email = json['email'];
  }
  String? address;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['email'] = email;
    return map;
  }

}