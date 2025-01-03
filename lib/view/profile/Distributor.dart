class Distributor {
  final String fullName;
  final String distributorId; // Store as String
  final String binaryRank;
  final String unilevelRank;
  final String sponsorName;
  final String sponsorId;
  final String placementName;
  final String enrollmentDate;
  final String last_order_date;
  final String mobile;
  final String email;
  final String distributorWebsite;
  final List<Address> billing;
  final List<Address> shipping;
  final String id;
  final int distributorIdNumber;
  final String firstName;
  final String lastName;
  final String storeCountryName;
  final String replicatedSite;

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
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String state;
  final String country;

  Address({
    required this.address1,
    required this.address2,
    required this.city,
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
      postcode: map['postcode'] ?? '',
      city: map['city'] ?? '',
      country: map['country_name'] ?? '',
    );
  }
}
