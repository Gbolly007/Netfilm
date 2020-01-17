import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'userAccount.dart';

class cardInput extends StatelessWidget {
  const cardInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: ListTile(
          leading: Icon(
            Icons.movie,
            color: Colors.black26,
          ),
          title: Text(
            'E.g London Has Fallen',
            style: TextStyle(
              color: Colors.black26,
              fontFamily: 'SourceSansPro',
              fontSize: 20.0,
            ),
          ),
        ));
  }
}

class rowHeader extends StatelessWidget {
  const rowHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        Image.asset(
          "images/Netfilmban.png",
          height: 60.0,
          width: 130.0,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserAccount()));
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(kprofileImage),
          ),
        )
      ],
    );
  }
}
