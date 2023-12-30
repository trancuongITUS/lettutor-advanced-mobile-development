import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:src/models/course.dart';
import 'package:src/models/tutor.dart';
import 'package:src/provider/authentication_provider.dart';
import 'package:src/provider/course_provider.dart';
import 'package:src/ui/auth/signin_page.dart';
import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/home/home_page.dart';
import 'package:src/ui/schedule/schedule_page.dart';
import 'package:provider/provider.dart';
import 'package:src/ui/setting/setting_page.dart';

void main() {
  runApp(const MyApp());
}

typedef SignInCallback = void Function(int appState);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<TutorModel> tutors = [];
  List<CourseModel> courses = [];
  AuthenticationProvider authenticationProvider = AuthenticationProvider();
  CourseProvider courseProvider = CourseProvider();

  Widget getWidgetByState() {
    if (null == authenticationProvider.currentUser) {
      return const SignIn();
    } else  {
      return const BottomNavBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => tutors),
        Provider(create: (context) => courses),
        ChangeNotifierProvider(create: (context) => courseProvider)
      ],
      child: MaterialApp(
          title: 'LetTutor',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthenticationProvider>(
          builder: (context, account, _) {
            return getWidgetByState();
          }
        )
      ),
    );
  }
}
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [const HomePage(), const CoursesPage(), const SchedulePage(), const HistoryPage(), const SettingPage()];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.school),
          title: ("Courses"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.calendar_month),
          title: ("Schedule"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.history),
          title: ("History"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: ("Setting"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
