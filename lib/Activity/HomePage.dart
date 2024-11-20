import 'package:flutter/material.dart';
import '../utills/DatabaseHelper.dart';
import 'AddContact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List to hold contacts from the database
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();  // Load contacts from database when the page is first loaded
  }

  // Load contacts from the database
  Future<void> _loadContacts() async {
    final dbContacts = await DatabaseHelper.instance.getContacts();
    setState(() {
      contacts = dbContacts;  // Update the contacts list after fetching from database
    });
  }

  // Function to navigate to AddContact page and get the new contact data
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Wait for the AddContact page to return data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddContact()),
    );

    // If data is returned, insert it into the database and update the UI
    if (result != null) {
      await DatabaseHelper.instance.insertContact(result);
      _loadContacts();  // Refresh contacts list from the database
    }
  }

  // Function to delete a contact
  Future<void> _deleteContact(int id, int index) async {
    await DatabaseHelper.instance.deleteContact(id);
    setState(() {
      contacts.removeAt(index); // Remove the contact from the list
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contact deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: contacts.isEmpty
          ? const Center(child: Text('No contacts available'))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          // Use Dismissible to enable swipe-to-delete
          return Dismissible(
            key: Key(contact['id'].toString()), // Unique key for each item
            direction: DismissDirection.endToStart, // Only allow swipe to the right
            onDismissed: (direction) {
              _deleteContact(contact['id'], index);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(contact['name'] ?? ''),
                subtitle: Text('${contact['email']}\n${contact['phone']}'),
                isThreeLine: true,
                trailing: Text(contact['website'] ?? ''),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndDisplaySelection(context),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
