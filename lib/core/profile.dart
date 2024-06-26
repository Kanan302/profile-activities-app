import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/popups.dart';

class ProfileInfo {
  static void show(BuildContext context, List<String>? reasons,
      List<Map<String, dynamic>> data, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profil',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset(data[index]['profile_img']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${data[index]['name']}, ${data[index]['age']}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (data[index]['badge'] != null &&
                        data[index]['badge'] != '')
                      SvgPicture.asset(data[index]['badge'])
                  ],
                ),
                Text(
                  data[index]['status'] ?? '',
                  style: const TextStyle(color: Color(0xFF919191)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 78,
                  height: 32,
                  child: Image.asset('assets/images/png/likebutton.png'),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bio',
                      style: TextStyle(
                        color: Color(0XFF919191),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 350,
                      child: Text(
                        data[index]['bio_text'],
                        style: const TextStyle(
                          color: Color(0xFF5E5E5E),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE6A57),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(300, 48),
                      ),
                      child: const Text(
                        'Mesaj göndər',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_horiz),
                      onSelected: (value) {
                        Navigator.pop(context);
                        switch (value) {
                          case 0:
                            Popup.handleNotification(context);
                            break;
                          case 1:
                            Popup.handleBlock(context);
                            break;
                          case 2:
                            Popup.showComplaintModal(context, reasons ?? []);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          value: 0,
                          child: ListTile(
                            leading: Icon(Icons.notifications_off_outlined),
                            title: Text('Bildirişləri bağla'),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            leading: Icon(Icons.block),
                            title: Text('Blokla'),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            leading: Icon(Icons.flag, color: Colors.red),
                            title: Text(
                              'Şikayet Et',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
