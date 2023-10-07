import 'package:api_calling/Bloc/AnimeBloc/anime_bloc.dart';
import 'package:api_calling/Repository/modelclass/AnimeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

late AnimeModel anime;

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    BlocProvider.of<AnimeBloc>(context).add(FetchAnime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        BlocBuilder<AnimeBloc, AnimeState>(
          builder: (context, state) {
            if(state is AnimeblocLoading){
              return Center(child: CircularProgressIndicator());
            }
            if(state is AnimeblocError){
              return Center(child: Text("error"),);
            }
            if(state is AnimeblocLoaded){
              anime=   BlocProvider.of<AnimeBloc>(context).animeModel;
            return GridView.builder(
              itemCount: anime.data!.length,
              // replace with the actual number of items in your list
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Card(color: Colors.white,
                  elevation: 4,
                  child: Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.all(8),
                      color: Colors.white,
                      child:
                      Image.network(anime.data![index].image.toString(), fit: BoxFit.cover,)),
                );
              },
            );}else{
              return SizedBox();
            }
          },
        )
    );
  }
}
