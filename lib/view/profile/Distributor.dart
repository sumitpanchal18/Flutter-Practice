class Distributor {
  String fullName;
  String distributorId; // Store as String
  String binaryRank;
  String unilevelRank;
  String sponsorName;
  String sponsorId;
  String placementName;
  String enrollmentDate;
  String last_order_date;
  String mobile;
  String email;
  String distributorWebsite;
  List<Address> billing;
  List<Address> shipping;
  String id;
  int distributorIdNumber;
  String firstName;
  String lastName;
  String storeCountryName;
  String replicatedSite;

  Distributor({
    required this.fullName,
    required this.distributorId,
    required this.binaryRank,
    required this.sponsorName,
    required this.unilevelRank,
    required this.sponsorId,
    required this.placementName,
    required this.enrollmentDate,
    required this.last_order_date,
    required this.mobile,
    required this.email,
    required this.distributorWebsite,
    required this.billing,
    required this.shipping,
    required this.id,
    required this.distributorIdNumber,
    required this.firstName,
    required this.lastName,
    required this.storeCountryName,
    required this.replicatedSite,
  });

  // Factory method to create a Distributor from a map
  factory Distributor.fromMap(Map<String, dynamic> map) {
    return Distributor(
      fullName: '${map['first_name']} ${map['last_name']}', // Combine first and last name
      distributorId: map['distributorId'] != null ? map['distributorId'].toString() : '', // Convert int to String if needed
      binaryRank: map['binaryRank'] != null ? map['binaryRank'].toString() : '',
      unilevelRank: map['unilevelRank'] != null ? map['unilevelRank'].toString() : '',
      sponsorName: map['sponsorName'] ?? '',
      placementName: map['placementName'] ?? '',
      enrollmentDate: map['enrollmentDate'] ?? '',
      sponsorId: map['sponsorId']?.toString() ?? '',
      last_order_date: map['last_order_date'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      distributorWebsite: map['replicated_site'] ?? '',
      billing: List<Address>.from(map['billing']?.map((x) => Address.fromMap(x)) ?? []),
      shipping: List<Address>.from(map['shipping']?.map((x) => Address.fromMap(x)) ?? []),
      id: map['_id'],
      distributorIdNumber: map['distributorId'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      storeCountryName: map['storeCountryName'],
      replicatedSite: map['replicated_site'],
    );
  }
}

class Address {
  String address1;
  String address2;
  String city;
  String company;
  String postcode;
  String state;
  String country;

  Address({
    required this.address1,
    required this.address2,
    required this.city,
    required this.company,
    required this.postcode,
    required this.state,
    required this.country,
  });

  // Factory method to create an Address from a map
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address1: map['address_1'] ?? '',
      address2: map['address_2'] ?? '',
      state: map['state_name'] ?? '',
      company: map['company'] ?? '',
      postcode: map['postcode'] ?? '',
      city: map['city'] ?? '',
      country: map['country_name'] ?? '',
    );
  }
}
