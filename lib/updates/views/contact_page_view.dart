import 'package:flutter/material.dart';

class ContactPageView extends StatefulWidget {
  const ContactPageView({super.key});

  @override
  State<ContactPageView> createState() => _ContactPageViewState();
}

class _ContactPageViewState extends State<ContactPageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'For Contact - engrmonirulislam513@gmail.com',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
