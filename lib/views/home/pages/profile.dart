import 'package:flutter/material.dart';
import '../../../services/auth.dart';

enum MenuOptions { editProfile, changePassword, aboutUs, logout }

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AuthService auth = AuthService();

    return ListView(children: [
      Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: 200.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/temp/profile_cover.jpg'),
                    fit: BoxFit.cover)),
          ),
          Positioned(
              child: Container(
            margin: const EdgeInsets.only(top: 200.0),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
            padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<MenuOptions>(
                      onSelected: (option) {
                        if(option == MenuOptions.logout) {
                          auth.signOut();
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<MenuOptions>>[
                        const PopupMenuItem<MenuOptions>(
                          value: MenuOptions.editProfile,
                          child: Text('Edit Profile'),
                        ),
                        const PopupMenuItem<MenuOptions>(
                          value: MenuOptions.changePassword,
                          child: Text('Change password'),
                        ),
                        const PopupMenuItem<MenuOptions>(
                          value: MenuOptions.aboutUs,
                          child: Text('About us'),
                        ),
                        PopupMenuItem<MenuOptions>(
                          value: MenuOptions.logout,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Logout'),
                              Icon(Icons.logout)
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                const Text('John Doe',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.room, size: 14.0),
                    SizedBox(width: 5.0),
                    Text('55, Madison Square boulevard, New York',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey))
                  ],
                ),
                const SizedBox(height: 6.0),
                const Text(
                    '"Rare books collector, cats lover and a recovering book worm"',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0)),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Indicator(icon: Icons.remove_red_eye, value: '223'),
                    Indicator(icon: Icons.book, value: '12'),
                    Indicator(icon: Icons.bookmark, value: '5'),
                  ],
                )
              ],
            ),
          )),
          Positioned(
            top: 100.0,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.0)),
              child: const CircleAvatar(
                radius: 70.0,
                backgroundImage:
                    AssetImage('assets/images/temp/profile_picture.jpg'),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 18.0),
      GridView.count(
        childAspectRatio: 0.65,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(14.0),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 32.0,
        crossAxisSpacing: 16.0,
        children: const [
          Book(author: 'Nassim Nicholas', title: 'Antifragile: Things That Gain From Disorder Antifragile: Things That Gain From Disorder', cover: AssetImage('assets/images/temp/book_cover.jpg')),
        ],
      ),
      const SizedBox(height: 28.0)
    ]);
  }
}

class Indicator extends StatelessWidget {
  const Indicator({Key? key, required this.icon, required this.value})
      : super(key: key);

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 6.0),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))
      ],
    );
  }
}

class Book extends StatelessWidget {
  const Book({
    Key? key, this.cover, required this.title, required this.author
  }) : super(key: key);

  final ImageProvider? cover;
  final String title;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cover == null ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(title)),
            Column(
              children: [
                Divider(color: Colors.grey[400], thickness: 2.0, indent: 10.0, endIndent: 10.0),
                Text(author , textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ) : null,
      decoration: BoxDecoration(
          color: Colors.white,
          image: cover != null ? DecorationImage(image: cover!) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 6,
            )
          ]),
    );
  }
}
