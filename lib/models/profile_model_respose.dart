class ProfileModelRespose {
  ProfileModelRespose({
      this.address, 
      this.email, 
      this.imgUrl, 
      this.mobile, 
      this.name,});

  ProfileModelRespose.fromJson(dynamic json) {
    address = json['address'];
    email = json['email'];
    imgUrl = json['img_url'];
    mobile = json['mobile'];
    name = json['name'];
  }
  String? address;
  String? email;
  String? imgUrl;
  String? mobile;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['email'] = email;
    map['img_url'] = imgUrl;
    map['mobile'] = mobile;
    map['name'] = name;
    return map;
  }

}
