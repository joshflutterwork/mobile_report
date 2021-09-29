import 'package:flutter/material.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.wb_cloudy,
        ),
        title: Text('REGISTER USERS'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body:
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Color(0xFF30C1FF),
          //         Color(0xFF2AA7DC),
          //       ],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          //   child:
          users.length <= 0
              ? Center(
                  child: EmptyState(
                    title: 'Oops',
                    message: 'Add form by tapping add button below',
                  ),
                )
              : SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    itemCount: users.length,
                    itemBuilder: (ctx, i) => users[i],
                  ),
                ),
      //),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (users.length > 0) {
      var allValid = true;
      users.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = users.map((it) => it.user).toList();
        print(data);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     fullscreenDialog: true,
        //     builder: (_) => Scaffold(
        //       appBar: AppBar(
        //         title: Text('List of Users'),
        //       ),
        //       body: ListView.builder(
        //         itemCount: data.length,
        //         itemBuilder: (_, i) => ListTile(
        //           leading: CircleAvatar(
        //             child: Text(data[i]!.fullName.substring(0, 1)),
        //           ),
        //           title: Text(data[i]!.fullName),
        //           subtitle: Text(data[i]!.email),
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      }
    }
  }
}

typedef OnDelete();

class UserForm extends StatefulWidget {
  final User? user;
  final state = _UserFormState();
  final OnDelete? onDelete;

  UserForm({Key? key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('User Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.user!.fullName,
                  onSaved: (String? val) => widget.user!.fullName = val!,
                  // validator: (val) =>
                  //     val.length > 3 ? null : 'Full name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.user!.email,
                  onSaved: (String? val) => widget.user!.email = val!,
                  // validator: (val) =>
                  //     val!.contains('@') ? null : 'Email is invalid',
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    icon: Icon(Icons.email),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}

class User {
  String fullName;
  String email;

  User({this.fullName = '', this.email = ''});
}

class EmptyState extends StatelessWidget {
  final String title, message;
  EmptyState({this.title = '', this.message = ''});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 16,
      color: Theme.of(context).cardColor.withOpacity(.95),
      shadowColor: Theme.of(context).accentColor.withOpacity(.5),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}
