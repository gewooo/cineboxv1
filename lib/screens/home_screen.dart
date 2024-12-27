import 'package:cinebox/helper/helper.dart';
import 'package:cinebox/models/movies.dart';
import 'package:cinebox/screens/add_movies.dart';
import 'package:cinebox/screens/viewMovie.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbHelper movieDb = DbHelper.instance;
  List<MovieDetails> movies = [];
  List<MovieDetails> filteredMovies = [];
  final TextEditingController searchCtrl = TextEditingController();
  String? selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    getMovies(); // Load movies on init
    searchCtrl.addListener(() {
      filterMovies(); // Trigger filtering based on the search input
    });
  }

  // Fetch movies from the database
  void getMovies() async {
    List<MovieDetails> movieList = await movieDb.getMovies();
    setState(() {
      movies = movieList;
      filteredMovies = movieList; // Set filteredMovies to all movies initially
    });
  }

  void addToMovies(MovieDetails movie) {
    setState(() {
      movies.add(movie);
      filteredMovies = movies; // Refresh filteredMovies list
    });
  }

  void deleteMovie(MovieDetails movie) {
    setState(() {
      movies.remove(movie);
      filteredMovies = movies; // Refresh filteredMovies list
    });
  }

  void changeMoveStatus(MovieDetails movie) {
    setState(() {
      movie.status = 'Watched';
    });
  }

  // Filter movies based on search query and selected tab
  void filterMovies() {
    setState(() {
      filteredMovies = movies
          .where((movie) =>
              (movie.title
                  .toLowerCase()
                  .contains(searchCtrl.text.toLowerCase())) &&
              (selectedStatus == 'All' || movie.status == selectedStatus))
          .toList();
    });
  }

  void viewDetails(MovieDetails movie, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Viewmovie(
          movie: movie,
          onDelete: () => deleteMovie(movie),
          onStatusChange: () => changeMoveStatus(movie),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 33, 19),
          elevation: 0,
          title: const Text(
            'CineBox',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    selectedStatus = 'All';
                    break;
                  case 1:
                    selectedStatus = 'To Watch';
                    break;
                  case 2:
                    selectedStatus = 'Watched';
                    break;
                }
                filterMovies(); // Update filtered movies on tab change
              });
            },
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'To Watch'),
              Tab(text: 'Watched'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white, // Text color for the selected tab
            unselectedLabelColor:
                Colors.white70, // Text color for unselected tabs
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredMovies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.movie_creation_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No movies found!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = filteredMovies[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridTile(
                            child: GestureDetector(
                              onTap: () => viewDetails(movie, context),
                              child: movie.imageUrl == null ||
                                      movie.imageUrl!.isEmpty
                                  ? Image.asset(
                                      'assets/images/default.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      movie.imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            footer: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(123, 0, 0, 0),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      movie.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      movie.status,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: movie.status == 'Watched'
                                            ? Colors.greenAccent
                                            : Colors.amberAccent,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 233, 33, 19),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMovies(addlist: addToMovies),
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
