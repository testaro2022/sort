import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '並び替えアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "並び替えアプリ"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String? title;

  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int n=1;
  String? _num;
  List<int> numlist=[];
  List<String> strlist=[];
  String str="";
  var _controller = TextEditingController();
  bool _visibleflag=false;
  String _order="";
  void _handleRadio(String? e) => setState(() {_order = e!;});
  bool _canadd =true;

  void mysort(List<int> l){
    while(true){
      bool _flag=false;
      for(var i=0;  i<l.length-1; i++){
          if(l[i]>l[i+1]) {
            var now=l[i];
            var next=l[i+1];
            l[i]=next;
            l[i+1]=now;
            _flag=true;
          }
      }
      print(l);
      if(!_flag) break;
    }
  }

  List<String> toStrList(List<int> l){
    List<String> strlist=[];
    for(var i in l){
        strlist.add(i.toString());
    }
    return strlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
                child: Text("数字を入れてください"),
              visible: _visibleflag,
            ),
            Text(
              "$n番目の数字を入力してください",
              // "$n番目の数字を入力してください:$_num",
            ),
            TextField(
              controller: _controller,
              enabled: true,
              onChanged: (String value){
                setState(() {
                  _num = value;
                });
              },
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: (){
                      if(!_canadd){
                        null;
                      }
                      else {
                        _controller.clear();
                        if (RegExp(r"[0-9]").hasMatch(_num!)) {
                          numlist.add(int.parse(_num!));
                          setState(() {
                            _visibleflag = false;
                            n=numlist.length+1  ;
                          });
                        }
                        else {
                          setState(() {
                            _visibleflag = true;
                          });
                        }
                        _num = null;
                      }
                    },
                    child: Text("入力"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        !_canadd ? Colors.grey : Colors.blue),
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(_canadd)_canadd=false;else{_canadd=true;}
                      });
                    },
                    child: Text("終了")
                )
              ],
            ),
            Row(
              children: [
                Text("昇順"),
                new Radio(
                  activeColor: Colors.blue,
                  value: 'up',
                  groupValue: _order,
                  onChanged: _handleRadio,
                ),
                Text("降順"),
                new Radio(
                  activeColor: Colors.blue,
                  value: 'down',
                  groupValue: _order,
                  onChanged: _handleRadio,
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(_order=="up"){
                          mysort(numlist);
                        }
                        else{
                          mysort(numlist);
                          numlist=List.from(numlist.reversed);
                        }
                      });
                    },
                    child: Text("実行"))
              ],
            ),
            Row(
              children: [Text("結果を表示します")],
            ),
            Row(
              children: [
                for(final i in toStrList(numlist))
                  Text(i+","),
              ]
            ),
          ],
        ),
      ),
      );
  }
}
