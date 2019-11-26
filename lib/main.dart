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





//投稿一覧画面
class MyFirstScreen extends StatefulWidget{

  @override
  FirstScreen createState() => new FirstScreen();
}

class FirstScreen  extends State<MyFirstScreen>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: //Image.asset("assets/IMG_1123.JPG",
         // height: 250.0,
          //width: 250.0,
      //)
        Text('Ishara',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child:  Text('ユーザー名'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child:  Text('フォロー数'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child:  Text('フォロワー数'),
                  ),
                ],

              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title:  Text('プロフィール'),
              onTap: (){
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context) => MyProfile()),
                  );
              },
            )
          ],
        ),
      ),

      body:ListView(
        children: List.generate(10,(index){
          return Card(
            child: Column(
              children: <Widget>[
                Image.asset("assets/IMG_0755.JPG",
                  height: 250.0,
                  width: 250.0,
                ),

               Container(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text('商品名',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      ),
                    ),
                    leading: Icon(Icons.person),
                  )),
                Container(
                  child: Text(
                    'ブランド、出版社など',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                    ),
                  ),
                ),

            Container(
            child: Text(
            '商品説明',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0
            ),
          ),
          )


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


//プロフィール
class MyProfile extends StatefulWidget{

  @override
  Profile createState() => new Profile();
}

class Profile extends State<MyProfile> {
  final _textEditingController = TextEditingController();
  final _textEditingControllerB = TextEditingController();
  int _maxLines;
  int _maxLinesB;

  @override
  void initState(){
    super.initState();
    _textEditingController.addListener(_textEditListener);
    _textEditingControllerB.addListener(_textEditListenerB);
  }

  @override
  void dispose(){
    _textEditingController.removeListener(_textEditListener);
    _textEditingController.dispose();
    _textEditingControllerB.removeListener(_textEditListenerB);
    _textEditingControllerB.dispose();

    super.dispose();
  }




  void _textEditListener(){
    setState(() {
      _maxLines = '\n'.allMatches(_textEditingController.text).length >= 0 ? 1 : null;
    });
  }

  void _textEditListenerB(){
    setState(() {
      _maxLinesB = '\n'.allMatches(_textEditingControllerB.text).length >= 4 ? 5 : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('プロフィール設定'),
        ),
      body:Card(
        elevation: 4.0,
        child:  Row(
          children: <Widget>[
        Expanded(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(2.0),
              child: new TextFormField(
                maxLength: 15,
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'ユーザーネーム',
                ),
                maxLines: _maxLines,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),

            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: new TextFormField(
                maxLength: 50,
                controller: _textEditingControllerB,
                decoration: const InputDecoration(
                  hintText: '自己紹介',
                ),
                maxLines: _maxLinesB,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),

            ),
          ],

        ),
      ),
      ]
    ),

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
  //final _textEditingController = TextEditingController();
  final _textEditingControllerItem = TextEditingController();
  final _textEditingControllerBrand = TextEditingController();
  final _textEditingControllerReview = TextEditingController();
  int _maxLinesItem;
  int _maxLinesBrand;
  int _maxLinesReview;
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
    await showModalBottomSheet<int> (
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
  void initState(){
    super.initState();
    _textEditingControllerItem.addListener(_textEditListenerItem);
    _textEditingControllerBrand.addListener(_textEditListenerBrand);
    _textEditingControllerReview.addListener(_textEditListenerReview);
  }

  @override
  void dispose(){
    _textEditingControllerItem.removeListener(_textEditListenerItem);
    _textEditingControllerItem.dispose();
    _textEditingControllerBrand.removeListener(_textEditListenerBrand);
    _textEditingControllerBrand.dispose();
    _textEditingControllerReview.removeListener(_textEditListenerReview);
    _textEditingControllerReview.dispose();
    super.dispose();
  }




  void _textEditListenerItem(){
    setState(() {
      _maxLinesItem = '\n'.allMatches(_textEditingControllerItem.text).length >= 2 ? 3 : null;
    });
  }

  void _textEditListenerBrand(){
    setState(() {
      _maxLinesBrand = '\n'.allMatches(_textEditingControllerBrand.text).length >= 2 ? 3 : null;
    });
  }

  void _textEditListenerReview(){
    setState(() {
      _maxLinesReview = '\n'.allMatches(_textEditingControllerReview.text).length >= 8 ? 9 : null;
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
                : Image.file(_image,
              height: 250.0,
              width: 250.0,
            ),
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
                              maxLength: 25,
                              controller: _textEditingControllerItem,
                              decoration: const InputDecoration(
                                hintText: '商品名',
                              ),
                              maxLines: _maxLinesItem,
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
                                      maxLength: 25,
                                      controller: _textEditingControllerBrand,
                                      decoration: const InputDecoration(
                                        hintText: 'ブランド、出版社など',
                                      ),
                                      maxLines: _maxLinesBrand,
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
                maxLength: 150,
                controller: _textEditingControllerReview,
                decoration: const InputDecoration(
                  hintText: '商品説明',
                ),
                maxLines: _maxLinesReview,
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


class SecondScreen extends State<MySecondScreen> {

  @override
  Widget build(BuildContext context) {
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
        children: List.generate(100, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyDetailPage()),
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
        onTap: (int value) {
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
            Image.asset('assets/IMG_0755.JPG',
              height: 250.0,
              width: 250.0,
            ),
            _buttonArea(),
            _titleArea(),
            _reviewArea()
          ],
        ),
      )
    );
  }
  Widget _buttonArea(){
    bool favorite;
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    //  child:  Row(
    //    crossAxisAlignment: CrossAxisAlignment.start,
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        child: //<Widget>[
          FlatButton(
            child: Icon(
              favorite == true ? Icons.favorite : Icons.favorite_border,
              color: favorite == true ? Colors.red : Colors.black38,
            ),
            onPressed: (){
              setState(() {
                if (favorite != true) {
                  //ハートが押されたときにfavoriteにtrueを代入している
                  favorite = true;
                } else {
                  favorite = false;
                }
              });
            },
          ),



         /* _buildButtonColumn(Icons.favorite_border, "いいね"),
          _buildButtonColumn(Icons.cached, "共有"),
          _buildButtonColumn(Icons.chat_bubble_outline, "コメント"),
          _buildButtonColumn(Icons.bookmark_border, "保存"),*/
        //],
      );
   // );
  }



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
        child: Text('商品説明',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0
        ),
      ),
      ),
    );
  }
}