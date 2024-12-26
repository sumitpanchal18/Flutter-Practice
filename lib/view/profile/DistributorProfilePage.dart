import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_flutter/utills/constants/dimens.dart';
import 'package:share_plus/share_plus.dart';

import '../../utills/constants/app_colors.dart';
import '../../utills/constants/app_strings.dart';
import '../../utills/constants/app_styles.dart';
import 'Distributor.dart';

class DistributorProfilePage extends StatelessWidget {
  final Distributor distributor;

  const DistributorProfilePage({super.key, required this.distributor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          Strings.distributorProfile,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(Dimens.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileHeader(distributor),
            distributorInfo(distributor),
            personalInfo(distributor, context),
            otherInfo(distributor),
            taxInfo(distributor),
            billingAddress(distributor),
            shippingAddress(distributor),
          /*  SvgPicture.asset(
              'assets/images/web_icon.svg',
              width: 100,
              height: 100,
            ),*/
          ],
        ),

      ),
    );
  }

  Widget profileHeader(Distributor distributor) {
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
                distributor.fullName.isNotEmpty
                    ? '${distributor.fullName.split(" ")[0][0].toUpperCase()}${distributor.fullName.split(" ").length > 1 ? distributor.fullName.split(" ")[1][0].toUpperCase() : ''}'
                    : Strings.nA,
                style:
                    const TextStyle(fontSize: Dimens.d32, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: Dimens.d6),
          Text(distributor.fullName, style: AppStyles.titleStyle),
          const SizedBox(height: Dimens.d6),
          Text(
            "ID: #${distributor.distributorId}",
            style: AppStyles.valueStyle,
          ),
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
        ],
      ),
    );
  }

  Widget distributorInfo(Distributor distributor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.distributorInformation),
        subTitlesData(Strings.distributorId, "#${distributor.distributorId}"),
        subTitlesData(Strings.rank,
            "${distributor.binaryRank}\n${distributor.unilevelRank}"),
        subTitlesData(Strings.sponsor,
            "${distributor.sponsorName} (#${distributor.sponsorId})"),
        subTitlesData(Strings.placement,
            "${distributor.placementName} (#${distributor.sponsorId})"),
        subTitlesData(Strings.enrollmentDate, distributor.enrollmentDate),
        subTitlesData(Strings.lastOrderDate, distributor.last_order_date),
      ],
    );
  }

  Widget personalInfo(Distributor distributor, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.personalInformation),
        subTitlesData(Strings.mobile, distributor.mobile),
        subTitlesData(Strings.email, distributor.email),
        subTitlesData(Strings.companyName, Strings.dash),
        subTitlesData(Strings.companyWebsite, Strings.dash),
        subTitlesData(Strings.dateOfBirth, Strings.dash),
        shareImage(context,distributor),
      ],
    );
  }

  Widget otherInfo(Distributor distributor) {
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

  Widget taxInfo(Distributor distributor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.taxIdentifier),
        subTitlesData(Strings.country, distributor.storeCountryName),
        subTitlesData(Strings.incomeTaxType, Strings.dash),
        subTitlesData(Strings.taxId, Strings.dash),
      ],
    );
  }

  Widget billingAddress(Distributor distributor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.billingAddress),
        if (distributor.billing.isNotEmpty)
          for (var billing in distributor.billing)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subTitlesData(Strings.address1, billing.address1),
                subTitlesData(Strings.address2, billing.address2),
                subTitlesData(
                  Strings.city,
                  "${billing.city}, ${billing.state}, ${billing.postcode}",
                ),
                subTitlesData(Strings.country, billing.country),
              ],
            ),
      ],
    );
  }

  Widget shippingAddress(Distributor distributor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainTitles(Strings.shippingAddress),
        if (distributor.shipping.isNotEmpty)
          for (var shipping in distributor.shipping)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subTitlesData(Strings.address1, shipping.address1),
                subTitlesData(Strings.address2, shipping.address2),
                subTitlesData(
                  Strings.city,
                  "${shipping.city}, ${shipping.state}, ${shipping.postcode}",
                ),
                subTitlesData(Strings.country, shipping.country),
              ],
            ),
      ],
    );
  }

  Widget shareImage(BuildContext context, Distributor distributor) {
    return Row(
      children: [
        Expanded(
          child: subTitlesData(
            Strings.distributorWebsite,
            distributor.distributorWebsite,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.share,
            color: Colors.black,
            size: Dimens.d15,
          ),
          onPressed: () {
            Share.share(
              'Website: ${distributor.distributorWebsite}',
              subject: 'Distributor Website',
            );
          },
        ),
      ],
    );
  }

  Widget mainTitles(String title) {
    return Column(
      children: [
        const SizedBox(height: Dimens.d10),
        Text(
          title,
          style: AppStyles.titleStyle,
        ),
        const SizedBox(height: Dimens.d6),
      ],
    );
  }

  Widget subTitlesData(String title, String value) {
    return Padding(
      padding: AppStyles.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.subTitleStyle,
          ),
          const SizedBox(height: Dimens.d4),
          Text(
            value.isNotEmpty ? value : Strings.dash,
            style: AppStyles.valueStyle,
          ),
        ],
      ),
    );
  }
}
