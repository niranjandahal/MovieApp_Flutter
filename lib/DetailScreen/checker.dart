import 'package:flutter/material.dart';
import 'package:r08fullmovieapp/DetailScreen/MovieDetails.dart';
import 'TvSeriesDetail.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui(this.newid, this.newtype, {super.key});

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype.toString() == 'movie') {
      return MovieDetails(
        id: widget.newid,
      );
    } else if (widget.newtype.toString() == 'tv') {
      return TvSeriesDetails(id: widget.newid);
    } else if (widget.newtype.toString() == 'person') {
      // return persondescriptionui(widget.id);
    } else {
      return errorui(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Text('no Such page found'),
    ),
  );
}
