import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../service/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive =>true;

  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: FutureBuilder(
        future: request('https://zcyx.pt-ts.my-campus.cn/app/space/index'),
        builder: (context, snapshot) {
          if(snapshot.hasData){

            var data = json.decode(snapshot.data.toString());
//
            List<Map> bannerList = (data['result']['banner'] as List).cast();
            List<Map> columnList = (data['result']['columnList'] as List).cast();
//            List<Map> teamLeaderBoard = (columnList[1]['teamLeaderBoard'] as List).cast();

//            print(teamLeaderBoard);

            return EasyRefresh(
              refreshHeader: ClassicsHeader(
                key: _headerKey,
                bgColor: Color.fromRGBO(244, 245, 245, 1.0),
                textColor: Colors.black,
              ),
              onRefresh: () async{
                print('下拉刷新');
              },
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Color.fromRGBO(244, 245, 245, 1.0),
                textColor: Colors.black,
              ),
              loadMore: () async{
                print('上拉加载');
                Fluttertoast.showToast(
                    msg: "已经到底了",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: bannerList),
                  ServiceRow(),
                  MonthStartRow(starInfo: columnList[0]),
//                  MonthStarList(starList: teamLeaderBoard),
                  StarTeamView(),
                  Container(
                    color: Colors.white,
                    height: ScreenUtil().setHeight(50),
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '创业城',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: ScreenUtil().setSp(32)
                      ),
                    ),
                  ),
                  EntrepreneurialCity(),
                  Container(
                    color: Colors.white,
                    height: ScreenUtil().setHeight(50),
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '创业大赛',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: ScreenUtil().setSp(32)
                      ),
                    ),
                  ),
                  EntrepreneurDaSai()
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      )

    );
  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget{

  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {


    return Container(
      color:Colors.white,
      height: ScreenUtil().setHeight(280),
      width: ScreenUtil().setWidth(750),
//      margin: EdgeInsets.only(left: ScreenUtil().setWidth(25),right: ScreenUtil().setWidth(25)),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){
              print('点击了第${index}个');
              Fluttertoast.showToast(
                  msg: '点击了第${index+1}个图片',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
            child:  Image.network(
                swiperDataList[index]['image'],
                fit:BoxFit.fill
            ),
          );

        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//服务栏目子项
class ServiceItem extends StatelessWidget {

  final String image;
  final String name;

  ServiceItem({Key key, this.image, this.name}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color:Colors.white,
      height: ScreenUtil().setWidth(750) / 5,
      width: ScreenUtil().setWidth(750) / 5,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[

          InkWell(
            onTap: (){
              Fluttertoast.showToast(
                  msg: "尚未实现，敬请期待！",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
            child: Container(
              height: ScreenUtil().setWidth(72),
              width: ScreenUtil().setWidth(72),
              margin: EdgeInsets.only(top: 10,bottom: 5.0),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(name)
        ],
      ),
    );
  }
}

//服务栏目
class ServiceRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          ServiceItem(image: 'assets/images/chuangyehome_xiangmu_icon.png', name: '项目'),
          ServiceItem(image: 'assets/images/chuangyehome_dianpu_icon.png', name: '店铺'),
          ServiceItem(image: 'assets/images/chuangyehome_fuwu_icon.png', name: '服务'),
          ServiceItem(image: 'assets/images/chuangyehome_wode_icon.png', name: '我的'),
          ServiceItem(image: 'assets/images/chuangyehome_gengduo_icon.png', name: '更多')
        ],
      ),
    );
  }
}

// 本月明星
class MonthStartRow extends StatelessWidget {

  final Map starInfo;

  MonthStartRow({Key key, this.starInfo}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(300),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: ScreenUtil().setHeight(60),
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              '本月Startup明星',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color:Colors.black,
                  fontSize: ScreenUtil().setSp(32)
              ),
            ),
          ),

          Container(
            height: ScreenUtil().setHeight(220),
            width: ScreenUtil().setWidth(690),
            margin: EdgeInsets.only(top: 5, left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
            child: InkWell(
              onTap: (){
                Fluttertoast.showToast(
                    msg: "点击了本月明星",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              child:  Image.network(
                  starInfo['imageContent'][0]['image'],
                  fit:BoxFit.fill
              ),
            ),
          ),

        ],
      ),
    );
  }
}

// 本月明星列表
class MonthStarList extends StatelessWidget {

  final List<Map> starList;

  MonthStarList({Key key, this.starList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(550),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: ScreenUtil().setHeight(60),
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              '9月排名',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color:Colors.black,
                  fontSize: ScreenUtil().setSp(32)
              ),
            ),
          ),
          FirstStarView(starInfo: starList[0]),
          StarListView(starList: starList)

        ],
      ),
    );
  }
}

// 排名第一的创业明星
class FirstStarView extends StatelessWidget {
  final Map starInfo;

