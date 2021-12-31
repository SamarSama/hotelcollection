import 'package:flutter/cupertino.dart';

class Drawermodel{
  IconData _drawericon;
  String _drawertext;
  int _index;
  Drawermodel(this._drawericon,this._drawertext,this._index);

  String get drawertext => _drawertext;

  set drawertext(String value) {
    _drawertext = value;
  }

  IconData get drawericon => _drawericon;

  set drawericon(IconData value) {
    _drawericon = value;
  }

  int get index => _index;

  set index(int value) {
    _index = value;
  }
}