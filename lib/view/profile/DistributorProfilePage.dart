import 'package:flutter/material.dart';

import '../../utills/constants/app_strings.dart';

class DistributorProfilePage extends StatelessWidget {
  final dynamic distributor;

  // Constructor to accept distributor data
  const DistributorProfilePage({super.key, required this.distributor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.distributorProfile,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Text(
                        distributor['fullName']?.isNotEmpty ?? false
                            ? '${distributor['fullName'].split(" ")[0][0].toUpperCase()}${distributor['fullName'].split(" ").length > 1 ? distributor['fullName'].split(" ")[1][0].toUpperCase() : ''}'
                            : Strings.nA,
                        style:
                            const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    distributor['fullName'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: #${distributor['distributorId'] ?? Strings.nA}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      Strings.activeStatus,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              Strings.distributorInformation,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(Strings.distributorId,
                "#${distributor['distributorId'] ?? Strings.nA}"),
            _buildInfoRow(
                Strings.rank, distributor['binaryRank'] ?? Strings.nA),
            _buildInfoRow(
                Strings.sponsor, distributor['sponsorName'] ?? Strings.nA),
            _buildInfoRow(
                Strings.placement, distributor['placementName'] ?? Strings.nA),
            _buildInfoRow(Strings.enrollmentDate,
                distributor['enrollmentDate'] ?? Strings.nA),
            _buildInfoRow(Strings.lastOrderDate,
                distributor['last_order_date'] ?? Strings.nA),
            const SizedBox(height: 16),
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(Strings.mobile, distributor['mobile'] ?? Strings.nA),
            _buildInfoRow(Strings.email, distributor['email'] ?? Strings.nA),
            _buildInfoRow(Strings.companyName, "---"),
            _buildInfoRow(Strings.companyWebsite, "---"),
            _buildInfoRow(Strings.dateOfBirth, "---"),
            _buildInfoRow(Strings.distributorWebsite,
                distributor['distributorWebsite'] ?? Strings.nA),
            const SizedBox(height: 16),
            const Text(
              Strings.otherInformation,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(Strings.directorQualified, "No"),
            _buildInfoRow(Strings.resellerQualified, "No"),
            _buildInfoRow(Strings.defaultLanguage, "--"),
            _buildInfoRow(Strings.defaultCurrency, "IDR"),
            _buildInfoRow(Strings.timeZone, "UTC"),
            _buildInfoRow(Strings.defaultDateFormat, "YYYY/MM/DD"),
            const SizedBox(height: 16),
            const Text(
              Strings.taxIdentifier,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Strings.country, distributor['country'] ?? '--'),
            _buildInfoRow(
                Strings.incomeTaxType, distributor['incomeTaxType'] ?? '--'),
            _buildInfoRow(Strings.taxId, distributor['taxID'] ?? '--'),
            const SizedBox(height: 16),
            const Text(
              Strings.billingAddress,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (distributor['billing'] != null &&
                distributor['billing'].isNotEmpty)
              for (var billing in distributor['billing'])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                        Strings.address1, billing['address_1'] ?? Strings.nA),
                    _buildInfoRow(
                        Strings.address2, billing['address_2'] ?? Strings.nA),
                    _buildInfoRow(
                      Strings.city,
                      billing['city'] != null &&
                              billing['state_name'] != null &&
                              billing['postcode'] != null
                          ? "${billing['city']}, ${billing['state_name']}, ${billing['postcode']}"
                          : Strings.nA,
                    ),
                    _buildInfoRow(
                        Strings.country, billing['country_name'] ?? Strings.nA),
                  ],
                ),
            const SizedBox(height: 16),
            const Text(
              Strings.shippingAddress,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (distributor['billing'] != null &&
                distributor['billing'].isNotEmpty)
              for (var billing in distributor['billing'])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                        Strings.address1, billing['address_1'] ?? Strings.nA),
                    _buildInfoRow(
                        Strings.address2, billing['address_2'] ?? Strings.nA),
                    _buildInfoRow(
                      "City",
                      billing['city'] != null &&
                              billing['state_name'] != null &&
                              billing['postcode'] != null
                          ? "${billing['city']}, ${billing['state_name']}, ${billing['postcode']}"
                          : Strings.nA,
                    ),
                    _buildInfoRow(
                        Strings.country, billing['country_name'] ?? Strings.nA),
                  ],
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
