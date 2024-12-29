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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 149, 149, 149),
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
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 149, 149, 149),
                      width: 0.5,
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
                              : Color.fromARGB(255, 224, 206, 43),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.movie.status != "Watched")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  padding: const EdgeInsets.only(top: 12),
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
          title: Text(
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
                Navigator.of(context).pop();
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
                await DbHelper.instance
                    .updateMovie(widget.movie.id!, 'Watched');

                setState(() {
                  widget.movie.status = 'Watched';
                });

                widget.onStatusChange();

                Navigator.of(context).pop();
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
            borderRadius: BorderRadius.circular(15),
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
                Navigator.of(context).pop();
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
                await DbHelper.instance.deleteMovie(widget.movie.id!);
                widget.onDelete();

                Navigator.of(context).pop();

                Navigator.of(context).pop();
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
