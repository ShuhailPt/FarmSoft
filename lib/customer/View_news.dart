import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const News_c_view());
}

class News_c_view extends StatelessWidget {
  const News_c_view({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEWS',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const News_c_view_page(title: 'NEWS'),
    );
  }
}

class News_c_view_page extends StatefulWidget {
  const News_c_view_page({Key? key, required this.title});

  final String title;

  @override
  State<News_c_view_page> createState() => _News_c_view_pageState();
}

class _News_c_view_pageState extends State<News_c_view_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEWS'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: _getdata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("snapshot" + snapshot.toString());
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Card(
                      child: Container(
                        height: 300,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 4.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Text(
                                snapshot.data[index].title,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Flexible(
                              child: SingleChildScrollView(
                                child: Text(
                                  snapshot.data[index].news,
                                  style: const TextStyle(fontSize: 16.0),
                                  maxLines: null, // Allow multiple lines
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data[index].date,
                                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.black54,),

                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<JsService>> _getdata() async {
    final sh = await SharedPreferences.getInstance();
    String Url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();
    var data = await http.post(Uri.parse(Url + "far_news_view"), body: {
      'lid': lid,
    });
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<JsService> jokes = [];
    for (var i in jsonData["data"]) {
      print(i);
      JsService newname = JsService(i['title'].toString(),
          i['news'].toString(), i['date'].toString(), i['type'].toString());
      jokes.add(newname);
    }
    return jokes;
  }
}

class JsService {
  late final String title;
  late final String news;
  late final String date;
  late final String type;
  JsService(this.title, this.news, this.date, this.type);
}
