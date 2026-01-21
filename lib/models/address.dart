class Address {
  final String id;
  final String name;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String phone;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.phone,
    required this.isDefault,
  });

  String get fullAddress => '$street, $city, $state $zipCode, $country';
}
