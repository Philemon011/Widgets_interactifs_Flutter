import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InteractifPage extends StatefulWidget{
  @override
  InteractifPageState createState()=>InteractifPageState();

}
class InteractifPageState extends State<InteractifPage>{

  Color backgroundColor=Colors.white;
  Color textColor=Colors.black;
  bool textButtonPressed=true;
  IconData icon= Icons.favorite;
  String prenom="";
  late TextEditingController controller;
  bool switchValue=true;
  double sliderValue=50;
  bool check=false;
  Map<String,bool> courses={
    "Carotte":false,
    "Oignon":true,
    "Haricot":false,
  };
  DateTime initialDate=DateTime.now();
  int groupValue=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text(updateAppbarText()),),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: updateAppbar,
                child: Row(
                  children: [
                    Icon(Icons.work),
                    textButtonText()
                  ],
                )
            ) ,
            ElevatedButton(
                onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1992),
                  lastDate: DateTime(2033)
              ).then((value) => {
                if (value!=null){
                  setState((){
                    initialDate=value;
                  })
                }
              });
            },
                child: Text("$initialDate"),
              onLongPress: (){
                  print("apui lonnnnnnnnnnnnnnnnnnnng");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                elevation: 10,
                textStyle: TextStyle(color: Colors.red)
              ),
            ),
            IconButton(
                onPressed: (){
                  setIcon();
                },
                icon: Icon(icon),
            color: Colors.pink,

            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Entrer votre nom",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
              ),
              keyboardType: TextInputType.emailAddress,
              onSubmitted:(newString){
                setState(() {
                    prenom=newString;
                });
            },
            ),

            Text(prenom),
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Entrer votre nom"),
              onChanged: ((newValue){
               setState(() {

               });
              }),
            ),
            Text(controller.text),
            Row(
              children: [
                Text((switchValue)? "J'aime les chats": "les chats sont des démons"),
                Switch(
                  activeColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                    inactiveThumbColor: Colors.redAccent,
                    value: switchValue,
                    onChanged: ((bool){
                  setState(() {
                    switchValue=bool;
                  });
                }))
              ],
            ),
            Slider(
                min: 0,
                max: 100,
                value: sliderValue,
                onChanged: ((newValue){
                  setState(() {
                    sliderValue=newValue;
                  });
                }),
                thumbColor: Colors.red,
              inactiveColor: Colors.green,
              activeColor: Colors.yellowAccent,
            ),
            Text("Valeur: ${sliderValue.toInt()}"),
            Checkbox(
                value: check,
                onChanged: ((newBool)=>setState(()=>check=newBool ?? false))
            ),
            checks(),
            radios()



          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
    onPressed:updateColors,
        child:Icon(Icons.build) ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  updateColors(){
    setState(() {
      backgroundColor=(backgroundColor==Colors.white) ? Colors.black:Colors.white;
      textColor=(textColor==Colors.black) ? Colors.white:Colors.black;
    });
  }

  updateAppbar(){
    setState(() =>textButtonPressed=!textButtonPressed);
  }

  String updateAppbarText(){
      return (textButtonPressed)? "Je m'y connais un peu" : "Les interactifs";
  }

  Text textButtonText(){
    return const Text("Envoyer", style: TextStyle(color: Colors.pink),);
  }

  setIcon(){
    setState(() {
      icon=(icon==Icons.favorite)? Icons.favorite_border : Icons.favorite;
    });
  }
  Column checks(){
    List<Widget>items=[];
    courses.forEach((course, achete) {
      Widget row=Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(course),
          Checkbox(value: achete, onChanged: ((newValue){
            setState(() {
              courses[course]=newValue ?? false;
            });

          }),
            checkColor: Colors.blueAccent,
            activeColor: Colors.pink,
          )
        ],
      );
      items.add(row);
    });
    return Column(
      children: items,
    );
  }

  Row radios(){
    List<Widget> radios=[];
    for(var i=0; i<5; i++){
      Radio r=Radio(
          value: i,
          groupValue: groupValue ,
          onChanged: ((newValue){
            setState(() {
              groupValue=newValue as int;
           });


          }));
      radios.add(r);

    }
    return Row(children: radios,);

  }
}