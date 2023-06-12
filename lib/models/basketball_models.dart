import 'package:flutter/material.dart';

class Team {
  final int id;
  final String name;
  final String full_name;
  final String city;
  final String abbreviation;

  Team(
      {required this.id,
      required this.name,
      required this.full_name,
      required this.city,
      required this.abbreviation});
}
