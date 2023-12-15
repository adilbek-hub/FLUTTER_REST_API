import 'package:api_json_playsholder2/constants.dart';
import 'package:api_json_playsholder2/model/post_model.dart';
import 'package:api_json_playsholder2/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<PostsModel>? postsModel;
  bool isLoaded = false;
  Future<void> fetchData() async {
    postsModel = await RemoteServices().fetchData();
    if (postsModel != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PostsPage'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Loading Posts from API'),
              SizedBox(height: 10.0),
              CircularProgressIndicator()
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: postsModel?.length,
          itemBuilder: (contex, index) {
            final posts = postsModel?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: Constants.postPageContainer,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 12.0,
                    ),
                    CircleAvatar(
                      radius: 24.0,
                      backgroundColor: Colors.grey,
                      child: Text(
                        posts!.id.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts.title,
                            style: Constants.titleStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(posts.body, style: Constants.postPageBody),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
