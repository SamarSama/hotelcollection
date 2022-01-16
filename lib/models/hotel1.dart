/// HotelName : "John Smith"
/// HotelStarsNo : 5
/// HotelGovernment : "hgjh"
/// HotelQueryPhone : "0105646446"
/// HotelAdress : "hgjh"
/// HotelImage : "hgjh"
/// HotelId : "ugudgccccjiok"

class Hotel1 {
  Hotel1({
      String? hotelName, 
      int? hotelStarsNo, 
      String? hotelGovernment, 
      String? hotelQueryPhone, 
      String? hotelAdress, 
      String? hotelImage, 
      String? hotelId,}){
    _hotelName = hotelName;
    _hotelStarsNo = hotelStarsNo;
    _hotelGovernment = hotelGovernment;
    _hotelQueryPhone = hotelQueryPhone;
    _hotelAdress = hotelAdress;
    _hotelImage = hotelImage;
    _hotelId = hotelId;
}

  Hotel1.fromJson(dynamic json) {
    _hotelName = json['HotelName'];
    _hotelStarsNo = json['HotelStarsNo'];
    _hotelGovernment = json['HotelGovernment'];
    _hotelQueryPhone = json['HotelQueryPhone'];
    _hotelAdress = json['HotelAdress'];
    _hotelImage = json['HotelImage'];
    _hotelId = json['HotelId'];
  }
  String? _hotelName;
  int? _hotelStarsNo;
  String? _hotelGovernment;
  String? _hotelQueryPhone;
  String? _hotelAdress;
  String? _hotelImage;
  String? _hotelId;

  String? get hotelName => _hotelName;
  int? get hotelStarsNo => _hotelStarsNo;
  String? get hotelGovernment => _hotelGovernment;
  String? get hotelQueryPhone => _hotelQueryPhone;
  String? get hotelAdress => _hotelAdress;
  String? get hotelImage => _hotelImage;
  String? get hotelId => _hotelId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['HotelName'] = _hotelName;
    map['HotelStarsNo'] = _hotelStarsNo;
    map['HotelGovernment'] = _hotelGovernment;
    map['HotelQueryPhone'] = _hotelQueryPhone;
    map['HotelAdress'] = _hotelAdress;
    map['HotelImage'] = _hotelImage;
    map['HotelId'] = _hotelId;
    return map;
  }

}