import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nigeriannews/model/articles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nigeriannews/views/health.dart';
import 'package:nigeriannews/views/themestate.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:nigeriannews/viewsmodel/news.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isLoading;
//   var newsList;

//   void getnews() async {
//     News news = News();
//     await news.getNews();
//     setState(() {
//       isLoading = false;
//       newsList = news.news;
//     });
//   }

//   @override
//   void initState() {
//     isLoading = true;
//     super.initState();
//     getnews();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Center(
//             child: Text(
//           'TopNews',
//           style: TextStyle(color: Colors.black),
//         )),
//       ),
//        body:
//       SafeArea(
//         child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: 20.0,
//             ),
//             child: isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Column(
//                     children: <Widget>[

//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: newsList.length,
//                           itemBuilder: (context, index) {
//                             return ExpansionTile(
//                               title: Text(newsList[index].title),
//                               children: <Widget>[
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                   child: Column(
//                                     children: <Widget>[
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: <Widget>[

//                                           IconButton(
//                                               icon: Icon(Icons.launch),
//                                               onPressed: () async{
//                                                 final fakeurl =
//                                                     "${newsList[index].url}";
//                                                 if (await canLaunch(fakeurl)) {
//                                                   launch(fakeurl);
//                                                 }else{
//                                                   throw 'could not launch url';
//                                                 }

//                                               })
//                                           // Text( newsList[index].url)
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],

//                               // subtitle: Text(
//                               //  newsList[index].url
//                               // ),
//                               leading:
//                                   Container(
//                                     width: 70,
//                                     height: 70,
//                                     child: Image.network(newsList[index].urlToImage,
//                                     fit: BoxFit.contain,
//                                     ),
//                                   ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   )),
//       ),
//       bottomNavigationBar: CupertinoTabBar(

//         backgroundColor: Colors.black,
//         activeColor: Colors.white,
//          items:  [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.event_note),
//         title: Text('Naija news')
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.extension),
//         title: Text('Foreign news')
//       ),
//       ]),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _currentindex =0;
  Future<News> sportsnews;
  
  @override
  void initState() {
    sportsnews = HttpService.getSportsNews();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier= Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.flare,
          color: Colors.red,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Top News',
            style: GoogleFonts.cherrySwash(
              textStyle: TextStyle(color: Colors.red),
            ),
          ),
        ),
        actions: <Widget>[
          Switch(
             activeColor: Colors.black,
              value: themeNotifier.isdarkTheme,
             onChanged: (value){
               
               
                 themeNotifier.setThemeData =value ;
               
             }
             )
          // Container(
          //   width: 170,
          
          //   child: DayNightSwitch(
          //     value: themeNotifier.isLightTheme,
          //    onChanged: (value){
          //       setState(() {
          //         value= themeNotifier.setThemeData=value;
          //       });
          //    }),
          // )
        ],
      ),
      body: FutureBuilder<News>(
          future: sportsnews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(snapshot.data.articles[index].title,
                          style: GoogleFonts.cormorantGaramond()),
                      leading: Container(
                          width: 70,
                          height: 70,
                          child: Image.network(
                            snapshot.data.articles[index].urlToImage,
                            fit: BoxFit.contain,
                          )),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                           // Text('Author: ${snapshot.data.articles[index].author ?? 0 } '),
                            IconButton(
                              icon: Icon(
                                Icons.launch,
                                size: 20,
                              ),
                              onPressed: () async {
                                final url =
                                    '${snapshot.data.articles[index].url}';
                                if (await canLaunch(url)) {
                                  launch(url);
                                } else {
                                  throw 'cant launch url';
                                }
                              },
                            )
                          ],
                        )
                      ],
                    );
                  });
            } else {
              if (snapshot.error) {
                print(snapshot.error);
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              title: Text('Sports'),
            ),
            BottomNavigationBarItem(
              
              icon: IconButton(
                icon: Icon(Icons.healing),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Health()));
                },
              ),
              title: Text('Health'),
            ),
            
          ],
          onTap: (index){
           
            setState(() {
              _currentindex = index;
            });
          },
          ),
    );
  }
}
