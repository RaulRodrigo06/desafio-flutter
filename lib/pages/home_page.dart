import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:desafio_flutter/blocs/character_bloc.dart';
import 'package:desafio_flutter/widgets/character_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CharacterBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Home"),
        actions: <Widget>[],
      ),
      body: StreamBuilder(
          stream: bloc.outCharacter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return CharacterTile(snapshot.data[index]);
                  } else if (index > 1 &&
                      snapshot.data.length < bloc.api.count) {
                    bloc.list();
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.yellow)),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                ),
              );
            }
          }),
    );
  }
}
