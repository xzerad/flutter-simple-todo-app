import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() => runApp( const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      home: Scaffold(
        appBar: AppBar(title: const Text("Todo App")),
        body: const TodoApp(),
      ),
    );
  }
}


class TodoApp extends StatefulWidget{
  const TodoApp({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _TodoApp();


}
class _TodoApp extends State<StatefulWidget>{
  TextEditingController controller = TextEditingController();
  String txt = "";
  List<Map> strings = <Map>[];

  addTask(){
    setState(() {
      if (controller.text.compareTo("") != 0){
        strings.add({"text": controller.text, "done": false, "edit": false}); controller.clear();
      }});
  }


  @override
  Widget build(BuildContext context) {
    var textField =
    Container(
      margin: const EdgeInsets.only(right: 10),
      child: TextField(
        controller: controller,
      onSubmitted: (s) => addTask(),
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter a task"
      ),
    ));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
          margin: const EdgeInsets.all(10),
          child:
          Row( children: [
            Expanded(child: textField,
              flex: 2,
            ),
            Expanded(
                flex: 1,
                child:
                    SizedBox(
                      height: 58,
                      child:ElevatedButton(onPressed: () {  addTask();},
                      child: const Text("Add", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                      )
                    )
            )
          ],)
          ),
          Flexible(
            child:
            ListView.builder(
                itemCount: strings.length,
                itemBuilder:  (BuildContext context, int index){
                   return ListTile(
                      onTap: ()=> setState(() {
                        strings[index]["done"] = !strings[index]["done"];
                      }) ,
                      leading:  IconButton(onPressed: () => setState(() {
                          strings.remove(strings[index]);
                        })
                        , icon: const Icon(Icons.cancel), color: Colors.red[800]),
                      trailing:
                    IconButton(onPressed: ()=> setState(() {
                          strings[index]["edit"] = ! strings[index]["edit"];
                        }), icon: const Icon(Icons.edit, color: Colors.lightGreen,)),
                      title: strings[index]["edit"]? TextField(autofocus: strings[index]["edit"],controller: TextEditingController(text: strings[index]["text"]), onSubmitted:  (txt){
                        setState(() {
                          strings[index]["text"] =txt;
                          strings[index]["edit"] = false;
                        });

                      } ,onChanged: (txt)=>strings[index]["text"] = txt): Text( strings[index]["text"], style:  TextStyle(decoration: strings[index]["done"]?TextDecoration.lineThrough: null))
                    );
                  }),
          )
        ],
      );
  }

}

class SimpleFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
