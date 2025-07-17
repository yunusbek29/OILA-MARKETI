class UserModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final String phone;
  final Name name;
  final Address address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      name: Name.fromJson(json['name']),
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'name': name.toJson(),
      'address': address.toJson(),
    };
  }
}

class Name {
  final String firstname;
  final String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocation geolocation;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      geolocation: GeoLocation.fromJson(json['geolocation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': geolocation.toJson(),
    };
  }
}

class GeoLocation {
  final String lat;
  final String long;
  

  GeoLocation({
    required this.lat,
    required this.long,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}
