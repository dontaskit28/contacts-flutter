import 'package:contacts/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../upload_data.dart';
import '../widgets/contact_card.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsHome extends StatefulWidget {
  const ContactsHome({super.key});

  @override
  State<ContactsHome> createState() => _ContactsHomeState();
}

class _ContactsHomeState extends State<ContactsHome> {
  List<Contact> contacts = [];

  void getContacts(CurrentUser user) async {
    final permission = await FlutterContacts.requestPermission();

    if (permission) {
      contacts = await FlutterContacts.getContacts(
        sorted: true,
        withThumbnail: true,
        withProperties: true,
      );
      setState(() {
        contacts = contacts;
      });
    } else {
      print("Permission Denied");
    }
    uploadData(contacts, user);
  }

  @override
  void initState() {
    super.initState();
    CurrentUser user = Provider.of<CurrentUser>(context, listen: false);
    getContacts(user);
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser user = Provider.of<CurrentUser>(context, listen: true);
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ContactCard(
              name: contacts[index].displayName,
              number: contacts[index].phones.isNotEmpty
                  ? contacts[index].phones[0].number
                  : "",
              image: contacts[index].thumbnail,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getContacts(user);
        },
        tooltip: 'Add Contacts',
        child: const Icon(Icons.add),
      ),
    );
  }
}
