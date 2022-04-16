
import 'package:audio_player_flutter/audio_url_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              RaisedButton(
                child: Text("audio from url"),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AudioUrlPage()),
                    );
                  }),

              SizedBox(height: 10,),
              RaisedButton(
                  child: Text("audio from asset"),
                  onPressed: (){

                  }),

              SizedBox(height: 10,),

              RaisedButton(
                  child: Text("audio from file"),
                  onPressed: (){

                  }),

            ],
          ),
        ),
      ),
    );
  }
}
