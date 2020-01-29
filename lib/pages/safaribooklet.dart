import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kapp/pages/lightinginfo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './typepropertyuser.dart';

class SafariBookletPage extends StatefulWidget {
  SafariBookletPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _SafariBookletPageState createState() => _SafariBookletPageState();
}

class _SafariBookletPageState extends State<SafariBookletPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _safari_booklet_common_name;
FocusNode _safari_booklet_father_name;
FocusNode _safari_booklet_machinegun_no;
FocusNode _safari_booklet_issue_date;
  Future<String> appimagepicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var apppath = await getApplicationDocumentsDirectory();
    var filename = image.path.split("/").last;
    var localfile = await image.copy('${apppath.path}/$filename');
    return localfile.path;
  }

  String setapptext({String key}) {
    return AppTranslations.of(context).text(key);
  }

  Widget formheader({String headerlablekey}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(177, 201, 224, 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            setapptext(key: headerlablekey),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget nextbutton() {
    return GestureDetector(
      onTap: () async {
        if (!(_formkey.currentState.validate())) {
          return;
        } else {
          _formkey.currentState.save();
          await DBHelper()
              .updatePropertySurvey(localdata, localdata.local_property_key);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TypePropertyUserPage(
                localdata: localdata,
              ),
            ),
          );
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Next",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget backbutton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LightingInfoPage(
              localdata: localdata,
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back_ios),
            Text(
              "Back",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    localdata = new LocalPropertySurvey();
    localdata = widget.localdata;
    super.initState();
    _safari_booklet_common_name = new FocusNode();
_safari_booklet_father_name = new FocusNode();
_safari_booklet_machinegun_no = new FocusNode();
_safari_booklet_issue_date = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Property Survey",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<DBHelper>(
        builder: (context, dbdata, child) {
          return dbdata.state == AppState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //header
                        formheader(headerlablekey: 'key_safari_info'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  initvalue: localdata
                                              .safari_booklet_common_name
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_common_name,
                                  headerlablekey: setapptext(key: 'key_Common_name'),
                                  fieldfocus: _safari_booklet_common_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_common_name.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_safari_booklet_father_name);
                                  },
                                  radiovalue: localdata
                                              .safari_booklet_common_name
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  hinttextkey:setapptext(key:  'key_enter_1st_surveyor'),
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.safari_booklet_common_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_common_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue: localdata
                                              .safari_booklet_father_name
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_father_name,
                                  headerlablekey:setapptext(key:  'key_father_name'),
                                  fieldfocus: _safari_booklet_father_name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_father_name.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_safari_booklet_machinegun_no);
                                  },
                                  radiovalue: localdata
                                              .safari_booklet_father_name
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  hinttextkey:setapptext(key:  'key_enter_1st_surveyor'),
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.safari_booklet_father_name =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_father_name =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue: localdata
                                              .safari_booklet_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_machinegun_no,
                                  headerlablekey:setapptext(key: 
                                      'key_Safari_Machine_Gun_Number'),
                                      fieldfocus: _safari_booklet_machinegun_no,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_machinegun_no.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_safari_booklet_issue_date);
                                  },
                                  radiovalue: localdata
                                              .safari_booklet_machinegun_no
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  hinttextkey: setapptext(key: 'key_enter_1st_surveyor'),
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.safari_booklet_machinegun_no =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_machinegun_no =
                                        value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                keyboardtype: TextInputType.datetime,
                                  initvalue: localdata.safari_booklet_issue_date
                                              ?.isEmpty ??
                                          true
                                      ? ""
                                      : localdata.safari_booklet_issue_date,
                                  headerlablekey: setapptext(key: 'key_Issued_Date'),
                                  fieldfocus: _safari_booklet_issue_date,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _safari_booklet_issue_date.unfocus(); },
                                  radiovalue: localdata
                                              .safari_booklet_issue_date
                                              ?.isEmpty ??
                                          true
                                      ? false
                                      : true,
                                  hinttextkey: setapptext(key: 'key_way_to_enter'),
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.safari_booklet_issue_date =
                                        value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.safari_booklet_issue_date =
                                        value.trim();
                                    setState(() {});
                                  }),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(176, 174, 171, 1),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            completedcheckbox(
                                                isCompleted: localdata
                                                            .safari_booklet_picture
                                                            ?.isEmpty ??
                                                        true
                                                    ? false
                                                    : true),
                                            Flexible(
                                              child: Text(
                                                setapptext(
                                                    key:
                                                        'key_Picture_of_Safari_Booklet'),
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RaisedButton(
                                                  child: Text(
                                                      "Click here to capture image. (< 10MB)"),
                                                  onPressed: () async {
                                                    localdata
                                                            .safari_booklet_picture =
                                                        await appimagepicker();
                                                    setState(() {});
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: localdata
                                                        .safari_booklet_picture
                                                        ?.isEmpty ??
                                                    true
                                                ? Center(
                                                    child: Text("No image"),
                                                  )
                                                : Image.file(
                                                    File(localdata
                                                        .safari_booklet_picture),
                                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //footer
                        Container(
                          child: Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueAccent,
                              ),
                              Container(
                                color: Colors.blue,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      backbutton(),
                                      nextbutton()
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}