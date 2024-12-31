import 'package:flutter/material.dart';
import 'package:practice_flutter/utills/constants/dimens.dart';
import '../../utills/constants/app_colors.dart';
import '../../utills/constants/app_strings.dart';
import '../../utills/constants/app_styles.dart';
import 'Distributor.dart';
import 'EditProfilePage.dart';
import 'list/SocialMediaScreen.dart';

class DistributorProfilePage extends StatefulWidget {
  final Distributor distributor;

  const DistributorProfilePage({super.key, required this.distributor});

  @override
  _DistributorProfilePageState createState() => _DistributorProfilePageState();
}

class _DistributorProfilePageState extends State<DistributorProfilePage> {
  bool _isLoading = false; // For loading state

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
          Text(widget.distributor.fullName, style: AppStyles.titleStyle),
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
            onPressed: () {
              // Navigate to the EditProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(distributor: widget.distributor),
                ),
              );
            },
            child: const Text(Strings.edit),
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
        subTitlesData(
            Strings.distributorId, "#${widget.distributor.distributorId}"),
        subTitlesData(Strings.rank,
            "Binary : ${widget.distributor.binaryRank}\nUnilevel: ${widget.distributor.unilevelRank}"),
        subTitlesData(Strings.sponsor,
            "${widget.distributor.sponsorName} (#${widget.distributor.sponsorId})"),
        subTitlesData(Strings.placement,
            "${widget.distributor.placementName} (#${widget.distributor.sponsorId})"),
        subTitlesData(
            Strings.enrollmentDate, widget.distributor.enrollmentDate),
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
        subTitlesData(Strings.mobile, widget.distributor.mobile),
        subTitlesData(Strings.email, widget.distributor.email),
        subTitlesData(Strings.companyName, widget.distributor.billing[0].company),
        subTitlesData(Strings.dateOfBirth, Strings.dash),
        subTitlesData(Strings.companyWebsite, widget.distributor.distributorWebsite),
      ],
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

  Widget mainTitles(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.d16),
      child: Text(title, style: AppStyles.titleStyle),
    );
  }

  Widget subTitlesData(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.d6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.subTitleStyle),
          const SizedBox(height: Dimens.d2),
          Text(
            data.isNotEmpty ? data : Strings.dash,
            style: AppStyles.valueStyle,
          ),
        ],
      ),
    );
  }
}
