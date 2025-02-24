class LocationModel {
  final String id;
  final String type;
  final String location;
  final bool isDefault;

  LocationModel({
    required this.id,
    required this.type,
    required this.location,
    required this.isDefault,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      type: json['type'],
      location: json['location'],
      isDefault: json['is_default'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "location": location,
      "is_default": isDefault ? 1 : 0,
    };
  }
}

class AddLocationRequest {
  final String location;
  final String addressUnit;
  final String apartmentUnit;
  final String pincode;
  final String type;
  final bool? isDefault;

  AddLocationRequest({
    required this.location,
    required this.addressUnit,
    required this.apartmentUnit,
    required this.pincode,
    required this.type,
    this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      "location": location,
      "address_unit": addressUnit,
      "apartment_unit": apartmentUnit,
      "pincode": pincode,
      "type": type,
      if (isDefault != null) "is_default": isDefault! ? 1 : 0,
    };
  }
}
