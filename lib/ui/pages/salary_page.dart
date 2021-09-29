// part of 'pages.dart';

// //import 'package:invoiceninja_flutter/utils/platforms.dart';

// class ClientEntity {
//   ClientEntity({this.name, this.contacts});
//   String? name;
//   List<ContactEntity>? contacts;
// }

// class ContactEntity {
//   ContactEntity({this.fullname, this.relationship});
//   String? fullname;
//   String? relationship;
// }

// class FormDynamic extends StatefulWidget {
//   @override
//   _FormDynamicState createState() => _FormDynamicState();
// }

// class _FormDynamicState extends State<FormDynamic>
//     with SingleTickerProviderStateMixin {
//   // static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // static final GlobalKey<ClientPageState> _clientKey =
//   //     GlobalKey<ClientPageState>();
//   static final GlobalKey<ContactsPageState> _contactsKey =
//       GlobalKey<ContactsPageState>();

//   //TabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     //_controller = TabController(vsync: this, length: 2);
//   }

//   @override
//   void dispose() {
//     //_controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Create a test client to show initially
//     final ClientEntity _client = ClientEntity(
//         name: 'Acme Client', contacts: [ContactEntity(fullname: 'My Lovely')]);

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         //automaticallyImplyLeading: isMobile(context),
//         title: Text('Spouse and Children Informations'),
//         // actions: <Widget>[
//         //   IconButton(
//         //     icon: Icon(Icons.cloud_upload),
//         //     onPressed: () {
//         //       if (!_formKey.currentState.validate()) {
//         //         return;
//         //       }

//         //       _formKey.currentState.save();

//         //       //final clientState = _clientKey.currentState;
//         //       final contactsState = _contactsKey.currentState;

//         //       // If the user never views a tab the state can be null
//         //       // in which case we'll use the current value
//         //       final ClientEntity client = ClientEntity(
//         //         // name: clientState?.name ?? _client.name,
//         //         contacts: contactsState?.getContacts() ?? _client.contacts,
//         //       );

//         //       // Do something with the client...
//         //       print('Client name: ${client.name}');
//         //     },
//         //   )
//         // ],
//         // bottom: TabBar(
//         //   controller: _controller,
//         //   tabs: [
//         //     Tab(
//         //       text: 'Details',
//         //     ),
//         //     Tab(
//         //       text: 'Contacts',
//         //     ),
//         //   ],
//         // ),
//       ),
//       body:
//           //  Form(
//           //   key: _formKey,
//           //   child: TabBarView(
//           //    //controller: _controller,
//           //     children: <Widget>[
//           //       ClientPage(client: _client, key: _clientKey),
//           Padding(
//         padding: EdgeInsets.only(bottom: 60),
//         child: ContactsPage(client: _client, key: _contactsKey),
//       ),
//       //     ],
//       //   ),
//       // ),
//       floatingActionButton: Container(
//         height: 50,
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 30),
//           child: RaisedButton(
//             color: mainColor,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             child: Text(
//               "Submit",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {},
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Displays the list of contacts with a button to add more
// class ContactsPage extends StatefulWidget {
//   const ContactsPage({
//     Key key,
//     @required this.client,
//   }) : super(key: key);

//   final ClientEntity client;

//   @override
//   ContactsPageState createState() => ContactsPageState();
// }

// class ContactsPageState extends State<ContactsPage>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   List<ContactEntity> _contacts;
//   List<GlobalKey<ContactFormState>> _contactKeys;

//   @override
//   void initState() {
//     super.initState();
//     final client = widget.client;
//     _contacts = client.contacts.toList();
//     _contactKeys = client.contacts
//         .map((contact) => GlobalKey<ContactFormState>())
//         .toList();
//   }

//   List<ContactEntity> getContacts() {
//     final List<ContactEntity> contacts = [];
//     _contactKeys.forEach((contactKey) {
//       contacts.add(contactKey.currentState.getContact());
//     });
//     return contacts;
//   }

