
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _news = [];
  String _selectedCategory = 'national'; 

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    http.Response response;
    response = await http.get(
        Uri.parse('https://inshortsapi.vercel.app/news?category=$_selectedCategory'));
   
    if (response.statusCode == 200) {
      setState(() {
        _news = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        
        
        title: Text('News'),
        actions: [
          PopupMenuButton(
            onSelected: (String category) {
              setState(() {
                _selectedCategory = category;
                _fetchNews();
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'all',
                child: Text('All'),
              ),
              PopupMenuItem(
                value: 'national',
                child: Text('National'),
              ),
              PopupMenuItem(
                value: 'business',
                child: Text('Business'),
              ),
              PopupMenuItem(
                value: 'sports',
                child: Text('Sports'),
              ),
                PopupMenuItem(
                value: 'world',
                child: Text('Worlds'),
              ),
                PopupMenuItem(
                value: 'politics',
                child: Text('Politics'),
              ),
              PopupMenuItem(
                value: 'technology',
                child: Text('Technology'),
              ),
              PopupMenuItem(
                value: 'startup',
                child: Text('Startup'),
              ),
              PopupMenuItem(
                value: 'entertainment',
                child: Text('Entertainment'),
              ),
              PopupMenuItem(
                value: 'miscellaneous',
                child: Text('Miscellaneous'),
              ),

              
            
            ],
          ),
        ],
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                return NewsCard(_news[index]);
              },
            ),
    );
  }
}

class NewsCard extends StatelessWidget {
  
  final dynamic news;

  NewsCard(this.news);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                  news['time'], 
                  style: TextStyle(
                    
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    news['url'], 
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              news['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              news['content'],
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
              ],
            ),
          ),
          if (news['imageUrl'] != null) // Assuming 'imageUrl' is a field in your JSON
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(
                news['imageUrl'],
                height: 140, 
                width: double.infinity, 
                fit: BoxFit.cover, 
              ),
            ),
        ],
      ),
    );
  }
}


















