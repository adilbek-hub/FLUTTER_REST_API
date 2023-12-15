import 'package:flutter/material.dart';

import 'package:search_movers/screens/user_details_page.dart';

class UserTile extends StatelessWidget {
  UserTile({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  // String userTitle() {
  //   String title = "";
  //   if (user.gender == "Male") {
  //     title = "Mr.";
  //   } else if (user.gender == "Female") {
  //     title = "Ms.";
  //   }
  //   return title;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: movie.data![0].id ?? '',
              child: CircleAvatar(
                  backgroundImage: NetworkImage(movie.data![0].coverUrl ?? '')),
            ),
            title: Text(
                '${movie.data![0].chronology} ${movie.data![0].boxOffice} ${movie.data![0].overview}'),
            subtitle: Text(movie.data![0].phase.toString()),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UserDetailsPage(user: user)));
            },
          ),
          const Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
