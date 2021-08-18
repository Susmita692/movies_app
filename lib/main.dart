import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/edit_movie.dart';
import 'package:movies_app/movie_inventory.dart';
import 'package:movies_app/movie_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:movies_app/add_movie.dart';

import 'delete_movie.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(MovieInventoryAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider<MovieModel>(create: (context) => MovieModel()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
bool firstLoad = true;
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    context.watch<MovieModel>().getItem();
    return Consumer<MovieModel>(
      builder: (context, model, child){
        return Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text("My Movies"),
          ),
          body: Container(
            child: (model.inventoryList.length > 0)?GridView.builder(
              itemCount: model.inventoryList.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 200/250,crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index){
                MovieInventory inv = model.inventoryList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xf5f5f5f5),
                    boxShadow: [BoxShadow(
                      color: Colors.black12,
                    )],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 135,child: Image.memory(base64Decode(inv.poster)).centered()).cornerRadius(20),
                      "${inv.name}".text.xl.bold.make().px4(),
                      "By ${inv.director}".text.make().px4(),
                      2.heightBox,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit_outlined, size: 30,).onTap(() => showDialog(
                              context: context,
                              builder: (context) => Scaffold(
                                backgroundColor: Colors.transparent,
                                body: Builder(
                                  builder: (context){
                                    changed = false;
                                    return EditMovies(index: index, name: inv.name, director: inv.director, poster: base64Decode(inv.poster));
                                  },
                                ),
                              )
                            )),
                            Icon(Icons.delete_outlined, color: Colors.red, size: 30,).onTap(() => showDialog(
                                context: context,
                                builder: (context) => Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Builder(
                                    builder: (context){
                                      changed = false;
                                      return DeleteMovie(data: inv, index: index);
                                    },
                                  ),
                                )
                            ))
                          ],
                        ).px8().py2(),
                      ).px4()
                    ],
                  ),
                );
              },
            ).p8():Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText("d(^_^)b", style: TextStyle(fontSize: 150, color: Colors.black), maxLines: 1,).px12(),
                    AutoSizeText("Looks like you have not added any movies.", textAlign:TextAlign.center,style: TextStyle(fontSize: 25, color: Colors.black), minFontSize: 20, maxLines: 2,).px12().py24(),
                    AutoSizeText("Let's add some quickly.", style: TextStyle(fontSize: 50, color: Colors.black), maxLines: 1,).px12(),

                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Builder(
                        builder: (context){
                          return AddMovies();
                        },
                      ),
                    );
                  }
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
