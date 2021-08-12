import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ziplike/Constants/constants.dart';

import '../Loading.dart';
class invite_contacts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
 return invite_contacts_state();
  }

}
class invite_contacts_state extends State<invite_contacts>{

  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getPermissions();
  }
  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getAllContacts();
      searchController.addListener(() {
        filterContacts();
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    setState(() {
      contacts = _contacts;
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }

        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }
/*
  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemsExist = (contactsFiltered.length > 0 || contacts.length > 0);
    return Scaffold(
      appBar: AppBar(
        title: Text('contact'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor
                    )
                ),
              ),
            ),
            listItemsExist == true ?
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];

                  var baseColor = contactsColorMap[contact.displayName] as dynamic;

                  Color color1 = baseColor[800];
                  Color color2 = baseColor[400];
                  return ListTile(
                      title: Text(contact.displayName),
                      subtitle: Text(
                          contact.phones.length > 0 ? contact.phones.elementAt(0).value : ''
                      ),
                      leading: (contact.avatar != null && contact.avatar.length > 0) ?
                      CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar),
                      ) :
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [
                                    color1,
                                    color2,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight
                              )
                          ),
                          child: CircleAvatar(
                              child: Text(
                                  contact.initials(),
                                  style: TextStyle(
                                      color: Colors.white
                                  )
                              ),
                              backgroundColor: Colors.transparent
                          )
                      )
                  );
                },
              ),
            )
                : Container(
              padding: EdgeInsets.all(20),
              child: Text(
                  isSearching ?'No search results to show' : 'No contacts exist',
                  style: Theme.of(context).textTheme.headline6
              ) ,
            )
          ],
        ),
      ),
    );
  }

*/



  @override
  Widget build(BuildContext context) {
   return Scaffold(body:contacts.isEmpty==true?LoadingPage(): ListView.builder(itemCount: contacts.length,
       itemBuilder: (context,index){
     return Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(height: 80,width: MediaQuery.of(context).size.width,child: Row(children: [
             Expanded(flex: 2,
               child:  CircleAvatar(
                 backgroundImage: MemoryImage(contacts[index].avatar),
               )), Expanded(flex: 5,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text(contacts[index].displayName,style: Constants().style_black15,),
                     SizedBox(height: 20,),
                     Text(contacts[index].phones.elementAt(0).value ,style: Constants().style_gray18,),
                   ],
                 ))
, Expanded(flex: 2,
                 child: Container(height: 35,width: 50,color: Colors.black,
                     child: Center(child: Text("INVITE",style: Constants().style_white16,))))












           ],












           ),),
         ),
      Divider() ],
     );
   }),);
  }

}