//   void _onAddPressed() {
//     setState(() {
//       _contacts.add(ContactEntity());
//       _contactKeys.add(GlobalKey<ContactFormState>());
//     });
//   }

//   void _onRemovePressed(GlobalKey<ContactFormState> key) {
//     setState(() {
//       final index = _contactKeys.indexOf(key);
//       _contactKeys.removeAt(index);
//       _contacts.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final List<Widget> items = [];

//     for (var i = 0; i < _contacts.length; i++) {
//       final contact = _contacts[i];
//       final contactKey = _contactKeys[i];
//       items.add(ContactForm(
//         contact: contact,
//         key: contactKey,
//         onRemovePressed: (key) => _onRemovePressed(key),
//       ));
//     }

//     items.add(Padding(
//       padding: const EdgeInsets.all(16),
//       child: GestureDetector(
//         onTap: _onAddPressed,
//         child: Container(
//           child: Row(
//             children: [
//               Icon(Icons.add_circle_outline, color: mainColor),
//               SizedBox(width: 8),
//               Text('Add More')
//             ],
//           ),
//         ),
//       ),
//       // child: RaisedButton(
//       //   color: mainColor,
//       //   elevation: 4.0,
//       //   textColor: Colors.white,
//       //   child: Text('Add More'),
//       //   onPressed: _onAddPressed,
//       // ),
//     ));

//     return ListView(
//       children: items,
//     );
//   }
// }

// // Displays an individual contact
// class ContactForm extends StatefulWidget {
//   const ContactForm({
//     Key key,
//     @required this.contact,
//     @required this.onRemovePressed,
//   }) : super(key: key);

//   final ContactEntity contact;
//   final Function(GlobalKey<ContactFormState>) onRemovePressed;

//   @override
//   ContactFormState createState() => ContactFormState();
// }

// class ContactFormState extends State<ContactForm> {
//   String _email;
//   String _relationship;
//   TextEditingController relationCT = TextEditingController(text: 'Child');

//   ContactEntity getContact() {
//     return ContactEntity(
//       fullname: _email,
//       relationship: _relationship,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FormCard(
//       children: <Widget>[
//         TextFormField(
//           initialValue: widget.contact.fullname,
//           onSaved: (value) => _email = value.trim(),
//           decoration: InputDecoration(labelText: 'Name'),
//           keyboardType: TextInputType.emailAddress,
//         ),
//         TextFormField(
//           controller: relationCT,
//           initialValue: widget.contact.relationship,
//           onSaved: (value) => _relationship = value.trim(),
//           readOnly: true,
//           decoration: InputDecoration(labelText: 'Relationship'),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Padding(
//                 padding: const EdgeInsets.only(top: 12.0),
//                 child: IconButton(
//                     icon: Icon(Icons.delete_rounded, color: mainColor),
//                     onPressed: () => widget.onRemovePressed(widget.key)))
//           ],
//         ),
//       ],
//     );
//   }
// }

// // Helper widget to make the form look a bit nicer
// class FormCard extends StatelessWidget {
//   const FormCard({this.children});
//   final List<Widget> children;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
//       child: Card(
//         elevation: 2.0,
//         child: Padding(
//           padding: const EdgeInsets.only(
//               left: 12.0, right: 12.0, top: 12.0, bottom: 18.0),
//           child: Column(
//             children: children,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EditDocument extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Documents'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(24, 8, 24, 70),
//         child: ListView(
//           children: [
//             customText('Ijazah'),
//             customFile(),
//             customText('KTP'),
//             customFile(),
//             customText('Kartu Keluarga'),
//             customFile(),
//             customText('SIM'),
//             customFile(),
//             customText('Surat Nikah'),
//             customFile(),
//             customText('Akta Kelahiran'),
//             customFile(),
//             customText('Sertifikat yang pernah diikuti'),
//             customFile(),
//           ],
//         ),
//       ),
//       floatingActionButton: Container(
//         height: 50,
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 30),
//           child: RaisedButton(
//             color: mainColor,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             child: Text(
//               "Submit",
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: () {},
//           ),
//         ),
//       ),
//     );
//   }

