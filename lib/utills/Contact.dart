

class Contact {
  int? id;
  String name;
  String phone;

  Contact({this.id, required this.name, required this.phone});

  // Convert Contact to Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  // Convert Map to Contact
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}
