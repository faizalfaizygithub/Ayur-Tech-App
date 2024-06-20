import 'package:flutter/material.dart';
import 'package:noviindus_tech/Controller/service/patient_list_service.dart';
import 'package:noviindus_tech/Model/home_patient_model.dart';
import 'package:noviindus_tech/View/tools/screts/token.dart';

class HomeProvider with ChangeNotifier {
  List<PatientElement>? _patients;
  bool _isLoading = false;
  String? _errorMessage;

  List<PatientElement>? get patients => _patients;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPatients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    HomeScreenRepository repository = HomeScreenRepository();
    List<PatientElement>? patientsList =
        await repository.getPatients(Secrets.token);

    _isLoading = false;
    if (patientsList != null) {
      _patients = patientsList;
    } else {
      _errorMessage = 'Failed to fetch patients';
    }
    notifyListeners();
  }
}
