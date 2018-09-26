import 'package:flutter/material.dart';

import 'member.dart';


class MemberWidget extends StatefulWidget {
  final Member _member;

  MemberWidget(this._member);

  @override
  State<StatefulWidget> createState() => MemberState(_member);
}

class MemberState extends State<MemberWidget> {
  final Member _member;

  MemberState(this._member);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_member.login),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Image.network(_member.avatarUrl),
        )
      ),
    );
  }

}