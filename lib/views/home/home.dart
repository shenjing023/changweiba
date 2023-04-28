import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isShowBlackTitle = false;

  //判断滚动改变透明度
  void _onScroll(offset) {
    if (offset > 205 && !isShowBlackTitle) {
      setState(() {
        isShowBlackTitle = true;
      });
    } else if (offset <= 205 && isShowBlackTitle) {
      setState(() {
        isShowBlackTitle = false;
      });
    }
  }

  Widget cardContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 7.0),
          subtitle: Align(
            child: Text(
              "10秒前",
            ),
            alignment: Alignment(-1.1, 0),
          ),
          title: Align(
            child: Text(
              "asdassadaSSSAD是的是的撒啊大撒",
              softWrap: false,
              maxLines: 1,
              style: TextStyle(fontSize: 14),
            ),
            alignment: Alignment(-1.1, 0),
          ),
          leading: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://tse3-mm.cn.bing.net/th/id/OIP.iJyZTWUQ41RGdoVYjU-ARAHaE7?w=262&h=180&c=7&o=5&pid=1.7"),
                    fit: BoxFit.cover)),
          ),
          trailing: Icon(Icons.more_vert),
        ),
        Container(
          color: Colors.white70,
          height: 200,
          width: double.infinity,
        ),
        Divider(
          color: Colors.grey[200],
          height: 1,
          thickness: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // drawer: Drawer(),
        body: Stack(
          children: [
            NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  //滚动并且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              },
              child: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        leading: IconButton(
                          icon: Icon(Icons.view_headline_outlined),
                          onPressed: () {
                            print("aaaaa");
                          },
                        ),
                        title: isShowBlackTitle ? Text("肠胃吧") : Text(""),
                        centerTitle: true, //标题是否居中
                        floating: false,
                        snap: false,
                        primary: true,
                        expandedHeight: 260,
                        backgroundColor: Colors.green,
                        elevation: 0,
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              print("add");
                            },
                          )
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Image(
                                fit: BoxFit.fill,
                                image:
                                    AssetImage("assets/images/home_header.jpg"),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Container(
                                // padding: EdgeInsets.only(top: 10,bottom: 10),
                                alignment: Alignment.center,
                                color: Colors.white,
                                height: 60,
                                width: double.infinity,
                                child: TextButton(
                                  // highlightColor: Colors.green,
                                  // splashColor: Colors.lightGreen,
                                  onPressed: () {
                                    print("object");
                                  },
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "肠胃吧",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          )),
                                      TextSpan(
                                          text: " >",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black)),
                                      TextSpan(text: "\n"),
                                      TextSpan(
                                          text: "1111成员",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black))
                                    ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Divider(
                          color: Colors.grey[200],
                          height: 1,
                          thickness: 1,
                        ),
                      ),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return cardContent();
                      }, childCount: 25))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        // body: CustomScrollView(
        //   slivers: <Widget>[
        //     SliverAppBar(
        //       pinned: true,
        //       leading: GestureDetector(
        //         child: Icon(Icons.arrow_back),
        //         onTap: ()=>Navigator.pop(context),
        //       ),
        //       centerTitle: true,  //标题是否居中
        //       actions: <Widget>[
        //         Icon(
        //           Icons.add,
        //
        //         )
        //       ],
        //     ),
        //     SliverPersistentHeader(
        //       pinned: true,
        //       delegate: SliverCustomHeaderDelegate(
        //         title: "肠胃吧",
        //         collapsedHeight: 80,
        //         expandedHeight: 280,
        //         paddingTop: MediaQuery.of(context).padding.top
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Divider(
        //         color: Colors.grey[200],
        //         height: 1,
        //         thickness: 1,
        //       ),
        //     ),
        //     SliverList(
        //         delegate: SliverChildBuilderDelegate((context,index){
        //           return cradContent();
        //         },childCount: 25)
        //     )
        //   ],
        // ),
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String title;

  SliverCustomHeaderDelegate({
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.paddingTop,
    required this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(double shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(double shrinkOffset, bool isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/home_header.jpg"),
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: 80,
                width: double.infinity,
                child: TextButton(
                  // highlightColor: Colors.green,
                  // splashColor: Colors.lightGreen,
                  onPressed: () {
                    print("object");
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "肠胃吧",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: " >",
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      TextSpan(text: "\n"),
                      TextSpan(
                          text: "1111成员",
                          style: TextStyle(fontSize: 16, color: Colors.black))
                    ]),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: this
                                .makeStickyHeaderTextColor(shrinkOffset, true),
                          ),
                          onPressed: () => Navigator.pop(context)),
                      Text(
                        "肠胃吧",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: this.makeStickyHeaderTextColor(
                                shrinkOffset, false)),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.add,
                            color: this
                                .makeStickyHeaderTextColor(shrinkOffset, true),
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
