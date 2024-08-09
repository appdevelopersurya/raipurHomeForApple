import 'package:flutter/material.dart';

class NotificationSkeleton extends StatelessWidget {
  const NotificationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            tileColor: Colors.white,
            title: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 20,
              color: Colors.white,
            ),
            subtitle: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 16,
              color: Colors.white,
            ),
            leading: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
            ),
            onTap: () {
              // Handle notification tap
            },
          ),
        );
      },
    );
  }
}
