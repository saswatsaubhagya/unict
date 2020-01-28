import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/localpropertydata.dart';
import '../controllers/auth.dart';
import '../localization/app_translations.dart';
import '../utils/db_helper.dart';
import '../widgets/appformcards.dart';
import './lightinginfo.dart';

class FourLimitPage extends StatefulWidget {
  FourLimitPage({this.localdata});
  final LocalPropertySurvey localdata;
  @override
  _FourLimitPageState createState() => _FourLimitPageState();
}

class _FourLimitPageState extends State<FourLimitPage> {
  LocalPropertySurvey localdata;
  var _formkey = GlobalKey<FormState>();
  FocusNode _fore_limits_east;
FocusNode _fore_limits_west;
FocusNode _fore_limits_south;
FocusNode _fore_limits_north;

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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LightingInfoPage(
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
      onTap: () {},
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
    _fore_limits_east = new FocusNode();
_fore_limits_west = new FocusNode();
_fore_limits_south = new FocusNode();
_fore_limits_north = new FocusNode();
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
                        formheader(headerlablekey: 'key_four_limits'),
                        //body
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              formcardtextfield(
                                  initvalue:
                                      localdata.fore_limits_east?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_east,
                                  headerlablekey: setapptext(key: 'key_east'),
                                  fieldfocus: _fore_limits_east,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fore_limits_east.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fore_limits_west);
                                  },

                                  radiovalue:
                                      localdata.fore_limits_east?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_east = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_east = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue:
                                      localdata.fore_limits_west?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_west,
                                  headerlablekey:setapptext(key:  'key_west'),
                                  fieldfocus: _fore_limits_west,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fore_limits_west.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fore_limits_south);
                                  },

                                  radiovalue:
                                      localdata.fore_limits_west?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_west = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_west = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue:
                                      localdata.fore_limits_south?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_south,
                                  headerlablekey:setapptext(key:  'key_south'),
                                  fieldfocus: _fore_limits_south,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _fore_limits_south.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_fore_limits_north);
                                  },

                                  radiovalue:
                                      localdata.fore_limits_south?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_south = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_south = value.trim();
                                    setState(() {});
                                  }),
                              formcardtextfield(
                                  initvalue:
                                      localdata.fore_limits_north?.isEmpty ??
                                              true
                                          ? ""
                                          : localdata.fore_limits_north,
                                  headerlablekey:setapptext(key:  'key_north'),
                                  fieldfocus: _fore_limits_north,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    _fore_limits_north.unfocus(); },
                                  radiovalue:
                                      localdata.fore_limits_north?.isEmpty ??
                                              true
                                          ? false
                                          : true,
                                  validator: (value) {
                                    if (value.trim().isEmpty) {
                                      return "field should not be blank";
                                    }
                                  },
                                  onSaved: (value) {
                                    localdata.fore_limits_north = value.trim();
                                  },
                                  onChanged: (value) {
                                    localdata.fore_limits_north = value.trim();
                                    setState(() {});
                                  }),
                              SizedBox(
                                height: 50,
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
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
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
