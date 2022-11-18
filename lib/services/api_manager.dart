import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '/models/news_model.dart';

import '../constants/strings.dart';

class APIBloc {
  final _stateStreamSink = StreamController();
  StreamSink get _newsSink => _stateStreamSink.sink;
  Stream get newsStream => _stateStreamSink.stream;

  final _eventStreamController = StreamController();
  StreamSink get eventSink => _eventStreamController.sink;
  Stream get _eventStream => _eventStreamController.stream;

  APIBloc() {
    _eventStream.listen((event) async {
      if (event == "fetch") {
        var news = await getNews();
        _newsSink.add(news);
      }
    });
  }

  Future<News> getNews() async {
    var client = http.Client();
    dynamic newsModel;

    try {
      // newsUrl ='http://newsapi.org/v2/everything?domains=wsj.com&apiKey={YOUR_API_KEY}';

      var response = await client.get(Uri.parse(Strings.newsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = News.fromJson(jsonMap);
      }
    } on Exception {
      return newsModel;
    }

    return newsModel;
  }
}
