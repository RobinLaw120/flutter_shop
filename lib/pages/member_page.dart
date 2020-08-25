import 'package:flutter/material.dart';


 class MemberPage extends StatefulWidget {

   @override
   _MemberPageState createState() => _MemberPageState();
 }
 
 class _MemberPageState extends State<MemberPage> {

   List lists = ['item1','item2','item3'];
   List<bool> boolList = new List<bool>();



   bool isSelect = true;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      for(int i= 0; i< lists.length; i++){
        boolList.add(false);
      }
    });
  }

  void itemChanged(bool val, int index){
     setState(() {
       boolList[index] = val;
     });
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
           child: ListView.builder(
             itemCount: lists.length,
             itemBuilder: (BuildContext context, int index){
               return Card(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Checkbox(
                       value: this.boolList[index],
                       onChanged: (bool val){
                         itemChanged(val, index);
                       },
                     ),
                     InkWell(
                       onTap: (){},
                       child: Container(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 Container(child: Text(lists[index]+ 'shdkahsdkjahdkjahdskjhakshdkahsdkhaskdhaks'),),
//                                 SizedBox(height: 40,),
                                 Text(lists[index]),
                               ],
                             ),
                             Image.network('https://s3.mogucdn.com/mlcdn/c45406/180808_0ef92c2hkg8e57lkj8098ek8ikj32_750x1024.jpg',fit: BoxFit.cover,width: 50,height: 80,)
                           ],
                         ),
                       ),

                     )
                   ],
                 ),
               );
             },
           ),
         ),
     );
   }
 }