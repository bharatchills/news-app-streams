import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsBloc = APIBloc();

  @override
  void initState() {
    newsBloc.eventSink.add("fetch");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: newsBloc.newsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var articles = snapshot.data!.articles;
                return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          minLeadingWidth: 10,
                          leading: Text(index.toString()),
                          title: Text(articles![index].title ?? "Loading"),
                          subtitle: Text(
                            articles[index].description ?? "Loading",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.4)),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
