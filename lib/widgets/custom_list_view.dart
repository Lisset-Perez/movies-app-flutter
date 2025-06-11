import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class CustomListView extends StatelessWidget {
  final List<Movie> movies;

  const CustomListView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Películas en cartelera',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.indigo,
            ),
          ),
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 250,
          width: double.infinity,
          //color: Colors.amber,
          //GestureDetector
          child: ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: 'Movie'),
                child: Container(
                  width: 120,
                  height: 180,
                  margin: EdgeInsets.all(10),
                  //color: Colors.indigo,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          width: 150,
                          height: 180,
                          placeholder: AssetImage('assets/images/loading.gif'),
                          image: NetworkImage(movies[i].getPosterPath),
                        ),
                      ),
                      Text(
                        movies[i].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Estreno: ${movies[i].releaseDate.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
