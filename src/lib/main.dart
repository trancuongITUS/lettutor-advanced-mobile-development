import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:src/models/user.dart';
import 'package:src/ui/auth/signin_page.dart';
import 'package:src/ui/courses/courses_page.dart';
import 'package:src/ui/home/home.dart';
import 'package:src/ui/history/history_page.dart';
import 'package:src/ui/schedule/schedule_page.dart';
import 'package:provider/provider.dart';

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
  final User account = User(email: "", password: "");
  int appState = 0;
  void loginCallback(int appState) {
    setState(() {
      this.appState = appState;
    });
  }

  Widget getWidgetByState() {
    if (appState == 0) {
      return SignIn(loginCallback);
    } else  {
      return const BottomNavBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => account),
      ],
      child: MaterialApp(
          title: 'LetTutor',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: Consumer<User>(
          builder: (context, account, _) {
            return getWidgetByState();
          }
        )
      ),
    );
  }
}
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return const [Home(), Courses(), Schedule(), History()];
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
