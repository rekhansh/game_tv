import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_tv/models/tournament.dart';
import 'package:game_tv/models/user.dart';
import 'package:game_tv/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //Theme Data
  IconThemeData _customIconTheme() {
    ThemeData original = ThemeData.light();
    return original.iconTheme.copyWith(color: Colors.black);
  }
  final TextStyle tournamentNumberTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 17,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );
  final TextStyle tournamentDetailsTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      height: 1.25,
      fontWeight: FontWeight.w400);
  var _tournaments = <Tournament>[];

  //User Data
  final User user = User("Simon Baker","",2250,34,9);
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }


  //UI
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              title: Text("Log out"),
              onTap: logout,
            )
          ],
        )),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Center(
            child: Text(
              'Flyingwolf',
              style: TextStyle(color: Colors.black),
            ),
          ),
          iconTheme: _customIconTheme(),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/simon baker.jpg'),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: Text(user.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.9))),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blue),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(32)),
                                  ),
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      Padding(
                                        child: Text(
                                          user.eloPoints.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue),
                                        ),
                                        padding: EdgeInsets.all(4),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 8, 16, 8),
                                        child: Text(
                                          "Elo rating",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.orange,
                                          Colors.orange.withOpacity(0.5)
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight),
                                    borderRadius: BorderRadius.horizontal(
                                        left: const Radius.circular(16))),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      user.tournamentsPlayed.toString(),
                                      style: tournamentNumberTextStyle,
                                    ),
                                    Text(
                                      "Tournaments played",
                                      textAlign: TextAlign.center,
                                      style: tournamentDetailsTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Colors.deepPurple,
                                      Colors.deepPurple.withOpacity(0.5)
                                    ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight)),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      user.tournamentsWon.toString(),
                                      style: tournamentNumberTextStyle,
                                    ),
                                    Text(
                                      "Tournaments won",
                                      textAlign: TextAlign.center,
                                      style: tournamentDetailsTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.deepOrange,
                                          Colors.deepOrange.withOpacity(0.5)
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight),
                                    borderRadius: BorderRadius.horizontal(
                                        right: const Radius.circular(16))),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      "${user.getPercentage()}%",
                                      style: tournamentNumberTextStyle,
                                    ),
                                    Text(
                                      "Winning Percentage",
                                      textAlign: TextAlign.center,
                                      style: tournamentDetailsTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_tournaments.length > 0)
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Text(
                                "Recommended for you",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                )
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == _tournaments.length - _nextPageThreshold) {
                  if(_hasMoreData)
                    fetchTournaments();
                }
                if (index == _tournaments.length) {
                  if (_error) {
                    return Center(
                        child: Column(
                          children: [Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text("Error while loading"),
                          ),
                          OutlineButton(
                            child: Text("Retry"),
                            onPressed: (){
                              setState(() {
                                _loading = true;
                                _error = false;
                                fetchTournaments();
                              });
                            },
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor
                            ),
                          )]
                        ));
                  } else if(_loading){
                    return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ));
                  }
                }
                if (index > _tournaments.length) {
                  return null;
                }
                return _buildRow(_tournaments[index]);
              }),
            )
          ],
        ));
  }

  Widget _buildRow(Tournament tournament) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/background.jpg',
            image: tournament.coverUrl,
            height: 100,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          tournament.name,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        Text(
                          tournament.gameName,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.6)),
                        )
                      ],
                    )),
                    Icon(Icons.chevron_right)
                  ],
                ),
              )),
        ],
      ),
    );
  }


  //HTTP Requests Data
  Future<void> fetchTournaments() async {
    try {
      final response = await http.get(
          'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$_cursor');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        parseTournaments(json.decode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        // throw Exception('Failed to load album');
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  String _cursor = "";
  bool _loading = true;
  int _nextPageThreshold = 5;
  bool _hasMoreData = true;
  bool _error = false;

  void parseTournaments(Map<String, dynamic> json) {
    var tournamentsObj = json["data"]["tournaments"] as List;
    var tournaments = <Tournament>[];
    tournamentsObj.forEach((element) {
      tournaments.add(Tournament.fromJson(element));
    });
    setState(() {
      _cursor = json["data"]["cursor"];
      _hasMoreData = tournaments.length == 10;
      _loading = false;
      _tournaments.addAll(tournaments);
      _error= false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTournaments();
  }
}
