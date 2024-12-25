import 'package:get/get.dart';

import 'Distributor.dart';
import 'DistributorRepository.dart';

class DistributorController extends GetxController {
  var distributorProfile = Rxn<Distributor>();
  var isLoading = false.obs;
  var error = ''.obs;

  final DistributorRepository repository;

  DistributorController({required this.repository});

  Future<void> fetchDistributorData() async {
    isLoading(true);
    try {
      final data = await repository.fetchDistributorData();

      var result = data['result'];

      if (result != null && result.isNotEmpty) {
        distributorProfile.value = Distributor.fromMap(result[0]);
      } else {
        error('No data found');
      }
    } catch (e) {
      error('Failed to load data: $e');
    } finally {
      isLoading(false);
    }
  }
}
