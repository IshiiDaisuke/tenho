import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyFirstScreen(),
    );
  }
}





//マイ投稿一覧画面
class MyFirstScreen extends StatefulWidget{

  @override
  FirstScreen createState() => new FirstScreen();
}

class FirstScreen  extends State<MyFirstScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('マイ投稿一覧'),
      ),

      body:ListView(
        children: List.generate(10,(index){
          return Card(
            child: Column(
              children: <Widget>[
                Image.asset("assets/IMG_0755.JPG"),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text("assets/IMG_0755.JPG"),
                    leading: Icon(Icons.person),
                    subtitle: Text("サブタイトル"),
                  )),

              ],
            ),
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,MaterialPageRoute(builder: (context) => MyReview()),
          );
        },
        tooltip: 'set message.',
        child: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('投稿'),
            icon: Icon(Icons.edit),
          ),
          BottomNavigationBarItem(
            title: Text('一覧画面へ'),
            icon: Icon(Icons.navigate_next),
          ),
        ],
        onTap: (int value) {
          if (value == 1)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySecondScreen()),
            );
        },
      ),
    );
  }

}





//投稿画面
class MyReview extends StatefulWidget{

  @override
  Review createState() => new Review();
}

class Review extends State<MyReview> {
  final _textEditingControllerItem = TextEditingController();
  final _textEditingControllerBrand = TextEditingController();
  final _textEditingControllerReview = TextEditingController();
  int _maxLines;
  File _image;

  Future getImagegallery() async{
    var image1 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image1;
    });
  }

  Future getImageCamera() async{
    var image2 = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image2;
    });
  }

  Future bottomSheetButton() async{
    var image = await showModalBottomSheet<int> (
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add_photo_alternate),
              title: Text("画像を選択"),
              onTap: getImagegallery,
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("写真を撮影"),
              onTap: getImageCamera,
            ),
          ],
        );
      }
      );

  }





  void buttonPressed() {
    setState(() {
      Navigator.pop(context
       // context,MaterialPageRoute(builder: (context) => MyFirstScreen()),
      );
    });
  }

  @override
  void dispose(){
    _textEditingControllerItem.removeListener(_textEditListener);
    _textEditingControllerItem.dispose();
    super.dispose();
  }


  void _textEditListener(){
    setState(() {
      _maxLines = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('投稿画面'),
        actions: <Widget>[
          RaisedButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              shape: StadiumBorder(),
              child: Text(
                "投稿する",
                style: TextStyle(fontSize: 16.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"),
              ),
              onPressed: buttonPressed
          ),
        ],
      ),
      body:Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            _image == null
                ? RaisedButton.icon (
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              label: Text("写真を投稿"),
              onPressed: bottomSheetButton,
              color: Colors.blue,
              textColor: Colors.white,
            )
                : Image.file(_image),
            _titleArea(),
            _reviewArea()
          ],
        ),
      ),

      );
  }

  Widget _titleArea(){
    return Container(
      margin: EdgeInsets.all(8.0),
      child:  Row(
        children: <Widget>[
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: new TextFormField(
                              controller: _textEditingControllerItem,
                              decoration: const InputDecoration(
                                hintText: '商品名',
                              ),
                              maxLines: _maxLines,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                            ),
                          ),
                        ],
                      ),

                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: new TextFormField(
                                      controller: _textEditingControllerBrand,
                                      decoration: const InputDecoration(
                                        hintText: 'ブランド、出版社など',
                                      ),
                                      maxLines: _maxLines,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                    ),
                                  ),
                                ],
                              ),

                    )
                  ]
              )
          ),
        ],
      ),
    ),
    ]
    ),
    );


  }


  Widget _reviewArea(){
    return Expanded(
        child: Container(
        margin: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
    child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(2.0),
              child: new TextFormField(
                controller: _textEditingControllerReview,
                decoration: const InputDecoration(
                  hintText: '商品説明',
                ),
                maxLines: _maxLines,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





//一覧画面
class MySecondScreen extends StatefulWidget{

  @override
  SecondScreen createState() => new SecondScreen();
}


class SecondScreen extends State<MySecondScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('一覧画面'),
      ),
      body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.7,
            shrinkWrap: true,
            padding: const EdgeInsets.all(4.0),
            children: List.generate(100,(index){
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context) => MyDetailPage()),
                  );
                },
             child: Column(
                children: <Widget>[
                  Image.asset("assets/IMG_0755.JPG"),
                ],
              ),

              );
            }),
    ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('投稿画面へ'),
            icon: Icon(Icons.navigate_before),
          ),
          BottomNavigationBarItem(
            title: Text('一覧'),
            icon: Icon(Icons.view_module),
          ),
        ],
        onTap: (int value){
          if (value == 0)
            Navigator.pop(
                context);
        },
      ),
      );
  }




//詳細画面
  void buttonPressed1(){
    context;MaterialPageRoute(builder: (context) => MyDetailPage());
  }
}

class MyDetailPage extends StatefulWidget{

  @override
  DetailPage createState() => new DetailPage();
}

class DetailPage extends State<MyDetailPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('詳細画面'),
      ),
      body:Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/IMG_0755.JPG'),
            _buttonArea(),
            _titleArea(),
            _reviewArea()
          ],
        ),
      )
    );
  }
  Widget _buttonArea(){
    bool _favorite;
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            child: Icon(
              _favorite == true ? Icons.favorite : Icons.favorite_border,
              color: _favorite == true ? Colors.red : Colors.black38,
            ),
            onPressed: (){
              setState(() {
                if (_favorite = true){
                  _favorite = false;
                }else{
                  _favorite = true;
                }
              });
            },
          ),
         /* _buildButtonColumn(Icons.favorite_border, "いいね"),
          _buildButtonColumn(Icons.cached, "共有"),
          _buildButtonColumn(Icons.chat_bubble_outline, "コメント"),
          _buildButtonColumn(Icons.bookmark_border, "保存"),*/
        ],
      ),
    );
  }


/*  Widget _buildButtonColumn(IconData icon, String label){
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color),
            ),
          ),
      ],
    );
  }*/

  Widget _titleArea(){
    return Container(
      margin: EdgeInsets.all(16.0),
      child:  Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '商品名',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                    ),
                ),
    Container(
      child: Text(
        'ブランド、出版社など',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0
        ),
      ),
    )
              ]
                )
                ),
              ],
            ),
          );


  }

  Widget _reviewArea(){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Text("商品説明"),
      ),
    );
  }
}