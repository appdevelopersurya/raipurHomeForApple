import 'package:flutter/material.dart';

class ListViewBuilderSkeleton extends StatelessWidget {
  const ListViewBuilderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 20,
                        color: Colors.white,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 20,
                        color: Colors.white,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
