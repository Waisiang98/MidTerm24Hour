import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class DetailScreen extends StatefulWidget {
  final book books;

  const DetailScreen({Key key, this.books}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight, screenWidth;
  List booklist;
  String titlecenter = "Loading book...";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.deepPurpleAccent,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(widget.books.booktitle,
            style: TextStyle(
              color: Colors.black87,
            ),),
          ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: screenHeight/3,
                width: screenWidth/0.3,
               child: CachedNetworkImage(
                 imageUrl:"http://slumberjer.com/bookdepo/bookcover/${widget.books.cover}.jpg" ,
                 fit: BoxFit.fill,
                 placeholder: (context,url)=>
                 new CircularProgressIndicator(),
                 errorWidget: (context,url,error)=>
                 new Icon(
                   Icons.broken_image,
                   size: screenWidth/3,
                 ),),
              ),
              SizedBox(height:10),
              SingleChildScrollView(
                child: Container(
                  height: 400,
                  color: Colors.white70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Book ID:",
                              ),
                          SizedBox(width: 5),
                          Text(
                              widget.books.bookid,
                            style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Book Author:",
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.books.author,
                            style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Book Price:RM",
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.books.price,
                            style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Book Description:",
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget.books.description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Book Rating:",
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.books.rating,
                            style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Book Publisher:",
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.books.publisher,
                            style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Book ISBN:",
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.books.isbn,
                            style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
