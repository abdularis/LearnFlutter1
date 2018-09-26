import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'member.dart';
import 'member_widget.dart';

class GithubOrgMember extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GithubOrgMember();
}

class _GithubOrgMember extends State<GithubOrgMember> {
  final _textController = TextEditingController();
  var _members = <Member>[];
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Github Organization Member"),
        ),
        body: _buildBodyPart());
  }

  Widget _buildInputForm() {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, size: 32.0,),
            onPressed: _loadDataFromInput,
          )
        ],
      ),
    );
  }

  Widget _buildMembersStat() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text("How many members?: ${_members.length}"),
      ),
    );
  }

  Widget _buildListContent() {
    if (_loading) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: _members.length * 2,
          itemBuilder: (context, idx) {
            if (idx.isOdd) return Divider(
              height: 1.0,
            );
            idx = idx ~/ 2;
            return _buildRowItem(idx);
          }
      ),
    );
  }

  Widget _buildBodyPart() {
    return Column(
      children: <Widget>[
        _buildInputForm(),
        _buildMembersStat(),
        _buildListContent()
      ],
    );
  }

  Widget _buildRowItem(index) {
    return ListTile(
      title: Text(_members[index].login),
      leading: CircleAvatar(
        backgroundColor: Colors.greenAccent,
        backgroundImage: NetworkImage(_members[index].avatarUrl),
      ),
      subtitle: Text(_members[index].url),
      onTap: () { _pushMember(_members[index]); },
    );
  }

  _loadDataFromInput() {
    final org = _textController.text;
    _loadData(org);
  }

  _loadData(orgName) async {
    setState(() {
      _loading = true;
    });

    final url = "https://api.github.com/orgs/$orgName/members";
    print("Loading data from $url ...");
    http.Response response = await http.get(url);
    setState(() {
      _members.clear();
      final membersJson = json.decode(response.body);
      for (final member in membersJson) {
        _members.add(
            Member(member["login"], member["avatar_url"], member["html_url"]));
      }
      _loading = false;

      print("Data loaded from $url");
    });
  }

  _pushMember(member) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MemberWidget(member))
    );
  }
}
