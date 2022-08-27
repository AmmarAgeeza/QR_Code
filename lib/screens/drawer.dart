import 'package:flutter/material.dart';
import 'package:qr_code_mind_game/screens/create_qr_code_screen.dart';
import 'package:qr_code_mind_game/screens/scan_qr_code_screen.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  var currentPage = DrawerSection.Scan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drawer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ScanQRCodePage()));
                },
                child: Text('Scan Screen')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => QrGenerate()));
                },
                child: Text('Create Screen')),
            ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) => Attendance(
                  //
                  //           username: 'Ammar',
                  //           id: '1',
                  //           day: '1',
                  //           email: 'aa',
                  //         )));
                },
                child: Text('Scan Screen')),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Header_drawer(),
                DrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget DrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        ///show the list of menu drawer
        children: [
          menuItem(1, 'Scan', Icons.dashboard_outlined,
              currentPage == DrawerSection.Scan ? true : false),
          menuItem(2, 'CreateCode', Icons.dashboard_customize_outlined,
              currentPage == DrawerSection.CreateCode ? true : false),
          menuItem(3, 'LogOut', Icons.logout,
              currentPage == DrawerSection.LogOut ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage == DrawerSection.Scan;
            } else if (id == 2) {
              currentPage == DrawerSection.CreateCode;
            } else if (id == 2) {
              currentPage == DrawerSection.LogOut;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  Scan,
  CreateCode,
  LogOut,
}

class Header_drawer extends StatefulWidget {
  const Header_drawer({Key? key}) : super(key: key);

  @override
  State<Header_drawer> createState() => _Header_drawerState();
}

class _Header_drawerState extends State<Header_drawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('images/Screen5.png'))),
          ),
          const Text(
            'AmlElsayed',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          Text(
            'aml@gmail.com',
            style: TextStyle(fontSize: 15.0, color: Colors.grey[200]),
          )
        ],
      ),
    );
  }
}
