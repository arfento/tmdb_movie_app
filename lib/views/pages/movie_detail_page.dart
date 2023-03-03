import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';
  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
