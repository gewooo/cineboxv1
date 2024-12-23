import 'package:cinebox/helper/helper.dart';
import 'package:cinebox/models/movies.dart';
import 'package:flutter/material.dart';

class Viewmovie extends StatelessWidget {
  const Viewmovie(
      {super.key,
      required this.movie,
      required this.onDelete,
      required this.onStatusChange});

  final MovieDetails movie;
  final VoidCallback onDelete;
  final VoidCallback onStatusChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title,
        style: TextStyle(
          color: Colors.white
        ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.imageUrl != null && movie.imageUrl!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    movie.imageUrl!,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Genre
              Container(
                  width: 100, // Adjust width as needed
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    border: Border.all(
                      color: const Color.fromARGB(255, 149, 149, 149), // Border color
                      width: 0.4, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.movie, size: 24, color: Colors.grey),
                      const SizedBox(height: 4),
                      const Text(
                        'Genre',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        movie.genre,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                    ],
                  ),
                ),
                // Year
              Container(
                  width: 100, // Adjust width as needed
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    border: Border.all(
                      color: const Color.fromARGB(255, 149, 149, 149), // Border color
                      width: 0.4, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month, size: 24, color: Colors.grey),
                      const SizedBox(height: 4),
                      const Text(
                        'Year',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        movie.year.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                    ],
                  ),
                ),

                // Status
              Container(
                  width: 100, // Adjust width as needed
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    border: Border.all(
                      color: const Color.fromARGB(255, 149, 149, 149), // Border color
                      width: 0.5, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.watch_later, size: 24, color: Colors.grey),
                      const SizedBox(height: 4),
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        movie.status,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: movie.status == 'Watched' ? Colors.greenAccent : const Color.fromARGB(255, 224, 206, 43),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (movie.description != null && movie.description!.isNotEmpty)
              Text(
                movie.description!,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 24),
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures buttons stretch to full width
                children: [
                  if (movie.status != "Watched")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12), // Adds space below the first button
                      child: ElevatedButton(
                        onPressed: () => _confirmStatusChange(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Centers the row content
                          children: [
                            Icon(Icons.visibility, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Mark as Watched',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12), // Adds space above the delete button
                    child: ElevatedButton(
                      onPressed: () => _confirmDelete(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 233, 33, 19),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centers the row content
                        children: [
                          Icon(Icons.delete_forever, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
    void _confirmStatusChange(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners for the dialog
          ),
          title: const Text(
            'Mark as Watched',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          content: Text(
            'Are you sure you want to mark "${movie.title}" as "Watched"?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
             onPressed: () async {
                // Update status in the database
                await DbHelper.instance.updateMovie(movie.id!, 'Watched');

                // Update the movie status locally
                movie.status = 'Watched';

                // Trigger the status change callback to refresh the UI
                onStatusChange();

                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child:   Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

void _confirmDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners for the dialog
        ),
        title: Text(
          'Confirm Delete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${movie.title}"?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Delete the movie from the database
              await DbHelper.instance.deleteMovie(movie.id!);
              onDelete(); // Call the onDelete function to update the UI

              // Close the dialog
              Navigator.of(context).pop(); // Close the dialog

              // Go back to the previous screen (home screen)
              Navigator.of(context).pop(); // This will pop the current screen (view movie) from the navigation stack
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}
}