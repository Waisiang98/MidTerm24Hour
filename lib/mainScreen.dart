import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart'as http;
import 'package:listofbook/book.dart';

import 'DetailScreen.dart';

void main()=> runApp(MaterialApp(
  home: MainScreen(),
));

class MainScreen extends StatefulWidget {
  final book books;

  const MainScreen({Key key, this.books}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenHeight, screenWidth;
  List booklist;
  String titlecenter="Loading Book...";

  @override
  void initState(){
    super.initState();
    _loadBook();
  }
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "List of Books",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ) ,
        body: Container(
          color: Colors.deepPurpleAccent,
          child: Column(
            children: [
              booklist ==null
                  ? Flexible(
                child: Container(
                  child: Center(
                    child: Text(titlecenter),),),)
                  : Flexible(
                  child: GridView.count(crossAxisCount: 2,
                    childAspectRatio: (screenWidth/screenHeight)/0.9,
                    children: List.generate(booklist.length, (index){
                      return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                          child:InkWell(
                            onTap:()=> _loadBookDetail(index),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenHeight/3.9,
                                  width: screenWidth/1.2,
                                  child: CachedNetworkImage(
                                    imageUrl:"http://slumberjer.com/bookdepo/bookcover/${booklist[index]['cover']}.jpg" ,
                                    fit: BoxFit.fill,
                                    placeholder: (context,url)=>
                                    new CircularProgressIndicator(),
                                    errorWidget: (context,url,error)=>
                                    new Icon(
                                      Icons.broken_image,
                                      size: screenWidth/3,
                                    ),),),
                                Text(booklist[index]['booktitle'],style: TextStyle(
                                    color:Colors.redAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),),
                                Text("Author:"+booklist[index]['author']),
                                Text("Price:RM"+booklist[index]['price']),
                                Row(
                                  children: [
                                Container(
                                child: Icon(
                                Icons.star,
                                ),
                                ),
                                    Text(
                                        booklist[index]['rating']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _loadBook() {
    http.post("http://slumberjer.com/bookdepo/php/load_books.php",
        body: {
        }).then((res){
      print(res.body);
      if (res.body=="nodata"){
        booklist=null;
        titlecenter="no book found";
      }
      else{
        setState(() {
          var jsondata=json.decode(res.body);
          booklist = jsondata["books"];
        });
      }
    }).catchError((err){
      print(err);

    });
  }

  _loadBookDetail(int index) {
    print(booklist[index]['cover']);
    book b = new book(
        bookid: booklist[index]['bookid'],
        booktitle: booklist[index]['booktitle'],
        author: booklist[index]['author'],
        price: booklist[index]['price'],
        description: booklist[index]['description'],
        rating: booklist[index]['rating'],
        publisher: booklist[index]['publisher'],
        isbn: booklist[index]['isbn'],
        cover:booklist[index]['cover']);

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DetailScreen(books:b)));

  }
}


