import 'package:coruscate_app_task/Model/data.dart';
import 'package:coruscate_app_task/Services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page_no;

  @override
  void initState() {
    super.initState();
    page_no = Random().nextInt(100);
  }

  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff111517),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Coruscate App Task",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff111517),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: _apiServices.getData(
                      "https://picsum.photos/v2/list?page=${page_no}&limit=10"),
                  builder: (context, AsyncSnapshot<List<Data>> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        crossAxisCount: 2,
                        children: snapshot.data.map((e) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: e.downloadUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page_no = Random().nextInt(100);
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Prev.",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page_no = Random().nextInt(100);
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
