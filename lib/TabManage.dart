import 'package:bm_project2/tab/TabMoney.dart';
import 'package:bm_project2/tab/TabTodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bm_project2/tab/TabMoney.dart';

class TabManagePage extends StatefulWidget {

  @override
  State<TabManagePage> createState() => _TabManagePageState();
}

class _TabManagePageState extends State<TabManagePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(length: 2, 
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.arrow_back_ios_new_rounded,size: 35,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 20,
          title: Text('Manage your Balance'),
          bottom: TabBar(
            indicatorColor: Colors.cyanAccent,
            indicatorWeight: 5,
            tabs: [
            Tab(text:'Money Flow', icon: Icon(Icons.money_rounded,color: Colors.black,),),
             Tab(text:'Todo List', icon: Icon(Icons.notifications_active_outlined,color: Colors.black,),)
          ]),
        ),
        body: TabBarView(
          children: [
            MoneyFlowTab(),
            TodoListTab()
          ],
        ),
      )
      )
    );
  }
}