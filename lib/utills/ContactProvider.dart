import 'package:flutter/material.dart';
import 'Contact.dart';
import 'DatabaseHelper.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Contact> get contacts => _contacts;

  // Load contacts from database
  Future<void> loadContacts() async {
    _contacts = await _databaseHelper.getAllContacts();
    notifyListeners();
  }

  // Add new contact
  Future<void> addContact(Contact contact) async {
    await _databaseHelper.insertContact(contact);
    loadContacts();
  }

  // Update an existing contact
  Future<void> updateContact(Contact contact) async {
    await _databaseHelper.updateContact(contact);
    loadContacts();
  }

  // Delete a contact
  Future<void> deleteContact(int id) async {
    await _databaseHelper.deleteContact(id);
    loadContacts();
  }
}
