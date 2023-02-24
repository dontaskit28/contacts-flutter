import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/provider/user_provider.dart';
import 'package:flutter_contacts/contact.dart';

void uploadData(List<Contact> contacts, CurrentUser user) async {
  WriteBatch batch = FirebaseFirestore.instance.batch();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('allContacts').get();
  final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;

  List ids = documentSnapshots.map((snapshot) => snapshot.id).toList();

  for (int i = 0; i < contacts.length; i++) {
    if (i % 70 == 0) {
      await batch.commit();
      batch = FirebaseFirestore.instance.batch();
    }
    contacts[i].phones[0].number = contacts[i]
        .phones[0]
        .number
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');

    if (ids.contains(contacts[i].phones[0].number)) {
      continue;
    }
    batch.set(
      firestore.doc('allContacts/${contacts[i].phones[0].number}'),
      {
        'phone': contacts[i].phones[0].number,
        'email':
            contacts[i].emails.isEmpty ? "" : contacts[i].emails[0].address,
        'name': contacts[i].displayName,
        'tags': [],
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
                  'tags': [],
                })
            .toList(),
      },
      SetOptions(merge: true));
  await batch.commit();
}
