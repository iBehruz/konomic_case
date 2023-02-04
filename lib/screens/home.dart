import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 60,
            child: InkWell(
                onTap: (){},
                child: const ListTile(
                  title: Text("BTC", style: TextStyle(fontSize: 30),),
                  leading: Icon(Icons.snowboarding, size: 30,),
                  trailing: Icon(Icons.arrow_drop_down, size: 30, color: Colors.grey),))),
            Container(
              height: 100, child: Row(
                children: const [
                  Expanded(child: Divider(color: Color.fromRGBO(64, 66, 91, 1.0),)),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(64, 66, 91, 1.0),
                      child: Icon(Icons.arrow_downward_outlined, color: Colors.white,),),
                  ),
                  Expanded(child: Divider(color: Color.fromRGBO(64, 66, 91, 1.0),)),
                ],
              ),
            ),
            Container(

                height: 60,
                child: InkWell(
                    onTap: (){},
                    child: const ListTile(
                      title: Text("BTC", style: TextStyle(fontSize: 30),),
                      leading: Icon(Icons.snowboarding, size: 30, ),
                      trailing: Icon(Icons.arrow_drop_down, size: 30, color: Colors.grey,),))),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50,
          child: ElevatedButton(
            onPressed: () {  }, child: const Text("WATCH"),),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