  FirstStarView({Key key, this.starInfo}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(190),
      width: ScreenUtil().setWidth(690),
      margin: EdgeInsets.only(top: 5, left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
      padding: EdgeInsets.only(left: 10),
      decoration: new BoxDecoration(
        color: Color(0xFFD6EAFF),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: new Border.all(width: 0.1, color: Colors.white),
      ),
      child: InkWell(
        onTap: (){
          Fluttertoast.showToast(
              msg: "点击了本月第一明星",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print('点击了本月第一明星');
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/kongjian_startup_jiangpai_fist.png',
                  fit: BoxFit.fill,
                ),

                Text(
                  'NO.1',
                  style: TextStyle(
                      color:Colors.black,
                      fontSize: ScreenUtil().setSp(48)
                  ),
                )

              ],
            ),
            Positioned(
              left: ScreenUtil().setWidth(150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 7),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      starInfo['name'],
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: ScreenUtil().setSp(36)
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    starInfo['teamTag'],
                    style: TextStyle(
                        color:Colors.black,
                        fontSize: ScreenUtil().setSp(24)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        TagItem(title: starInfo['schoolName'])
                      ],
                    ),
                  )

                ],
              ),
            ),
            Positioned(
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 15),
                    child: Text(
                      '25人 | 创业',
                      style: TextStyle(
                          color:Color(0xFF333333),
                          fontSize: ScreenUtil().setSp(24)
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/jiangpai.png',
                    fit: BoxFit.fill,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 2-10 明星视图
class StarListView extends StatelessWidget {

  final List<Map> starList;

  StarListView({Key key, this.starList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: ScreenUtil().setHeight(270),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: starList.length-1,
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Fluttertoast.showToast(
                  msg: "点击了第${index+2}明星",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
            child: Container(
              width: ScreenUtil().setHeight(200),
              height: ScreenUtil().setHeight(230),
              margin: EdgeInsets.all(10),

              decoration: new BoxDecoration(
                color: index == 0 ? Color(0x26FCC478) : (index == 1 ? Color(0xFFD3F5F7) : Color(0xFFFAFAFA)),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: new Border.all(width: 0.1, color: Colors.white),
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(40),
                        margin: EdgeInsets.only(top: 15,left: 10),
                        child: Text(
                          'NO.${index+2}',
                          style: TextStyle(
                              color:Color(0xFF333333),
                              fontSize: ScreenUtil().setSp(32)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Offstage(
                          offstage: index >= 2,
                          child: Image.asset(
                            index == 0 ? 'assets/images/kongjian_startup_jiangpai_Second.png'
                                : 'assets/images/kongjian_startup_jiangpai_Third.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 30,
                    child: Container(
                      height: ScreenUtil().setHeight(40),
                      margin: EdgeInsets.only(top: 12, left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        starList[index+1]['name'] ?? '',
                        style: TextStyle(
                            color:Color(0xFF333333),
                            fontSize: ScreenUtil().setSp(26)
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: 8, left: 10,right: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        starList[index+1]['teamTag'] ?? '',
                        style: TextStyle(
                            color:Color(0xFF808080),
                            fontSize: ScreenUtil().setSp(22)
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Offstage(
                      offstage: index >= 2,
                      child: Container(
                        width: ScreenUtil().setWidth(40),
                        height: ScreenUtil().setHeight(48),
                        child: Image.asset(
                          'assets/images/jiangpai.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TagItem extends StatelessWidget {

  final String title;

  TagItem({Key key, this.title}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(40),
      color: Color(0x1FF06992),
      padding: EdgeInsets.only(left: 5,top: 2,bottom: 2,right: 5),
      child: Text(
        title,
        style: TextStyle(
            color:Color(0xFFF06992),
            fontSize: ScreenUtil().setSp(24)
        ),
      ),
    );
  }
}

class StarTeamItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFAFAFA),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      height: ScreenUtil().setHeight(160),
      width: ScreenUtil().setWidth(700/2),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '点心联盟',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color:Colors.black,
                      fontSize: ScreenUtil().setSp(28)
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '25人',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color:Color(0xFF808080),
                      fontSize: ScreenUtil().setSp(22)
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '智能仓储及物流机器人研发商',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color:Colors.black,
                      fontSize: ScreenUtil().setSp(22)
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child:Container(
                height: ScreenUtil().setHeight(56),
                width: ScreenUtil().setWidth(56),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: new Border.all(width: 0.1, color: Colors.white),
                ),
                child: Image.network(
                    'https://zcyx.pt-ts.my-campus.cn/uploads/2019/08/c6ce50f1-a3d9-4de8-9d2f-df4db55c8306.jpg',
                    fit: BoxFit.fill
                ),
              )
          )
        ],
      ),
    );
  }
}


// 明星团队
class StarTeamView extends StatelessWidget {

  final List<Map> starTeamList;

  StarTeamView({Key key, this.starTeamList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(260),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: ScreenUtil().setHeight(60),
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              '明星团队',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color:Colors.black,
                  fontSize: ScreenUtil().setSp(32)
              ),
            ),
          ),

          Container(
            height: ScreenUtil().setHeight(180),
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: <Widget>[
                StarTeamItem(),
                StarTeamItem()
              ],
            ),
          )

        ],
      ),
    );
  }
}


//创业城
class EntrepreneurialCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(250),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(230),
            width: ScreenUtil().setWidth(730),
            margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
            child: InkWell(
              onTap: (){
                print('点击');
                Fluttertoast.showToast(
                    msg: "点击了创业城",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              child:  Image.network(
                  'https://zcyx.pt-ts.my-campus.cn/uploads/2019/09/c9e13450d5be41a0ad7aa903275bf693_995x312.jpg',
                  fit:BoxFit.fill
              ),
            ),
          )
        ],
      ),
    );
  }
}

//创业大赛
class EntrepreneurDaSai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(250),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(230),
            width: ScreenUtil().setWidth(710),
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: ScreenUtil().setWidth(20)),
            child: InkWell(
              onTap: (){
                print('点击');
                Fluttertoast.showToast(
                    msg: "点击了创业大赛",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
              child:  Image.network(
                  'https://zcyx.pt-ts.my-campus.cn/uploads/2019/08/11478f41abad46eb852f147bb3bf04ba_1080x556.jpeg',
                  fit:BoxFit.fill
              ),
            ),
          )
        ],
      ),
    );
  }
}
