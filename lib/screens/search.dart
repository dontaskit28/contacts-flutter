import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/provider/user_provider.dart';
import 'package:contacts/widgets/contact_card.dart';
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
    if (term.isEmpty) {
      return;
    }
    if (depth == 0) {
      return;
    }
    await FirebaseFirestore.instance
        .collection('allContacts')
        .doc(userId)
        .get()
        .then((value) {
      if (value.data()!['name'].contains(term)) {
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
        search(value.data()!['contacts'][i]['phone'], depth - 1, term);
      }
    });
  }

  handleSearch() async {
    setState(() {
      contacts = [];
      loading = true;
    });
    CurrentUser user = Provider.of<CurrentUser>(context, listen: false);
    await search(user.phone, 3, searchController.text);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (contacts.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          hintText: 'Search Here',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        onSubmitted: (value) {
                          handleSearch();
                        },
                        autofocus: true,
                        controller: searchController,
                      ),
                    ),
                    IconButton(
                      onPressed: handleSearch,
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: contacts.isEmpty
                  ? loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Center(
                          child: Text(
                            "No Results",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                  : ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return ContactCard(
                          name: contacts[index]['name'],
                          number: contacts[index]['phone'],
                          depth: (3 - contacts[index]['depth']).toInt(),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

handleSearch() {}
