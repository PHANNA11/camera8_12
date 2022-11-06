import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ImageSlideshow(
            autoPlayInterval: 3000,
            isLoop: true,
            initialPage: 0,
            children: [
              Image.network(
                  'https://imgs.search.brave.com/jZGgbg1Od_fjbHKWDlVSw3MKw74oAMl0glZtqbazGK4/rs:fit:1024:820:1/g:ce/aHR0cHM6Ly9ibG9n/LjFwb3J0cmFpdC5p/ZS93cC1jb250ZW50/L3VwbG9hZHMvMjAy/MC8wOC8xcG9ydHJh/aXQtcHJvZmVzc2lv/bmFsLWJ1c2luZXNz/LWhlYWRzaG90cy1s/aW5rZWRpbi0xMDI0/eDgyMC5qcGc'),
              Image.network(
                  'https://imgs.search.brave.com/OQvV1mtKaMf6Elt1qnVLmscHPTIvPBNuhsF_kdVwd2o/rs:fit:1024:683:1/g:ce/aHR0cHM6Ly9jaGlj/YWdvcGhvdG92aWRl/by5jb20vd3AtY29u/dGVudC91cGxvYWRz/LzIwMTgvMDEvcGhv/dG9ncmFwaHktZm9y/LWxpbmtlZGluLXBy/b2Zlc3Npb25hbC1w/cm9maWxlLTEwMjR4/NjgzLmpwZw'),
            ],
          ),
          Container(
            height: 300,
            width: double.infinity,
            child: fileImage == null
                ? const SizedBox()
                : Image(image: FileImage(File(fileImage!.path))),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              getImageFromGallary();
            },
            child: const Icon(Icons.image),
          ),
          FloatingActionButton(
            onPressed: () {
              openCamera();
            },
            child: const Icon(Icons.camera_alt_outlined),
          )
        ],
      ),
    );
  }

  Future getImageFromGallary() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      fileImage = File(file!.path);
    });
  }

  Future openCamera() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      fileImage = File(file!.path);
    });
  }
}
