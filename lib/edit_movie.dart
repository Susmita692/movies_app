import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/movie_inventory.dart';
import 'package:movies_app/scaffold_messenger.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'movie_model.dart';

class EditMovies extends StatelessWidget {
  final String name;
  final int index;
  final String director;
  final Uint8List poster;
  const EditMovies({Key? key, required this.name, required this.index, required this.director, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController directorController = TextEditingController(text: director);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            height: 435,
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    height: 380,
                    child: Column(
                      children: [
                        30.heightBox,
                        "Movie Details".text.xl.bold.align(TextAlign.center).makeCentered(),
                        Divider(thickness: 1,),
                        Poster(poster: poster),
                        10.heightBox,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black12
                              )]
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(20)),
                              labelText: "Name",
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black12
                              )]
                          ),
                          child: TextFormField(
                            controller: directorController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(20)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(20)),
                                labelText: "Director",
                                hintText: "The name of Director"
                            ),
                          ),
                        ).pOnly(top:8),
                      ],
                    ).px12(),
                  ).px24(),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Icon(Icons.edit_outlined, color: Colors.white, size: 40),
                        ).p4(),
                      ),
                    )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20
                                        )],
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap:() async{
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            var inventoryDb = Provider.of<MovieModel>(context, listen: false);
                                            ShowSnack.showSnack(context, "Saving Changes...");
                                            inventoryDb.updateItem(index, MovieInventory(
                                                director: directorController.text,
                                                name: nameController.text,
                                                poster: (changed)?base64Encode(_img.readAsBytesSync()):base64Encode(poster)
                                            ));
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.edit_outlined, size: 25, color: Colors.white),
                                              "Edit Movie".text.color(Colors.white).lg.bold.make().px2(),
                                            ],
                                          )
                                      ),
                                    ),
                                  ).p4(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        10.widthBox,
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20
                                        )],
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap:(){
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.cancel_outlined, size: 25, color: Colors.white),
                                              "Cancel".text.color(Colors.white).lg.bold.make().px2(),
                                            ],
                                          )
                                      ),
                                    ),
                                  ).p4(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).px(46),
                ),
              ],
            ),
          ).onTap(() => FocusManager.instance.primaryFocus?.unfocus()),
        ),
      ),
    );
  }
}

class Poster extends StatefulWidget {
  const Poster({
    Key? key,
    required this.poster,
  }) : super(key: key);

  final Uint8List poster;

  @override
  _PosterState createState() => _PosterState();
}
var _img;
bool changed = false;
class _PosterState extends State<Poster> {
  pickImage() {
    ImagePicker.platform..pickImage(source: ImageSource.gallery).then((value){
      setState(() {
        _img = File(value!.path);
        changed = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: (changed)?Image.file(_img):Image.memory(widget.poster),
    ).onTap(() => pickImage());
  }
}
