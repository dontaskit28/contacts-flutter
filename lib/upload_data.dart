import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/provider/user_provider.dart';
import 'package:flutter_contacts/contact.dart';

void uploadData(List<Contact> contacts, CurrentUser user) async {
  WriteBatch batch = FirebaseFirestore.instance.batch();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  for (int i = 0; i < contacts.length; i++) {
    contacts[i].phones[0].number = contacts[i]
        .phones[0]
        .number
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
    batch.set(
      firestore.doc('allContacts/${contacts[i].phones[0].number}'),
      {
        'phone': contacts[i].phones[0].number,
        'email':
            contacts[i].emails.isEmpty ? "" : contacts[i].emails[0].address,
        'name': contacts[i].displayName,
        'tags': contacts[i].notes,
        'contacts': [],
      },
    );
  }

  batch.set(
      firestore.doc('allContacts/${user.phone}'),
      {
        'contacts': contacts
            .map((e) => {
                  'phone': e.phones[0].number,
                  'email': e.emails.isEmpty ? "" : e.emails[0].address,
                  'name': e.displayName,
                  'tags': e.notes,
                })
            .toList(),
      },
      SetOptions(merge: true));
  await batch.commit();
}