//   customText(String title) {
//     return Text(title, style: blackFontStyleTitle2);
//   }

//   customFile() {
//     return Container(
//       height: 40,
//       margin: EdgeInsets.fromLTRB(0, 8, 150, 8),
//       child: RaisedButton(
//         color: mainColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Text(
//           "Choose File",
//           style: TextStyle(color: white),
//         ),
//         onPressed: () {},
//       ),
//     );
//   }
// }

// class EducationEdit extends StatefulWidget {
//   @override
//   _EducationEditState createState() => _EducationEditState();
// }

// class _EducationEditState extends State<EducationEdit> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController;
//   static List<String> friendsList = [null];

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
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           title: Text('Education Informations'),
//         ),
//         body: ListView(
//           children: [
//             Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // name textfield
//                     // Padding(
//                     //   padding: const EdgeInsets.only(right: 32.0),
//                     //   child: TextFormField(
//                     //     controller: _nameController,
//                     //     decoration: InputDecoration(hintText: 'Enter your name'),
//                     //     validator: (v) {
//                     //       if (v.trim().isEmpty) return 'Please enter something';
//                     //       return null;
//                     //     },
//                     //   ),
//                     // ),
//                     // SizedBox(
//                     //   height: 20,
//                     // ),
//                     // Text(
//                     //   'Education Informations',
//                     //   style:
//                     //       TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                     // ),
//                     ..._getFriends(),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     FlatButton(
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           _formKey.currentState.save();
//                         }
//                       },
//                       child: Text('Submit'),
//                       color: Colors.green,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }

//   /// get firends text-fields
//   List<Widget> _getFriends() {
//     List<Widget> friendsTextFields = [];
//     for (int i = 0; i < friendsList.length; i++) {
//       friendsTextFields.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(children: [
//               Container(
//                 width: double.infinity,
//                 child:
//                     Text("Education Informations", style: blackFontStyleBold),
//               ),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     labelText: 'Tingkat Pendidikan',
//                     border: OutlineInputBorder()),
//               ),
//               SizedBox(height: 12),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     labelText: 'Nama Institusi Pendidikan',
//                     border: OutlineInputBorder()),
//               ),
//               SizedBox(height: 12),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     labelText: 'Jurusan/Bidang Studi',
//                     border: OutlineInputBorder()),
//               ),
//               SizedBox(height: 12),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     suffixIcon: Icon(Icons.date_range_rounded),
//                     labelText: 'Tahun Masuk',
//                     border: OutlineInputBorder()),
//               ),
//               Row(
//                 children: [
//                   Expanded(child: FriendTextFields(i)),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   // we need add button at last friends row
//                   _addRemoveButton(
//                       i == friendsList.length - 1, i, friendsList.length),
//                 ],
//               ),
//             ]),
//           ),
//         ),
//       ));
//     }
//     return friendsTextFields;
//   }

//   /// add / remove button
//   Widget _addRemoveButton(bool add, int index, int lastIndex) {
//     return InkWell(
//       onTap: () {
//         if (add) {
//           // add new text-fields at the top of all friends textfields
//           friendsList.insert(lastIndex, null);
//         } else
//           friendsList.removeAt(index);
//         setState(() {});
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: (add) ? Colors.green : Colors.red,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           (add) ? Icons.add : Icons.remove,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// class FriendTextFields extends StatefulWidget {
//   final int index;
//   FriendTextFields(this.index);
//   @override
//   _FriendTextFieldsState createState() => _FriendTextFieldsState();
// }

// class _FriendTextFieldsState extends State<FriendTextFields> {
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
//       _nameController.text =
//           _EducationEditState.friendsList[widget.index] ?? '';
//     });

