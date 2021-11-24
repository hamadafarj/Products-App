import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const loginScrren = '/';

const registerScrren = '/registerScrren';

const homeScrren = '/homeScrren';

const editProduct = '/editProduct';

const addProduct = '/addProduct';

const myCard = '/myCard';

class MyDrawer extends StatelessWidget {
  //final User user;
  const MyDrawer({
    Key? key,
    //required this.user
  }) : super(key: key);
  Widget buildDrawerHeader(context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "https://i.pinimg.com/originals/b7/97/c2/b797c291974ce4d3dd731492393fbc6d.png",
            ),
          ),
        ),
        Text(
          "user.displayName.toString()",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "user.email.toString()",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: Colors.green,
      ),
      title: Text(title),
      trailing: trailing ??= const Icon(
        Icons.arrow_right,
        color: Colors.green,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return const Divider(
      height: 0,
      thickness: 1,
      indent: 18,
      endIndent: 24,
    );
  }

  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Widget buildIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Icon(
        icon,
        size: 35,
      ),
    );
  }

  Widget buildLogoutBlocProvider(context) {
    return Container(
      child: buildDrawerListItem(
        leadingIcon: Icons.logout,
        title: 'Logout',
        onTap: () async {
          // await phoneAuthCubit.logOut();
          Navigator.of(context).pushReplacementNamed(loginScrren);
        },
        color: Colors.red,
        trailing: const SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      SizedBox(
        height: 280,
        child: DrawerHeader(
          decoration: BoxDecoration(color: Colors.green[100]),
          child: buildDrawerHeader(context),
        ),
      ),
      buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
      buildDrawerListItemsDivider(),
      buildDrawerListItem(
        leadingIcon: Icons.history,
        title: 'My Card',
        onTap: () {
          Navigator.pushNamed(context, myCard);
        },
      ),
      buildDrawerListItemsDivider(),
      buildDrawerListItem(
        leadingIcon: Icons.settings,
        title: 'Settings',
      ),
      buildDrawerListItemsDivider(),
      buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
      buildDrawerListItemsDivider(),
      buildLogoutBlocProvider(context),
    ]));
  }
}
