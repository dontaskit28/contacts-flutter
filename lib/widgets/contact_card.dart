import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactCard extends StatefulWidget {
  final String name;
  final String number;
  final Uint8List? image;
  const ContactCard(
      {super.key, required this.name, required this.number, this.image});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: widget.image != null
                    ? Image.memory(widget.image!).image
                    : const NetworkImage(
                        'https://www.w3schools.com/howto/img_avatar.png'),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(widget.number)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
