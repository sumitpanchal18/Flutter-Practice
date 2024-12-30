import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_flutter/utills/constants/dimens.dart';
import 'package:share_plus/share_plus.dart';

import '../../utills/constants/app_colors.dart';
import '../../utills/constants/app_strings.dart';
import '../../utills/constants/app_styles.dart';
import 'Distributor.dart';
import 'list/SocialMediaScreen.dart';

class DistributorProfilePage extends StatefulWidget {
  final Distributor distributor;

  const DistributorProfilePage({super.key, required this.distributor});

  @override
  _DistributorProfilePageState createState() =>
      _DistributorProfilePageState();
}

class _DistributorProfilePageState extends State<DistributorProfilePage> {
  late Map<String, TextEditingController> _controllers;
  bool _isEditing = false;
  bool _isLoading = false; // For loading state

  @override
  void initState() {
    super.initState();
    _controllers = {
      'fullName': TextEditingController(text: widget.distributor.fullName),
      'mobile': TextEditingController(text: widget.distributor.mobile),
      'email': TextEditingController(text: widget.distributor.email),
      'company': TextEditingController(text: Strings.dash),
      'website': TextEditingController(text: widget.distributor.distributorWebsite),
      'dateOfBirth': TextEditingController(text: Strings.dash),
    };
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  // Fetch distributor data (GET request)
  Future<void> _loadDistributorData() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://api.example.com/distributors/${widget.distributor.distributorId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Update controller values with data
      _controllers['fullName']?.text = data['fullName'];
      _controllers['mobile']?.text = data['mobile'];
      _controllers['email']?.text = data['email'];
      _controllers['website']?.text = data['website'];
      // Update distributor model
      setState(() {
        widget.distributor.fullName = data['fullName'];
        widget.distributor.mobile = data['mobile'];
        widget.distributor.email = data['email'];
        widget.distributor.distributorWebsite = data['website'];
      });
    } else {
      // Handle error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load data')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
      print(widget.distributor.distributorId);
    });

    final response = await http.put(
      Uri.parse(
          'https://dz9cg9nxtc.execute-api.us-east-1.amazonaws.com/distributors/update/${widget.distributor.distributorId}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Strings.token, // Add token here
      },
      body: json.encode({
        'fullName': _controllers['fullName']!.text,
        'mobile': _controllers['mobile']!.text,
        'email': _controllers['email']!.text,
        'website': _controllers['website']!.text,
      }),
    );
    print("Sending data: ${json.encode({
      'fullName': _controllers['fullName']!.text,
      'mobile': _controllers['mobile']!.text,
      'email': _controllers['email']!.text,
      'website': _controllers['website']!.text,
    })}");

    if (response.statusCode == 200) {
      setState(() {
        widget.distributor.fullName = _controllers['fullName']!.text;
        widget.distributor.mobile = _controllers['mobile']!.text;
        widget.distributor.email = _controllers['email']!.text;
        widget.distributor.distributorWebsite = _controllers['website']!.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Changes saved successfully')));
    } else {
      print('Error: ${response.statusCode}, ${response.body}'); // Log error details
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save changes')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            Strings.distributorProfile,
            style: TextStyle(color: Colors.white),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: 'PROFILE'),
                Tab(text: 'SOCIAL MEDIA'),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileHeader(),
                  distributorInfo(),
                  personalInfo(),
                  otherInfo(),
                  taxInfo(),
                  billingAddress(),
                  shippingAddress(),
                  if (_isEditing)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        child: const Text("Save Changes"),
                      ),
                    ),
                ],
              ),
            ),
            SocialMediaScreen(distributor: widget.distributor),
          ],
        ),
      ),
    );
  }

  Widget profileHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: Dimens.d100,
            height: Dimens.d100,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                widget.distributor.fullName.isNotEmpty
                    ? '${widget.distributor.fullName.split(" ")[0][0].toUpperCase()}${widget.distributor.fullName.split(" ").length > 1 ? widget.distributor.fullName.split(" ")[1][0].toUpperCase() : ''}'
                    : Strings.nA,
                style: const TextStyle(
                  fontSize: Dimens.d35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimens.d6),
          _isEditing
              ? TextField(
            controller: _controllers['fullName'],
            decoration: InputDecoration(hintText: "Enter Full Name"),
          )
              : Text(widget.distributor.fullName, style: AppStyles.titleStyle),
          const SizedBox(height: Dimens.d6),
          Text("ID: #${widget.distributor.distributorId}",
              style: AppStyles.valueStyle),
          const SizedBox(height: Dimens.d6),
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.d4, horizontal: Dimens.d8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(Dimens.d4),
            ),
            child: const Text(
              Strings.activeStatus,
              style: TextStyle(color: Colors.green),
            ),
          ),
          const SizedBox(height: Dimens.d6),
          ElevatedButton(
            onPressed: _toggleEditing,
            child: Text(_isEditing ? Strings.cancel : Strings.edit),
          ),
        ],
      ),
    );
  }

  Widget distributorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.distributorInformation),
        subTitlesData(Strings.distributorId, "#${widget.distributor.distributorId}"),
        subTitlesData(Strings.rank,
            "Binary : ${widget.distributor.binaryRank}\nUnilevel: ${widget.distributor.unilevelRank}"),
        subTitlesData(Strings.sponsor,
            "${widget.distributor.sponsorName} (#${widget.distributor.sponsorId})"),
        subTitlesData(Strings.placement,
            "${widget.distributor.placementName} (#${widget.distributor.sponsorId})"),
        subTitlesData(Strings.enrollmentDate, widget.distributor.enrollmentDate),
        subTitlesData(
            Strings.lastOrderDate, widget.distributor.last_order_date),
      ],
    );
  }

  Widget personalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.personalInformation),
        editableSubTitlesData(Strings.mobile, 'mobile'),
        editableSubTitlesData(Strings.email, 'email'),
        editableSubTitlesData(Strings.companyName, 'company'),
        editableSubTitlesData(Strings.companyWebsite, 'website'),
        editableSubTitlesData(Strings.dateOfBirth, 'dateOfBirth'),
        shareImage(),
      ],
    );
  }

  Widget editableSubTitlesData(String title, String key) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.subTitleStyle),
          const SizedBox(height: Dimens.d2),
          _isEditing
              ? TextField(
            controller: _controllers[key],
            decoration: InputDecoration(hintText: "Enter $title"),
          )
              : Text(
              _controllers[key]!.text.isNotEmpty
                  ? _controllers[key]!.text
                  : Strings.dash,
              style: AppStyles.valueStyle),
        ],
      ),
    );
  }

  Widget otherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.otherInformation),
        subTitlesData(Strings.directorQualified, Strings.no),
        subTitlesData(Strings.resellerQualified, Strings.no),
        subTitlesData(Strings.defaultLanguage, Strings.dash),
        subTitlesData(Strings.defaultCurrency, Strings.inr),
        subTitlesData(Strings.timeZone, Strings.utc),
        subTitlesData(Strings.defaultDateFormat, Strings.dmy),
      ],
    );
  }

  Widget taxInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.taxIdentifier),
        subTitlesData(Strings.country, widget.distributor.storeCountryName),
        subTitlesData(Strings.incomeTaxType, Strings.dash),
        subTitlesData(Strings.taxId, Strings.dash),
      ],
    );
  }

  Widget billingAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.billingAddress),
        if (widget.distributor.billing.isNotEmpty)
          for (var billing in widget.distributor.billing)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subTitlesData(Strings.address1, billing.address1),
                subTitlesData(Strings.address2, billing.address2),
                subTitlesData(Strings.city,
                    "${billing.city}, ${billing.state}, ${billing.postcode}"),
                subTitlesData(Strings.country, billing.country),
              ],
            ),
      ],
    );
  }

  Widget shippingAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.shippingAddress),
        if (widget.distributor.shipping.isNotEmpty)
          for (var shipping in widget.distributor.shipping)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subTitlesData(Strings.address1, shipping.address1),
                subTitlesData(Strings.address2, shipping.address2),
                subTitlesData(Strings.city,
                    "${shipping.city}, ${shipping.state}, ${shipping.postcode}"),
                subTitlesData(Strings.country, shipping.country),
              ],
            ),
      ],
    );
  }

  Widget shareImage() {
    return Row(
      children: [
        Expanded(
            child: subTitlesData(Strings.distributorWebsite,
                widget.distributor.distributorWebsite)),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.black, size: Dimens.d20),
          onPressed: () {
            Share.share('Website: ${widget.distributor.distributorWebsite}',
                subject: 'Distributor Website');
          },
        ),
      ],
    );
  }

  Widget mainTitles(String title) {
    return Column(
      children: [
        const SizedBox(height: Dimens.d15),
        Text(title, style: AppStyles.titleStyle),
      ],
    );
  }

  Widget subTitlesData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.subTitleStyle),
          const SizedBox(height: Dimens.d2),
          Text(value.isNotEmpty ? value : Strings.dash,
              style: AppStyles.valueStyle),
        ],
      ),
    );
  }
}
