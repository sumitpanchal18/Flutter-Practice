import 'package:flutter/material.dart';

import '../../utills/constants/app_strings.dart';
import 'Distributor.dart';

class DistributorProfilePage extends StatelessWidget {
  final Distributor distributor;

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
                        distributor.fullName.isNotEmpty
                            ? '${distributor.fullName.split(" ")[0][0].toUpperCase()}${distributor.fullName.split(" ").length > 1 ? distributor.fullName.split(" ")[1][0].toUpperCase() : ''}'
                            : Strings.nA,
                        style:
                            const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    distributor.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: #${distributor.distributorId}",
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
            _buildInfoRow(
                Strings.distributorId, "#${distributor.distributorId}"),
            _buildInfoRow(Strings.rank,
                "${distributor.binaryRank}\n${distributor.unilevelRank}"),
            _buildInfoRow(Strings.sponsor,
                "${distributor.sponsorName} (#${distributor.sponsorId})"),
            _buildInfoRow(Strings.placement,
                "${distributor.placementName} (#${distributor.sponsorId})"),
            _buildInfoRow(Strings.enrollmentDate, distributor.enrollmentDate),
            _buildInfoRow(Strings.lastOrderDate, distributor.last_order_date),
            const SizedBox(height: 16),
            const Text(
              Strings.personalInformation,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(Strings.mobile, distributor.mobile),
            _buildInfoRow(Strings.email, distributor.email),
            _buildInfoRow(Strings.companyName, Strings.dash),
            _buildInfoRow(Strings.companyWebsite, Strings.dash),
            _buildInfoRow(Strings.dateOfBirth, Strings.dash),
            Row(
              children: [
                Expanded(
                  child: _buildInfoRow(Strings.distributorWebsite,
                      distributor.distributorWebsite),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 15,
                  ),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              Strings.otherInformation,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            _buildInfoRow(Strings.directorQualified, Strings.no),
            _buildInfoRow(Strings.resellerQualified, Strings.no),
            _buildInfoRow(Strings.defaultLanguage, Strings.dash),
            _buildInfoRow(Strings.defaultCurrency, Strings.inr),
            _buildInfoRow(Strings.timeZone, Strings.utc),
            _buildInfoRow(Strings.defaultDateFormat, Strings.dmy),
            const SizedBox(height: 16),
            const Text(
              Strings.taxIdentifier,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Strings.country, Strings.dash),
            _buildInfoRow(Strings.incomeTaxType, Strings.dash),
            _buildInfoRow(Strings.taxId, Strings.dash),
            const SizedBox(height: 16),
            const Text(
              Strings.billingAddress,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (distributor.billing.isNotEmpty)
              for (var billing in distributor.billing)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Strings.address1, billing.address1),
                    _buildInfoRow(Strings.address2, billing.address2),
                    _buildInfoRow(
                      Strings.city,
                      "${billing.city}, ${billing.state}, ${billing.postcode}",
                    ),
                    _buildInfoRow(Strings.country, billing.country),
                  ],
                ),
            const SizedBox(height: 16),
            const Text(
              Strings.shippingAddress,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (distributor.shipping.isNotEmpty)
              for (var shipping in distributor.shipping)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Strings.address1, shipping.address1),
                    _buildInfoRow(Strings.address2, shipping.address2),
                    _buildInfoRow(
                      Strings.city,
                      "${shipping.city}, ${shipping.state}, ${shipping.postcode}",
                    ),
                    _buildInfoRow(Strings.country, shipping.country),
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
