import 'package:api_json_playsholder2/model/photos_model.dart';
import 'package:api_json_playsholder2/services/remote_services.dart';
import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<PhotoModel>? photoModel;
  bool isLoaded = false;

  Future<void> getDatas() async {
    photoModel = await RemoteServices().photosFromJson();
    if (photoModel != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('PhotoPage'),
        ),
        body: Visibility(
            visible: isLoaded,
            replacement: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoaded.toString(),
                  ),
                  const Text('Сизде азырынча күтүү режими'),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Image.network(photoModel![index].thumbnailUrl);
              },
            )));
  }
}
