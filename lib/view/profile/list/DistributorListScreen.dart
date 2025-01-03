import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter/utills/constants/app_colors.dart';
import 'package:practice_flutter/utills/constants/app_strings.dart';

import '../../../utills/constants/SvgProgressIndicator.dart';
import '../Distributor.dart';
import '../DistributorProfilePage.dart';
import 'RefreshableList.dart';

class DistributorListScreen extends StatefulWidget {
  @override
  _DistributorListScreenState createState() => _DistributorListScreenState();
}

class _DistributorListScreenState extends State<DistributorListScreen> {
  bool _isLoading = true;
  List<Distributor> _distributors = [];

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
          Strings.token,
      'x-clientid': '66387428',
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['result'];
        setState(() {
          _distributors = jsonData
              .map<Distributor>((json) => Distributor.fromMap(json))
              .toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load distributor list');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: SvgProgressIndicator(
                svgPath: 'assets/images/loading.svg', 
              ),
            )
          : RefreshableList<Distributor>(
              items: _distributors,
              onRefresh: _fetchDistributors,
              itemBuilder: (context, distributor) => Card(
                elevation: 6.0,
                color: AppColors.secondaryColor,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  // Placeholder for profile image
                  title:
                      Text('${distributor.firstName} ${distributor.lastName}'),
                  subtitle: Text(distributor.email),
                  trailing: Text(distributor.storeCountryName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DistributorProfilePage(
                          distributor: distributor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
