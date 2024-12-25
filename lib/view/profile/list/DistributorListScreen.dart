import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../DistributorProfilePage.dart';

class DistributorListScreen extends StatefulWidget {
  @override
  _DistributorListScreenState createState() => _DistributorListScreenState();
}

class _DistributorListScreenState extends State<DistributorListScreen> {
  bool _isLoading = true;
  List<dynamic> _distributors = [];

  @override
  void initState() {
    super.initState();
    _fetchDistributors();
  }

  Future<void> _fetchDistributors() async {
    final url = Uri.parse(
        'https://dz9cg9nxtc.execute-api.us-east-1.amazonaws.com/distributors/');
    final headers = {
      'Accept': '*/*',
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbkRhdGEiOnsidW5pcXVlX2NvZGUiOjY2Mzg3NDI4LCJ1c2VyX2lkIjoiNjczYzZkY2RjY2Y3NDRkMjBlYTk3ZWIyIiwiaXNfZGlzdHJpYnV0b3IiOnRydWUsImRpc3RyaWJ1dG9yIjoiNjczYzZkY2FjY2Y3NDRkMjBlYTk3ZWFjIn0sImlhdCI6MTczNTEwMDgyNCwiZXhwIjoxNzM1MTg3MjI0fQ.meyT-Pa2U8hHszfRYINcuOdq5KavRZtvUN229mznTtY',
      'x-clientid': '66387428',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _distributors = data['result'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load distributor list');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error); // Debugging purposes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _distributors.length,
              itemBuilder: (context, index) {
                final distributor = _distributors[index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(distributor['fullName']),
                  subtitle: Text(distributor['email']),
                  trailing: Text(distributor['storeCountryName']),
                  onTap: () {
                    // Navigate to profile page and pass the distributor data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DistributorProfilePage(
                          distributor: distributor,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
