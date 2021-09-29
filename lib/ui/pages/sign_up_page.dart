// part of 'pages.dart';

// class MyForm extends StatefulWidget {
//   final List<String> children;
//   final String husband;
//   final String wife;
//   final int id;
//   MyForm({this.children, this.husband, this.wife, this.id});
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController;
//   static List<String> childrenList;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(
//         text: (widget.husband != null) ? widget.husband : widget.wife);
//     childrenList = widget.children;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Spouse and Children Informations'),
//       ),
//       body: ListView(
//         children: [
//           Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //name textfield
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Column(children: [
//                         Container(
//                           width: double.infinity,
//                           margin: EdgeInsets.fromLTRB(0, 0, defaultMargin, 6),
//                           child: Text("Name", style: blackFontStyleTitle2),
//                         ),
//                         TextFormField(
//                           controller: _nameController,
//                           decoration: InputDecoration(
//                               hintText: 'Enter your name',
//                               border: OutlineInputBorder()),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           margin: EdgeInsets.fromLTRB(0, 6, defaultMargin, 6),
//                           child:
//                               Text("Relationship", style: blackFontStyleTitle2),
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               enabled: false,
//                               fillColor: Colors.grey[200],
//                               filled: true,
//                               hintText:
//                                   (widget.husband != null) ? 'Husband' : 'Wife',
//                               hintStyle: blackFontStyleBold,
//                               border: OutlineInputBorder()),
//                         ),
//                       ]),
//                     ),
//                   ),
//                   ..._getFriends(),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(4, 8, 4, 70),
//                     child: Container(
//                       height: 50,
//                       width: double.infinity,
//                       child: RaisedButton(
//                         color: mainColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () async {
//                           await UserService.updateSpouse(context, widget.id,
//                               husband: widget.husband,
//                               wife: widget.wife,
//                               children: childrenList);
//                           Get.back();
//                           if (_formKey.currentState.validate()) {
//                             _formKey.currentState.save();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// get firends text-fields
//   List<Widget> _getFriends() {
//     List<Widget> friendsTextFields = [];
//     for (int i = 0; i < childrenList.length; i++) {
//       friendsTextFields.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     child: Text("Children Informations",
//                         style: blackFontStyleBold),
//                   ),
//                   SizedBox(height: 12),
//                   Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.fromLTRB(0, 0, defaultMargin, 6),
//                     child: Text("Name", style: blackFontStyleTitle2),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(child: ChildrenTextFieds(i)),
//                       SizedBox(width: 16),
//                       // we need add button at last friends row
//                       _addRemoveButton(
//                           i == childrenList.length - 1, i, childrenList.length),
//                     ],
//                   ),
//                   Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.fromLTRB(0, 6, defaultMargin, 6),
//                     child: Text("Relationship", style: blackFontStyleTitle2),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 46),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           enabled: false,
//                           fillColor: Colors.grey[200],
//                           filled: true,
//                           hintText: 'Child',
//                           hintStyle: blackFontStyleBold,
//                           border: OutlineInputBorder()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//     return friendsTextFields;
//   }

//   /// add / remove button
//   Widget _addRemoveButton(bool add, int index, int lastIndex) {
//     return InkWell(
//       onTap: () {
//         if (add) {
//           // add new text-fields at the top of all friends textfields
//           childrenList.insert(lastIndex, null);
//         } else
//           childrenList.removeAt(index);
//         setState(() {});
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: (add) ? Colors.green : mainColor,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           (add) ? Icons.add : Icons.delete_rounded,
//           size: 20,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// class ChildrenTextFieds extends StatefulWidget {
//   final int index;
//   ChildrenTextFieds(this.index);
//   @override
//   _ChildrenTextFiedsState createState() => _ChildrenTextFiedsState();
// }

// class _ChildrenTextFiedsState extends State<ChildrenTextFieds> {
//   TextEditingController _nameController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _nameController.text = _MyFormState.childrenList[widget.index] ?? '';
//     });

//     return TextFormField(
//       cursorColor: mainColor,
//       controller: _nameController,
//       onChanged: (v) => _MyFormState.childrenList[widget.index] = v,
//       decoration: InputDecoration(
//           hintText: 'Enter your friend\'s name', border: OutlineInputBorder()),
//       validator: (v) {
//         if (v.trim().isEmpty) return 'Please enter something';
//         return null;
//       },
//     );
//   }
// }
