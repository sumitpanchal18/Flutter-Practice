import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utills/Contact.dart';
import '../utills/ContactProvider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: Consumer<ContactProvider>(
        builder: (context, provider, _) {
          if (provider.contacts.isEmpty) {
            return Center(child: Text('No contacts available'));
          }
          return ListView.builder(
            itemCount: provider.contacts.length,
            itemBuilder: (context, index) {
              final contact = provider.contacts[index];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteContact(contact.id!);
                  },
                ),
                onTap: () {
                  // Navigate to update screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateContactScreen(contact: contact),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add contact screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final contact = Contact(
                  name: _nameController.text,
                  phone: _phoneController.text,
                );
                Provider.of<ContactProvider>(context, listen: false).addContact(contact);
                Navigator.pop(context);
              },
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;
  UpdateContactScreen({required this.contact});

  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contact.name;
    _phoneController.text = widget.contact.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedContact = Contact(
                  id: widget.contact.id,
                  name: _nameController.text,
                  phone: _phoneController.text,
                );
                Provider.of<ContactProvider>(context, listen: false).updateContact(updatedContact);
                Navigator.pop(context);
              },
              child: Text('Update Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
