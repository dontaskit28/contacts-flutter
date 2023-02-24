import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List contacts = [];
  TextEditingController searchController = TextEditingController();
  bool loading = false;

  search(String userId, int depth, String term) async {
    if (depth == 0) {
      return;
    }
    FirebaseFirestore.instance
        .collection('allContacts')
        .doc(userId)
        .get()
        .then((value) {
      if (value.data()!['name'].contains(term)) {
        print(value.data()!['name']);
        contacts.add({
          'name': value.data()!['name'],
          'phone': value.data()!['phone'],
          'depth': depth,
        });
        setState(() {
          contacts = contacts;
          loading = false;
        });
      }
      if (value.data()!['contacts'].length == 0) {
        return;
      }

      for (int i = 0; i < value.data()!['contacts'].length; i++) {
        search(value.data()!['contacts'][i], depth - 1, term);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser user = Provider.of<CurrentUser>(context, listen: true);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    border: InputBorder.none,
                    hintText: 'Search Here',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                  controller: searchController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    contacts = [];
                    loading = true;
                  });
                  search(user.phone, 3, searchController.text);
                  setState(() {
                    loading = false;
                  });
                },
                child: const Text('Search'),
              ),
            ],
          ),
          contacts.isEmpty
              ? const Center(
                  child: Text(
                    'No Results Found',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              : loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(contacts[index]['name']),
                            subtitle: Text(contacts[index]['phone']),
                            leading: CircleAvatar(
                              child: Text(
                                (3 - contacts[index]['depth']).toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    ));
  }
}
