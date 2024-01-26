import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import 'package:src/common/loading.dart';
import 'package:src/models/data/users/user_data.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/services/user_api.dart';
import 'package:src/ui/profiles/birthday_select_widget.dart';
import 'package:src/ui/profiles/country_select_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String linkAvatar = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController studyScheduleController = TextEditingController();

  List<String> countries = ['Vietnam', 'United States', 'Canada', 'Other'];
  String selectedCountry = "Vietnam";
  List<String> itemsLevel = [
    "BEGINNER",
    "HIGHER_BEGINNER",
    "PRE_INTERMEDIATE",
    "INTERMEDIATE",
    "UPPER_INTERMEDIATE",
    "ADVANCED",
    "PROFICIENCY"
  ];
  List<String> itemsCategory = [
    'ALL',
    'ENGLISTS-FOR-KIDS',
    'BUSINESS-ENGLISH',
    'TOEIC',
    'CONVERSATIONAL',
    "TOEFL",
    'PET',
    "KET",
    'IELTS',
    'TOEFL',
    "STARTERS",
    "MOVERS",
    "FLYERS",
  ];
  String selectedLevel = "Beginner";
  List<String> selectedCategory = [];
  late DateTime selectedDate;
  late bool hasInitValue = false;
  XFile? _pickedFile;

  void initValues(UserData userData) {
    setState(() {
      linkAvatar = userData.avatar ?? "";
      nameController.text = userData.name ?? "";
      emailController.text = userData.email ?? "";
      phoneController.text = userData.phone ?? "";
      studyScheduleController.text = userData.studySchedule ?? "";
      String country = userData.country ?? "";
      bool check = false;
      for (var element in countries) {
        if (element.toLowerCase() == country.toLowerCase()) {
          check = true;
          selectedCountry = element;
          break;
        }
      }

      if (check == false) {
        setState(() {
          countries.add(country);
        });
      }

      if (userData.birthday != null) {
        List<String> dateComponents = userData.birthday!.split('-');

        if (dateComponents.length == 3) {
          String year = dateComponents[0];
          String month = dateComponents[1];
          String day = dateComponents[2];

          DateTime dateTime = DateTime(
              int.parse(year), int.parse(month), int.parse(day));

          String formattedDateString = "${dateTime.year}-${dateTime.month
              .toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(
              2, '0')}";
          selectedDate =
              DateTime.parse(formattedDateString);
        }
      }
      String level = userData.level ?? "BEGINNER";
      check = false;
      for (var element in itemsLevel) {
        if (element.toLowerCase().compareTo(level.toLowerCase()) == 0) {
          check = true;
          selectedLevel = element;
          break;
        }
      }
      if (check == false) {
        setState(() {
          itemsLevel.add(level);
        });
      }

      check = false;
      userData.learnTopics?.forEach((element) {
        selectedCategory.add(element.key!.toUpperCase());
      });

      hasInitValue = true;
    });
  }

  _getFromGallery(AuthenticationProvider authProvider) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      callAPIUpdateAvatar(UserAPI(), authProvider, pickedFile.path);
    }
  }

  Future<void> callAPIUpdateAvatar(UserAPI userAPI, AuthenticationProvider authProvider, String avatar) async {
    await userAPI.uploadAvatar(
      accessToken: authProvider.token?.access?.token ?? "",
      imagePath: avatar,
      onSuccess: (user) async {
        authProvider.saveLoginInfo(user, authProvider.token);
        initValues(authProvider.currentUser!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully' , style: TextStyle(color: Colors.white),), backgroundColor: Colors.green),
        );
      },
      onFail: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      });
  }

  Future<void> callAPIUpdateProfile(UserAPI userAPI, AuthenticationProvider authProvider) async {
    await userAPI.updateInfoUser(
        accessToken: authProvider.token?.access?.token ?? "",
        input: UserData(
            name: nameController.text,
            phone: phoneController.text,
            country: selectedCountry,
            birthday: DateFormat('yyyy-MM-dd').format(selectedDate),
            level: selectedLevel,
            learnTopics: authProvider.currentUser?.learnTopics!,
            testPreparations: authProvider.currentUser?.testPreparations!,
            studySchedule:studyScheduleController.text
          ),
        onSuccess: (user) async {
          authProvider.saveLoginInfo(user, authProvider.token);
          initValues(authProvider.currentUser!);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully',style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
          );
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    if (hasInitValue == false) {
      initValues(authenticationProvider.currentUser!);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 0),
            )
          ]),

          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness:
                  Brightness.light,
            ),
            title: const Text("Profile",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.blueAccent,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: !hasInitValue ? const Loading() : SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _pickedFile != null
                                  ? FileImage(File(_pickedFile!.path))
                                      as ImageProvider<Object>
                                  : NetworkImage(linkAvatar))),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _getFromGallery(authenticationProvider);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue.shade700,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  authenticationProvider.currentUser?.name ?? "Anonymous",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: _buildInfo("Account ID: ", authenticationProvider.currentUser?.id! ?? "")),
              const SizedBox(height: 10),
              Center(
                  child: GestureDetector(
                onTap: () {},
                child: const Text(
                                  "Others review you",
                                  style: TextStyle(fontSize: 14, color: Colors.blue),
                                ),
              )),
              const SizedBox(height: 10),
              Center(
                  child: GestureDetector(
                onTap: () {},
                child: const Text(
                                  "Change Password",
                                  style: TextStyle(fontSize: 14, color: Colors.blue),
                                ),
              )),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              _buildForm(authenticationProvider.currentUser!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(UserData userData) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildGreyText("Name"),
            const SizedBox(height: 8),
            _buildInputField(
              nameController,
              'Enter your name',
            ),
            const SizedBox(height: 16),
            _buildGreyText("Email Address"),
            const SizedBox(height: 8),
            _buildInputField(
              emailController,
              "Enter your email",
            ),
            const SizedBox(height: 16),
            _buildGreyText("Country"),
            const SizedBox(height: 8),
            CountrySelect(
              countries: countries,
              selectedCountry: selectedCountry,
              onCountryChanged: (String newCountry) {
                setState(() {
                  selectedCountry = newCountry;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildGreyText("Phone Number"),
            const SizedBox(height: 8),
            _buildInputField(
              phoneController,
              "Enter your phone",
            ),
            const SizedBox(height: 16),
            _buildGreyText("Birthday"),
            const SizedBox(height: 8),
            BirthdaySelect(
              dateTimeData: selectedDate,
              onBirthDayChanged: (String newBirthDay) {
                setState(() {
                  selectedDate = DateTime.parse(newBirthDay);
                });
              },
            ),
            const SizedBox(height: 16),
            _buildGreyText("My level"),
            const SizedBox(height: 8),
            _buildSelectLevel("Choose your level", itemsLevel, selectedLevel),
            const SizedBox(height: 16),
            _buildGreyText("Want to learn"),
            const SizedBox(height: 8),
            _buildSelect("Want to learn", itemsCategory, selectedCategory),
            const SizedBox(height: 16),
            _buildGreyText("Study Schedule"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: studyScheduleController,
                decoration: InputDecoration(
                  hintText:
                      "Note the time of the week you want to study on LetTutor",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 12),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
          callAPIUpdateProfile(UserAPI(), authenticationProvider);
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color.fromRGBO(4, 104, 211, 1.0),
        minimumSize: const Size.fromHeight(46),
      ),
      child: const Text(
        "Save changes",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildInfo(String title, String content) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      child: Wrap(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText,
      {isPassword = false}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : null,
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildSelect(
      String title, List<String> selects, List<String> selected) {
    return Container(
      width: double.infinity,
      height: 42.0,
      alignment: Alignment.center,
      child: DropDownMultiSelect(
        isDense: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          isDense: true,
          contentPadding: EdgeInsets.all(12),
        ),
        onChanged: (List<String> x) {
          setState(() {
            selected = x;
          });
        },
        options: selects,
        selectedValues: selected,
        whenEmpty: title,
      ),
    );
  }

  Widget _buildSelectLevel(
      String title, List<String> selects, String selected) {
    return Container(
      width: double.infinity, // Set width to match parent
      height: 42.0, // Set height to match TextInput
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(8.0), // Match the TextInput border radius
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: DropdownButton<String>(
            underline: Container(),
            isDense: true,
            isExpanded: true,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            value: selected,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLevel = newValue;
                });
              }
            },
            items: itemsLevel.map<DropdownMenuItem<String>>((String level) {
              return DropdownMenuItem<String>(
                value: level,
                child: Text(level),
              );
            }).toList(),
          )),
    );
  }
}