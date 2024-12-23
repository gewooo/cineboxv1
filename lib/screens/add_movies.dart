import 'package:cinebox/models/movies.dart';
import 'package:flutter/material.dart';
import 'package:cinebox/helper/helper.dart';

class AddMovies extends StatefulWidget {
  const AddMovies({super.key, required this.addlist});

  final Function(MovieDetails) addlist;

  @override
  State<AddMovies> createState() => _AddMoviesState();
}

class _AddMoviesState extends State<AddMovies> {
  final DbHelper movieDb = DbHelper.instance;
  final titleCtrl = TextEditingController();
  final yearCtrl = TextEditingController();
  final genreCtrl = TextEditingController();
  final imgCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final List<String> genres = [
    'Action',
    'Anime',
    'Cartoon',
    'Comedy',
    'Drama',
    'Fantasy',
    'Science Fiction',
    'Horror',
    'Paranormal',
    'Romance',
    'Reality TV',
    'Musical',
    'Other'
  ];

  final List<String> statuses = ['To Watch', 'Watched'];

  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Movie',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: Color.fromARGB(255, 233, 33, 19),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  labelText: 'Movie Title',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(255, 233, 33, 19)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: genreCtrl.text.isEmpty ? null : genreCtrl.text,
                isExpanded: false,
                decoration: InputDecoration(
                  labelText: 'Genre',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(255, 233, 33, 19)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
                items: genres.map((String genre) {
                  return DropdownMenuItem<String>(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    genreCtrl.text = newValue!;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: yearCtrl,
                decoration: InputDecoration(
                  labelText: 'Year of Release',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(255, 233, 33, 19)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(255, 233, 33, 19)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
                items: statuses.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: imgCtrl,
                decoration: InputDecoration(
                  labelText: 'Image URL (Optional)',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(255, 233, 33, 19)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionCtrl,
                decoration: InputDecoration(
                  labelText: 'Description (Optional)',
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(255, 233, 33, 19)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: addToList,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 233, 33, 19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    'Save Movie',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToList() async {
    if (titleCtrl.text.isEmpty ||
        genreCtrl.text.isEmpty ||
        yearCtrl.text.isEmpty ||
        selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final movie = MovieDetails(
      title: titleCtrl.text,
      genre: genreCtrl.text,
      year: int.tryParse(yearCtrl.text) ?? 0,
      status: selectedStatus!,
      imageUrl: imgCtrl.text.isNotEmpty ? imgCtrl.text : null,
      description:
          descriptionCtrl.text.isNotEmpty ? descriptionCtrl.text : null,
    );

    // Insert movie into the database
    int id = await DbHelper.instance.insertMovie(movie);

    // Update the movie object with the generated id
    movie.id = id;

    // Pass the movie back to the parent widget
    widget.addlist(movie);
    Navigator.pop(context);
  }
}
