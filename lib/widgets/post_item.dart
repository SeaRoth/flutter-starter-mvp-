import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:flutterstarter/data/models/Post.dart';
import 'package:flutterstarter/screens/profile_screen.dart';
import 'package:timeago/timeago.dart';

class PostItem extends StatelessWidget{
  const PostItem({Key key,this.firestore, this.post, this.onTapLike, this.onTapComment, this.onTapShare, this.onTapPost,});
  final Firestore firestore;
  final DocumentSnapshot post;
  final VoidCallback onTapPost;
  final VoidCallback onTapLike;
  final VoidCallback onTapComment;
  final VoidCallback onTapShare;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle = theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    var username = "";


    TimeAgo ta = new TimeAgo();
    final comments = post['comments'];

    if(comments != null)
      print("there are ${comments.length} total comments");

    return new StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('users').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(child: const Text('Loading...'));
      var _userWhoPostedTheShits = snapshot.data.documents.firstWhere((it) => it.documentID == post['userId']);
      username = _userWhoPostedTheShits['name'];

      return new Container(
        padding: const EdgeInsets.all(4.0),
        child: new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.all(6.0),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      child: new GestureDetector(
                        child: new CircleAvatar(
                          backgroundImage:
                          new Image(
                            image: new NetworkImageWithRetry(
                                _userWhoPostedTheShits['imageUrl']),
                          ).image,
                          radius: 22.0,
                        ),
                        onTap: () =>
                            Navigator.push(context,
                                new MaterialPageRoute<FullScreenCodeDialog>(
                                    builder: (BuildContext context) =>
                                    new ProfileScreen(userId: post['userId']))),
                      ),

                      margin: new EdgeInsets.only(right: 10.0),
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "$username",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        new Text(
                          " ${post['title']}",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        new Text("${ta.format(post['date'])}")
                      ],
                    ),
                  ],
                ),
              ),
              new Container(
                child: new Text(post['message']),
                margin: new EdgeInsets.all(10.0),
              ),

              post['imgUrlList'].length > 0 ?
              new Container(
                height: 350.0,
                child: new ListView.builder(
                  padding: kMaterialListPadding,
                  itemCount: post['imgUrlList'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var mImage = new Image(
                      fit: BoxFit.fill,
                      image: new NetworkImageWithRetry(
                          post['imgUrlList'][index]),
                    );

                    return new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              new MaterialPageRoute<FullScreenCodeDialog>(
                                  builder: (BuildContext context) =>
                                  new FullScreenCodeDialog(mImage: mImage)));
                        },
                        child: mImage,
                      ),
                    );
                  },
                ),
              ) : new Text(""),

              new ButtonTheme.bar(
                child: new ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FlatButton(
                      child: const Text('Like'),
                      textColor: Colors.blue,
                      onPressed: () {
                        onTapLike();
                      },
                    ),
                    new FlatButton(
                      child: const Text('Comment'),
                      textColor: Colors.blue,
                      onPressed: () {
                        onTapComment();
                      },
                    ),
                    new FlatButton(
                      child: const Text('Share'),
                      textColor: Colors.blue,
                      onPressed: () {
                        onTapShare();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class FullScreenCodeDialog extends StatefulWidget {
  const FullScreenCodeDialog({ this.mImage });
  final Image mImage;
  @override
  FullScreenCodeDialogState createState() => new FullScreenCodeDialogState();
}

class FullScreenCodeDialogState extends State<FullScreenCodeDialog> {
  Image _image;

  @override
  void didChangeDependencies() {
      if (mounted) {
        setState(() {
          _image = widget.mImage;
        });
      }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    Widget body;
    if (_image == null) {
      body = const Center(
          child: const Text("Invalid image")
      );
    } else {
      body = new SingleChildScrollView(
          child: _image
      );
    }

    return new Scaffold(
        appBar: new AppBar(
            leading: new IconButton(
                icon: const Icon(
                  Icons.clear,
                  semanticLabel: 'Close',
                ),
                onPressed: () { Navigator.pop(context); }
            ),
        ),
        body: body
    );
  }
}