import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delta Math',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Delta AI'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Delta Math',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your question here',
                        filled: true,
                        fillColor: Color.fromARGB(255, 83, 83, 83),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Perform action when the send icon is pressed
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                      ),
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('derivative of ur mum'),
                      onTap: () {
                        // Perform action for Item 1
                      },
                    ),
                    ListTile(
                      title: Text('surface area of my balls'),
                      onTap: () {
                        // Perform action for Item 2
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromARGB(255, 78, 78, 78),
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text(
                    'New Chat',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Perform action when the "New Chat" widget is tapped
                  },
                ),
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}