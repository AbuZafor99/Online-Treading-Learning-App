import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final ProfileController _profileController = Get.find<ProfileController>();

  final RxString gender = 'Male'.obs; // reactive gender
  final RxString nationality = 'Select Country'.obs; // reactive nationality

  @override
  void initState() {
    super.initState();

    if (_profileController.userInfo.value == null ||
        _profileController.userInfo.value?.name == null) {
      _profileController.fetchProfile().then((_) {
        _setInitialValues();
      });
    } else {
      _setInitialValues();
    }
  }

  void _setInitialValues() {
    final user = _profileController.userInfo.value;

    if (user != null) {
      _fullNameController.text = user.name ?? '';
      _ageController.text = user.age?.toString() ?? '';

      gender.value = (user.gender ?? 'Male').toLowerCase() == 'female'
          ? 'Female'
          : (user.gender?.toLowerCase() == 'male' ? 'Male' : 'Other');

      nationality.value = user.nationality ?? 'Select Country';
    }
  }

  void _submit() {
    _profileController.updatePersonalInfo(
      _fullNameController.text,
      _ageController.text,
      gender.value,
      nationality.value,
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      showSearch: true,
      onSelect: (Country country) {
        nationality.value = country.name; // reactive update
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black),
        bottomSheetHeight: 500,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Personal Information",
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Full Name"),
                const SizedBox(height: 6),
                TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text("Age"),
                const SizedBox(height: 6),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text("Gender"),
                const SizedBox(height: 6),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: gender.value,
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                      DropdownMenuItem(value: "Other", child: Text("Other")),
                    ],
                    onChanged: (value) {
                      gender.value = value!;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text("Nationality"),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: _showCountryPicker,
                  child: Obx(
                    () => AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: nationality.value,
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 181),

                Obx(
                  () => context.primaryButton(
                    isLoading: _profileController.isLoading.value,
                    onPressed: () {
                      _submit();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profile Saved!")),
                      );
                    },
                    text: "Save",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
