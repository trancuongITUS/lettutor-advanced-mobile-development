import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/home/home_page.dart';
import 'package:src/ui/profiles/profile_page.dart';
import 'package:src/ui/schedule/schedule_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String selectedLanguage = 'Automatic';
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 125,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue, border: null),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.close_outlined,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const Text(
                          "Menu",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          "",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.people_alt,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'Tutors',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.school,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'Courses',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CoursesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'Schedule',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Schedule()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text(
                'History',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const History()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.blue.shade700,
                size: 30,
              ),
              title: const Text('Logout',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
              onTap: () {
                var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
                authenticationProvider.clearUserInfo();
              },
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness:
                    Brightness.light,
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        size: 45,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 7),
                      Text(
                        "LetTutor",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            BigUserCard(
              backgroundColor: Colors.blue,
              userName: "Hồ Duy Bảo",
              userProfilePic: const NetworkImage(
                  "https://yt3.googleusercontent.com/mm2-5anuZ6ghmK2zL6QM7wciD6kuupOfOagiAh5vZE1hx9tRhKEXTAExZUUY4PVq2RSw9jBpBQ=s900-c-k-c0x00ffffff-no-rj",
                  scale: 1),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.blue[600],
                ),
                title: "Profile",
                subtitle: "Tap to change your profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: "App Settings",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.grey,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
                SettingsItem(
                    onTap: () {},
                    icons: Icons.language,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.grey,
                    ),
                    title: 'Language',
                    subtitle: selectedLanguage,
                    trailing: Container(
                      width: 120,
                      height: 42.0,
                      alignment: Alignment.center,
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
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLanguage = newValue!;
                            });
                          },
                          items: <String>['English', 'Vietnamese']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.wallet,
                  iconStyle: IconStyle(),
                  title: 'My Wallet',
                  subtitle: "Manage your wallet",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.co_present,
                  iconStyle: IconStyle(),
                  title: 'Become a tutor',
                  subtitle: "How to become a tutor",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Overview",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about LetTutor App",
                ),
                SettingsItem(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Log out successful!.'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    var authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);
                    authenticationProvider.clearUserInfo();
                  },
                  icons: Icons.logout,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.red,
                  ),
                  title: 'Logout',
                  subtitle: "Log out LetTutor app",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}