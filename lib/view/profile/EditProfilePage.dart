import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:practice_flutter/utills/constants/dimens.dart';

import '../../utills/constants/app_colors.dart';
import '../../utills/constants/app_strings.dart';
import '../../utills/constants/app_styles.dart';
import 'Distributor.dart';

class EditProfilePage extends StatefulWidget {
  final Distributor distributor;

  const EditProfilePage({super.key, required this.distributor});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  late Map<String, TextEditingController> _controllers;
  bool _isLoading = false;
  File? _image;

  // Dropdown options
  List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];
  List<String> incomeTaxType = ['Personal', 'Business'];
  List<String> countries = ['India', 'Spain', 'French', 'Germany', 'US'];
  List<String> currencies = ['Dollar', 'Euro', 'Pound', 'Yen', 'Rupees'];
  List<String> timeZones = [
    '(GMT+00:00) UTC',
    '(GMT-05:00) EST',
    '(GMT-08:00) PST',
    '(GMT+01:00) CET',
    '(GMT+08:00) CST'
  ];
  List<String> dateFormats = [
    'Chinese (S) (zh-CN) - yyyy/M/d',
    'MM/dd/yyyy',
    'dd/MM/yyyy',
    'yyyy-MM-dd',
    'dd.MM.yyyy'
  ];

  // Selected values
  String selectedLanguage = 'English';
  String selectedCurrency = 'Dollar';
  String selectedCountry = 'India';
  String selectedIncomeTaxType = 'Personal';
  String selectedTimeZone = '(GMT+00:00) UTC';
  String selectedDateFormat = 'Chinese (S) (zh-CN) - yyyy/M/d';

  @override
  void initState() {
    super.initState();

    _controllers = {
      'firstName': TextEditingController(text: widget.distributor.firstName),
      'lastName': TextEditingController(text: widget.distributor.lastName),
      'mobile': TextEditingController(text: widget.distributor.mobile),
      'email': TextEditingController(text: widget.distributor.email),
      'binaryRank': TextEditingController(text: widget.distributor.binaryRank),
      'website':
          TextEditingController(text: widget.distributor.distributorWebsite),
      'dateOfBirth': TextEditingController(text: Strings.dash),
      'sponsorName':
          TextEditingController(text: widget.distributor.sponsorName),
      'unilevelRank':
          TextEditingController(text: widget.distributor.unilevelRank),
      'company':
          TextEditingController(text: widget.distributor.billing[0].company),
      'language': TextEditingController(),
      'currency': TextEditingController(),
      'timeZone': TextEditingController(),
      'dateFormat': TextEditingController(),
      'secretQuestion': TextEditingController(),
      'secretAnswer': TextEditingController(),
      'incomeTaxType': TextEditingController(),
      'taxId': TextEditingController(),
      'address_1':
          TextEditingController(text: widget.distributor.billing[0].address1),
      'address_2':
          TextEditingController(text: widget.distributor.billing[0].address2),
      'city': TextEditingController(text: widget.distributor.billing[0].city),
      'country':
          TextEditingController(text: widget.distributor.billing[0].country),
      'state': TextEditingController(text: widget.distributor.billing[0].state),
      'postcode':
          TextEditingController(text: widget.distributor.billing[0].postcode),
    };
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    final distributorId = widget.distributor.distributorId;
    final url =
        "https://dz9cg9nxtc.execute-api.us-east-1.amazonaws.com/distributors/update/$distributorId";

    final request = http.MultipartRequest('PUT', Uri.parse(url))
      ..headers['Authorization'] = Strings.token
      ..headers['accept'] = '*/*'
      ..headers['x-clientid'] = '66387428'
      ..fields['timezone_name'] = selectedTimeZone
      ..fields['storeCountry'] = "IN"
      ..fields['id'] = distributorId
      ..fields['first_name'] = _controllers['firstName']!.text
      ..fields['last_name'] = _controllers['lastName']!.text
      ..fields['mobile'] = _controllers['mobile']!.text
      ..fields['email'] = _controllers['email']!.text
      ..fields['binary_rank'] = _controllers['binaryRank']!.text
      ..fields['unilevel_rank'] = _controllers['unilevelRank']!.text
      ..fields['company'] = _controllers['company']!.text
      ..fields['website'] = _controllers['website']!.text
      ..fields['date_of_birth'] = _controllers['dateOfBirth']!.text
      ..fields['language'] = selectedLanguage
      ..fields['currency'] = selectedCurrency
      ..fields['time_zone'] = selectedTimeZone
      ..fields['date_format'] = selectedDateFormat
      ..fields['secret_question'] = _controllers['secretQuestion']!.text
      ..fields['secret_answer'] = _controllers['secretAnswer']!.text
      ..fields['country'] = _controllers['country']!.text
      ..fields['income_tax_type'] = _controllers['incomeTaxType']!.text
      ..fields['tax_id'] = _controllers['taxId']!.text
      ..fields['address_1'] = _controllers['address_1']!.text
      ..fields['address_2'] = _controllers['address_2']!.text
      ..fields['city'] = _controllers['city']!.text
      ..fields['country'] = _controllers['country']!.text
      ..fields['state'] = _controllers['state']!.text
      ..fields['postcode'] = _controllers['postcode']!.text;

    if (_image != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profile_image', _image!.path));
    }

    final response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      if (response.statusCode == 200) {
        setState(() {
          widget.distributor.firstName = _controllers['firstName']!.text;
          widget.distributor.lastName = _controllers['lastName']!.text;
          widget.distributor.email = _controllers['email']!.text;
          widget.distributor.mobile = _controllers['mobile']!.text;
          widget.distributor.billing[0].address1 =
              _controllers['address_1']!.text;
          widget.distributor.billing[0].company = _controllers['company']!.text;
          widget.distributor.billing[0].address2 =
              _controllers['address_2']!.text;
          widget.distributor.billing[0].city = _controllers['city']!.text;
          widget.distributor.billing[0].country = _controllers['country']!.text;
          widget.distributor.billing[0].state = _controllers['state']!.text;
          widget.distributor.billing[0].postcode =
              _controllers['postcode']!.text;
          widget.distributor.binaryRank = _controllers['binaryRank']!.text;
          widget.distributor.distributorWebsite = _controllers['website']!.text;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Changes saved successfully')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to save changes')));
      }

      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget dropdownField(String label, String? value, List<String> items,
      Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.d12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.subTitleStyle),
          const SizedBox(height: Dimens.d6),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  hint: Text('Select $label'),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          Strings.editProfile,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(Dimens.d16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor, // Dark blue color
                              borderRadius: BorderRadius.circular(4),
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
                          const SizedBox(height: 16),
                          TextButton.icon(
                            onPressed: _pickImage,
                            icon: Icon(Icons.cloud_upload_outlined),
                            label: Text('Suggested JPG, PNG or JPEG.'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    mainTitles(Strings.personalInformation),
                    editableField('First Name', 'firstName'),
                    editableField('Last Name', 'lastName'),
                    editableField('Email', 'email', isEditable: false),
                    editableField('Date of Birth', 'dateOfBirth', isDate: true),
                    editableField('Phone', 'mobile'),
                    editableField('Mobile', 'mobile'),
                    mainTitles(Strings.otherInformation),
                    editableField('Company Name', 'company'),
                    editableField('Company Website', 'website'),
                    dropdownField('Language', null, languages,
                        (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    }),
                    dropdownField('Currency', null, currencies,
                        (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    }),
                    editableField('Distributor Website', 'website'),
                    dropdownField('Time zone', null, timeZones,
                        (String? newValue) {
                      setState(() {
                        selectedTimeZone = newValue!;
                      });
                    }),
                    dropdownField('Default date format', null, dateFormats,
                        (String? newValue) {
                      setState(() {
                        selectedDateFormat = newValue!;
                      });
                    }),
                    mainTitles(Strings.secretQue),
                    editableField('Secret Questions', 'secretQuestion'),
                    editableField('Secret Answer', 'secretAnswer'),
                    mainTitles(Strings.taxIdentifier),
                    dropdownField('Country', null, countries,
                        (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    }),
                    dropdownField('Income Tax Type', null, incomeTaxType,
                        (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    }),
                    editableField('Tax ID', 'taxId'),
                    mainTitles(Strings.quilifiedInfo),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked1,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked1 = value!;
                                });
                              },
                            ),
                            const Text('Director Qualified'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked2,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked2 = value!;
                                });
                              },
                            ),
                            const Text('Reseller Qualified'),
                          ],
                        ),
                      ],
                    ),
                    mainTitles(Strings.billingAddress),
                    editableField('Address 1', 'address_1'),
                    editableField('Address 2', 'address_2'),
                    editableField('City', 'city'),
                    editableField('Country', 'country'),
                    editableField('State', 'state'),
                    editableField('Postal Code', 'postcode'),
                    mainTitles(Strings.shippingAddress),
                    editableField('Address 1', 'address_1'),
                    editableField('Address 2', 'address_2'),
                    editableField('City', 'city'),
                    editableField('Country', 'country'),
                    editableField('State', 'state'),
                    editableField('Postal Code', 'postcode'),
                    const SizedBox(height: Dimens.d20),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _selectDate(BuildContext context, String key) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _controllers[key]!.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget editableField(String label, String key,
      {bool isDate = false, bool isEditable = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.d12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.subTitleStyle),
          const SizedBox(height: Dimens.d6),
          TextField(
            controller: _controllers[key]!,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter $label',
            ),
            onTap: isDate
                ? () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await _selectDate(context, key);
                  }
                : null,
            readOnly: !isEditable || isDate, // Non-editable for both cases
          ),
        ],
      ),
    );
  }

  Widget mainTitles(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.d16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.titleStyle),
          const SizedBox(height: Dimens.d16),
        ],
      ),
    );
  }
}