//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) => _EducationEditState.friendsList[widget.index] = v,
//       decoration: InputDecoration(
//           suffixIcon: Icon(Icons.date_range_rounded),
//           hintText: 'Tahun Keluar '),
//       validator: (v) {
//         if (v.trim().isEmpty) return 'Please enter something';
//         return null;
//       },
//     );
//   }
// }

// class CourseEdit extends StatefulWidget {
//   final String title;
//   final String t1;
//   final String t2;
//   final String t3;
//   final String t4;
//   CourseEdit({this.title, this.t1, this.t2, this.t3, this.t4});
//   @override
//   _CourseEditState createState() => _CourseEditState();
// }

// class _CourseEditState extends State<CourseEdit> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController;
//   static List<String> friendsList = [null];

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
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           title: Text(
//               widget.title != null ? widget.title : 'Experience Informations'),
//         ),
//         body: ListView(
//           children: [
//             Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ..._getFriends(),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     FlatButton(
//                       onPressed: () {
//                         if (_formKey.currentState.validate()) {
//                           _formKey.currentState.save();
//                         }
//                       },
//                       child: Text('Submit'),
//                       color: Colors.green,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }

//   /// get firends text-fields
//   List<Widget> _getFriends() {
//     List<Widget> friendsTextFields = [];
//     for (int i = 0; i < friendsList.length; i++) {
//       friendsTextFields.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(children: [
//               Container(
//                 width: double.infinity,
//                 child: Text(
//                     widget.title != null
//                         ? widget.title
//                         : "Experience Informations",
//                     style: blackFontStyleBold),
//               ),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     labelText:
//                         widget.t1 != null ? widget.t1 : 'Nama Perusahaan',
//                     border: OutlineInputBorder()),
//               ),
//               SizedBox(height: 12),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     labelText: widget.t2 != null
//                         ? widget.t2
//                         : 'Jabatan dan Uraian Singkat Tugas - Tugas',
//                     border: OutlineInputBorder()),
//               ),
//               SizedBox(height: 12),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     suffixIcon: Icon(Icons.date_range_rounded),
//                     labelText:
//                         widget.t3 != null ? widget.t3 : 'Masa Kerja Awal',
//                     border: OutlineInputBorder()),
//               ),
//               Row(
//                 children: [
//                   Expanded(child: FriendTextFields(i)),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   // we need add button at last friends row
//                   _addRemoveButton(
//                       i == friendsList.length - 1, i, friendsList.length),
//                 ],
//               ),
//             ]),
//           ),
//         ),
//       ));
//     }
//     return friendsTextFields;
//   }

//   /// add / remove button
//   Widget _addRemoveButton(bool add, int index, int lastIndex) {
//     return InkWell(
//       onTap: () {
//         if (add) {
//           // add new text-fields at the top of all friends textfields
//           friendsList.insert(lastIndex, null);
//         } else
//           friendsList.removeAt(index);
//         setState(() {});
//       },
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: (add) ? Colors.green : Colors.red,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Icon(
//           (add) ? Icons.add : Icons.remove,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// class FrTextFields extends StatefulWidget {
//   final int index;
//   FrTextFields(this.index);
//   @override
//   _FrTextFieldsState createState() => _FrTextFieldsState();
// }

// class _FrTextFieldsState extends State<FrTextFields> {
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
//       _nameController.text =
//           _EducationEditState.friendsList[widget.index] ?? '';
//     });

//     return TextFormField(
//       controller: _nameController,
//       onChanged: (v) => _EducationEditState.friendsList[widget.index] = v,
//       decoration: InputDecoration(
//           suffixIcon: Icon(Icons.date_range_rounded),
//           hintText: 'Masa Kerja Akhir'),
//       validator: (v) {
//         if (v.trim().isEmpty) return 'Please enter something';
//         return null;
//       },
//     );
//   }
// }
