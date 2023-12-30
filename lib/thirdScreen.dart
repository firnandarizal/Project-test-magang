import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class User {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<User> users = [];
  int currentPage = 1;
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  Future<void> fetchData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=6'),
      headers: {'Accept': 'application/json'},
    );

    setState(() {
      isLoading = false;
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userList = data['data'] as List;
        users.addAll(userList.map((json) => User.fromJson(json)));
        currentPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            fetchData();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            users.clear();
            currentPage = 1;
            await fetchData();
          },
          child: users.isEmpty
              ? (isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Center(child: Text('No data available')))
              : ListView.builder(
                  itemCount: users.length + 1,
                  itemBuilder: (context, index) {
                    if (index == users.length) {
                      if (isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(); // This is an empty state when there's no data
                      }
                    } else {
                      final user = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text('${user.firstName} ${user.lastName}',
                            style: GoogleFonts.poppins(fontSize: 16)),
                        subtitle: Text(
                          user.email,
                          style: GoogleFonts.poppins(),
                        ),
                        onTap: () {
                          Navigator.pop(
                              context, user.firstName + ' ' + user.lastName);
                        },
                      );
                    }
                  },
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                ),
        ),
      ),
    );
  }
}
