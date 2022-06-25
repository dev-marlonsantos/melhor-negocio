import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configurations {
  static List<DropdownMenuItem<String>> getStates() {
    List<DropdownMenuItem<String>> _statesDropDownList = [];
    _statesDropDownList.add(const DropdownMenuItem(
      child: Text(
        "Região",
        style: TextStyle(color: Color(0xff9c27b0)),
      ),
      value: null,
    ));
    for (var state in Estados.listaEstados) {
      _statesDropDownList.add(DropdownMenuItem(
        child: Text(state),
        value: state,
      ));
    }
    return _statesDropDownList;
  }

  static List<DropdownMenuItem<String>> getCategories() {
    List<DropdownMenuItem<String>> _categoriesDropDownList = [];
    _categoriesDropDownList.add(const DropdownMenuItem(
      child: Text(
        "Categoria",
        style: TextStyle(color: Color(0xff9c27b0)),
      ),
      value: null,
    ));
    _categoriesDropDownList.add(const DropdownMenuItem(
      child: Text("Automóvel"),
      value: "automovel",
    ));
    _categoriesDropDownList.add(const DropdownMenuItem(
      child: Text("Informática"),
      value: "informatica",
    ));
    _categoriesDropDownList.add(const DropdownMenuItem(
      child: Text("Móveis"),
      value: "moveis",
    ));
    _categoriesDropDownList.add(const DropdownMenuItem(
      child: Text("Roupas"),
      value: "roupas",
    ));
    _categoriesDropDownList.add(const DropdownMenuItem(
      child: Text("Outros"),
      value: "outros",
    ));
    return _categoriesDropDownList;
  }
}
