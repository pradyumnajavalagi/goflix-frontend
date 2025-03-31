import 'package:flutter/material.dart';
import 'movies.dart';

void main() {
  runApp(const MaterialApp(
    home: MoviesPage(),
  ));
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  void _addMovieDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController isbnController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Movie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'Director First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Director Last Name'),
              ),
              TextField(
                controller: isbnController,
                decoration: const InputDecoration(labelText: 'ISBN'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final localContext = context;
                final movie = {
                  'Isbn': isbnController.text,
                  'Title': titleController.text,
                  'Director': {
                    'FirstName': firstNameController.text,
                    'LastName': lastNameController.text,
                  },
                };

                await MovieService().addMovie(movie);
                if (!mounted) return;
                setState(() {});
                if(localContext.mounted){
                  Navigator.pop(localContext);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _showEditDialog(Map<String, dynamic> movie) {
    TextEditingController titleController = TextEditingController(text: movie['Title']);
    TextEditingController firstNameController = TextEditingController(text: movie['Director']['FirstName']);
    TextEditingController lastNameController = TextEditingController(text: movie['Director']['LastName']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Movie'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'Director First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Director Last Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final localContext = context;
                final updatedMovie = {
                  'Id': movie['Id'],
                  'Isbn': movie['Isbn'],
                  'Title': titleController.text,
                  'Director': {
                    'FirstName': firstNameController.text,
                    'LastName': lastNameController.text,
                  },
                };
                await MovieService().updateMovie(movie['Id'].toString(), updatedMovie);
                if (!mounted) return;
                setState(() {});
                if(localContext.mounted){
                  Navigator.pop(localContext);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: FutureBuilder(
        future: MovieService().getMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = snapshot.data[index];

                return ListTile(
                  title: Text(movie['Title'] ?? 'No title'),
                  subtitle: Text(
                    movie['Director'] is Map
                        ? '${movie['Director']['FirstName']} ${movie['Director']['LastName']}'
                        : 'No director',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditDialog(movie),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          MovieService().deleteMovie(movie['Id'].toString());
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _addMovieDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
