import 'package:cinebox/helper/helper.dart';
import 'package:cinebox/models/movies.dart';
import 'package:flutter/material.dart';

class Viewmovie extends StatefulWidget {
  const Viewmovie(
      {super.key,
      required this.movie,
      required this.onDelete,
      required this.onStatusChange});

  final MovieDetails movie;
  final VoidCallback onDelete;
  final VoidCallback onStatusChange;

  @override
  State<Viewmovie> createState() => _ViewmovieState();
}

class _ViewmovieState extends State<Viewmovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.movie.imageUrl != null &&
                widget.movie.imageUrl!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.movie.imageUrl!,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              widget.movie.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(255, 149, 149, 149),
                      width: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.movie, size: 24, color: Colors.grey),
                      SizedBox(height: 4),
                      Text(
                        'Genre',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.movie.genre,
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
                      color: const Color.fromARGB(
                          255, 149, 149, 149), // Border color
                      width: 0.5, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.watch_later, size: 24, color: Colors.grey),
                      SizedBox(height: 4),
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.movie.status,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: widget.movie.status == 'Watched'
                              ? Colors.greenAccent
                              : const Color.fromARGB(255, 224, 206, 43),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (widget.movie.description != null &&
                widget.movie.description!.isNotEmpty)
              Text(
                widget.movie.description!,
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Ensures buttons stretch to full width
              children: [
                if (widget.movie.status != "Watched")
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12), // Adds space below the first button
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
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Centers the row content
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
                  padding: const EdgeInsets.only(
                      top: 12), // Adds space above the delete button
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
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Centers the row content
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
            borderRadius: BorderRadius.circular(15),
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
            'Are you sure you want to mark "${widget.movie.title}" as "Watched"?',
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
                await DbHelper.instance
                    .updateMovie(widget.movie.id!, 'Watched');

                // Update the movie status locally
                setState(() {
                  widget.movie.status =
                      'Watched'; // Ensure this is a state update
                });

                // Trigger the status change callback to refresh the UI
                widget.onStatusChange();

                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
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
            borderRadius:
                BorderRadius.circular(15), // Rounded corners for the dialog
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
            'Are you sure you want to delete "${widget.movie.title}"?',
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
                await DbHelper.instance.deleteMovie(widget.movie.id!);
                widget
                    .onDelete(); // Call the onDelete function to update the UI

                // Close the dialog
                Navigator.of(context).pop(); // Close the dialog

                // Go back to the previous screen (home screen)
                Navigator.of(context)
                    .pop(); // This will pop the current screen (view movie) from the navigation stack
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
