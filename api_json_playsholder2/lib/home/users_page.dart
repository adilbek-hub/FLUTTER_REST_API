import 'package:api_json_playsholder2/constants.dart';
import 'package:api_json_playsholder2/services/remote_services.dart';
import 'package:api_json_playsholder2/model/user_model.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool isLoaded = false;
  List<UsersModel>? user;
  Future<void> getDats() async {
    user = await RemoteServices().userFromJson();
    if (user != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getDats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('UsersPage'),
      ),
      body: Visibility(
          visible: isLoaded,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Загрузка'),
              Constants.height10,
              const Center(child: CircularProgressIndicator()),
            ],
          ),
          child: ListView.builder(
              itemCount: user?.length,
              itemBuilder: (context, index) {
                final users = user?[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: 300,
                    height: 250,
                    decoration: Constants.usersPageContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Constants.height10,
                          Text(users!.title),
                          // Id
                          Constants.height10,
                          Row(
                            children: [
                              Text(
                                'ID :',
                                style: Constants.userPageText,
                              ),
                              Text(
                                users.id.toString(),
                                style: Constants.userPageText,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Constants.height20,
                              Text(
                                'Name :',
                                style: Constants.userPageText,
                              ),
                              Text(
                                users.userId.toString(),
                                style: Constants.userPageText,
                              ),
                            ],
                          ),
                          Text(users.body),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
