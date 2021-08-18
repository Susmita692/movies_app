import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movies_app/scaffold_messenger.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'movie_model.dart';

class DeleteMovie extends StatelessWidget {
  final data;
  final index;

  const DeleteMovie({Key? key, required this.data, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            height: 285,
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
                    height: 230,
                    child: Column(
                      children: [
                        30.heightBox,
                        "Confirm your action for:".text.xl.bold.align(TextAlign.center).makeCentered(),
                        Divider(thickness: 1,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(
                                blurRadius: 20,
                                color: Colors.black12,
                              )]
                          ),
                          child: Row(
                            children: [
                              Container(height: 60,child: Image.memory(base64Decode(data.poster)).centered()).cornerRadius(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data.name}".text.lg.bold.make(),
                                  "By ${data.director}".text.make(),
                                ],
                              ).px8(),
                            ],
                          ),
                        ).p8(),
                        5.heightBox,
                        'After clicking on "Delete Movie", you can\'t undo it. Click on "Cancel" to leave it as it is.'.text.lg.align(TextAlign.center).makeCentered().px8(),
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
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Icon(Icons.delete_outlined, color: Colors.white, size: 40),
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
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          borderRadius: BorderRadius.circular(20),
                                          onTap:() async{
                                            var inventoryDb = Provider.of<MovieModel>(context, listen: false);
                                            ShowSnack.showSnackMessage(context, "Movie Deleted Successfully");
                                            inventoryDb.deleteItem(index);
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.delete_outlined, size: 25, color: Colors.white),
                                              "Delete Movie".text.color(Colors.white).lg.bold.make().px2(),
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