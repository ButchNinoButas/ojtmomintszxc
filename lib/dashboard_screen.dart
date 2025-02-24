// dashboard_screen.dart
// ignore_for_file: library_private_types_in_public_api, deprecated_member_use
import 'package:azakarstream/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'movie_details_screen.dart';
import 'view_all_movies_screen.dart'; // Import the new screen
import 'genre_screen.dart'; // Import the GenreScreen
import 'favorites_screen.dart'; // Import the FavoriteScreen
import 'profile_screen.dart'; // Import the ProfileScreen
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const DashboardScreen());
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedGenre; // Track the selected genre
  int _selectedNavIndex = 0; // Track the selected navigation index

  AdRequest? adRequest;
  BannerAd? bannerAd;

  // Variable to track the last back button press time
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();

    String bannerId = Platform.isAndroid
        ? "ca-app-pub-3940256099942544/6300978111"
        : "ca-app-pub-3940256099942544/2934735716";

    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );
    BannerAdListener bannerAdListener = BannerAdListener(
      onAdClosed: (ad) {
        bannerAd?.load();
      },
      onAdFailedToLoad: (ad, error) {
        bannerAd?.load();
      },
    );
    bannerAd = BannerAd(
      size: AdSize.fluid,
      adUnitId: bannerId,
      request: adRequest!,
      listener: bannerAdListener,
    );
    bannerAd!.load();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    bannerAd?.dispose();
    super.dispose();
  }

  // Updated movie lists with videoUrl field.
  final List<Map<String, String>> newReleases = [
    {
      'title': 'One Piece',
      'rating': '★★★★★',
      'reviews': '(100k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMTNjNGU4NTUtYmVjMy00YjRiLTkxMWUtNzZkMDNiYjZhNmViXkEyXkFqcGc@._V1_.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl':
          'https://res.cloudinary.com/dywykbqpw/video/upload/zrf1mbajhv8m24n9gxi7.mp4',
    },
    {
      'title': 'One Punch Man',
      'rating': '★★★★☆',
      'reviews': '(55k)',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/en/c/c3/OnePunchMan_manga_cover.png',
      'genre': 'Adventure',
      'duration': '2h 4m',
      'videoUrl':
          'https://res.cloudinary.com/dywykbqpw/video/upload/One_Punch_Man_Season_1_-_Episode_05_English_Sub_gvmv1g.mp4',
    },
    {
      'title': 'Sakamoto Days',
      'rating': '★★★★★',
      'reviews': '(35k)',
      'imageUrl':
          'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739157398/Sakamoto_qmwwmw.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl':
          'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_SAKAMOTO_DAYS_-_01_1080p_v0.mkv_1_qccg8z.mp4',
    },
    {
      'title': 'I Have a Crush at Work',
      'rating': '★★★★★',
      'reviews': '(105k)',
      'imageUrl':
          'https://res.cloudinary.com/dkhe2vgto/image/upload/9f76212f36053b1cb40bf7468b463e82_dyctyj.jpg',
      'genre': 'Romance',
      'duration': '2h 4m',
      'videoUrl':
          'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_I_Have_a_Crush_at_Work_-_01_1080p_v0.mkv_fslfz2.mp4',
    },
    {
      'title': 'Spider-Man: No Way Home',
      'rating': '★★★★★',
      'reviews': '(200k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'videoUrl':
          'https://res.cloudinary.com/dkhe2vgto/video/upload/y2mate.com_-_Defeating_Doc_Ock_SpiderMan_2_Voyage_With_Captions_1080_eufgx6.mp4',
    },
    {
      'title': 'Horimiya: The Missing Pieces',
      'rating': '★★★★★',
      'reviews': '(10k)',
      'imageUrl':
          'https://res.cloudinary.com/dkhe2vgto/image/upload/horimiya_mekupa.jpg',
      'genre': 'Fantasy',
      'duration': '2h 4m',
      'videoUrl':
          'https://res.cloudinary.com/dkhe2vgto/video/upload/SubsPlease_Horimiya_-_Piece_-_01_1080p_F8A2CB28_.mkv_wan7d0.mp4',
    },
  ];

  final List<Map<String, String>> mostPopular = [
    {
      'title': 'The Batman',
      'rating': '★★★★☆',
      'reviews': '(95k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_.jpg',
      'genre': 'Action',
      'duration': '2h 56m',
      'videoUrl': 'https://example.com/the_batman.mp4',
    },
    {
      'title': 'Black Panther',
      'rating': '★★★★★',
      'reviews': '(150k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BNTM4NjIxNmEtYWE5NS00NDczLTkyNWQtYThhNmQyZGQzMjM0XkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Action',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/black_panther.mp4',
    },
    {
      'title': 'Avatar: The Way of Water',
      'rating': '★★★★☆',
      'reviews': '(120k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Drama',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/avatar_the_way_of_water.mp4',
    },
    {
      'title': 'Top Gun: Maverick',
      'rating': '★★★★★',
      'reviews': '(180k)',
      'imageUrl':
          'https://m.media-amazon.com/images/M/MV5BZWYzOGEwNTgtNWU3NS00ZTQ0LWJkODUtMmVhMjIwMjA1ZmQwXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_FMjpg_UX1000_.jpg',
      'genre': 'Action',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/top_gun_maverick.mp4',
    },
    {
      'title': 'Titanic',
      'rating': '★★★★★',
      'reviews': '(180k)',
      'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/titanic_xowrkm.jpg',
      'genre': 'Romance',
      'duration': '2h 14m',
      'videoUrl': 'https://example.com/titanic.mp4',
    },
    {
      'title': 'The Little Man',
      'rating': '★★★★☆',
      'reviews': '(95k)',
      'imageUrl':
          'https://th.bing.com/th/id/OIP.VcW6HtnsQerz4KJBq6IxAwHaKb?w=588&h=828&rs=1&pid=ImgDetMain',
      'genre': 'Comedy',
      'duration': '2h 56m',
      'videoUrl': 'https://example.com/the_little_man.mp4',
    },
  ];

  /// Updated _buildFeaturedMovie() using CarouselSlider with a manually defined list of 5 items.
  Widget _buildFeaturedMovie() {
  final List<Map<String, String>> featuredMovies = [
    {
      'title': 'Dandadan',
      'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739845371/4bf31391f0e3625ab6354559837ceaa3_toiu6i.jpg',
      'genre': 'Sci-Fi',
      'duration': '2h 30m',
      'rating': '★★★★☆',
      'videoUrl': 'https://example.com/dandadan.mp4',
      'description': 'Dandadan is an action-packed sci-fi adventure about a mysterious power.',
    },
    {
      'title': 'Dr Strange Multiverse of Madness',
      'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739845887/NJXQ8h3mUd9mhsh2m8xpba_q1xb3d.jpg',
      'genre': 'Action',
      'duration': '2h 10m',
      'rating': '★★★★★',
      'videoUrl': 'https://example.com/dr_strange.mp4',
      'description': 'Doctor Strange embarks on a journey through the multiverse.',
    },
    {
      'title': 'Deadpool and Wolverine',
      'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/v1739844746/f1c7ce3e91b7b22bf3f1f5ec5b45afa8_uezt9b.jpg',
      'genre': 'Comedy',
      'duration': '2h 15m',
      'rating': '★★★★★',
      'videoUrl': 'https://example.com/deadpool_wolverine.mp4',
      'description': 'Deadpool and Wolverine team up for an unexpected adventure.',
    },
    {
      'title': 'Sakamoto Days',
      'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/w_1000,ar_1:1,c_fill,g_auto,e_art:hokusai/e1bcaa8cce3b5b4ca11e4ed9580e4a17_um4bt0.jpg',
      'genre': 'Action',
      'duration': '2h 4m',
      'rating': '★★★★★',
      'videoUrl': 'https://res.cloudinary.com/dkhe2vgto/video/upload/AH2_SAKAMOTO_DAYS_-_01_1080p_v0.mkv_1_qccg8z.mp4',
      'description': 'Sakamoto, a former hitman, tries to live a peaceful life but trouble follows him.',
    },
    {
      'title': 'Oppenheimer',
      'imageUrl': 'https://res.cloudinary.com/dkhe2vgto/image/upload/w_1000,ar_1:1,c_fill,g_auto,e_art:hokusai/v1739844423/51599e316a0a4a3ad751721f505ca4e4_baxqnf.jpg',
      'genre': 'Drama',
      'duration': '3h 0m',
      'rating': '★★★★★',
      'videoUrl': 'https://example.com/oppenheimer.mp4',
      'description': 'A historical drama about the making of the atomic bomb and its consequences.',
    },
  ];

  return CarouselSlider(
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.4,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      viewportFraction: 1.0,
    ),
    items: featuredMovies.map((movie) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(
                title: movie['title']!,
                genre: movie['genre']!,
                duration: movie['duration']!,
                rating: movie['rating']!,
                description: movie['description']!,
                imageUrl: movie['imageUrl']!,
                videoUrl: movie['videoUrl']!,
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(movie['imageUrl']!),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Color(0xCC000000),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );


  }

  Widget _buildTopBar() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Time and Location (if needed)
        Row(
          children: [
            Text(
              '', // Replace with actual time if needed.
              style: TextStyle(
                color: isDark
                    ? Colors.white
                    : const Color(0xFF1A4D2E).withOpacity(0.6),
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'DramaMania',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF4d0066),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        // Search and Notifications
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.search,
                  color: isDark ? Colors.white : const Color(0xFF4d0066)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      allMovies: [...newReleases, ...mostPopular],
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications,
                  color: isDark ? Colors.white : const Color(0xFF4d0066)),
              onPressed: () {
                // Implement notifications if needed.
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenres() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genres',
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF4d0066),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _GenreChip(
                title: 'Fantasy',
                genre: 'Fantasy',
                isSelected: _selectedGenre == 'Fantasy',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Drama',
                genre: 'Drama',
                isSelected: _selectedGenre == 'Drama',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Action',
                genre: 'Action',
                isSelected: _selectedGenre == 'Action',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Romance',
                genre: 'Romance',
                isSelected: _selectedGenre == 'Romance',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Comedy',
                genre: 'Comedy',
                isSelected: _selectedGenre == 'Comedy',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Anime',
                genre: 'Anime',
                isSelected: _selectedGenre == 'Anime',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Horror',
                genre: 'Horror',
                isSelected: _selectedGenre == 'Horror',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Thriller',
                genre: 'Thriller',
                isSelected: _selectedGenre == 'Thriller',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Sci-Fi',
                genre: 'Sci-Fi',
                isSelected: _selectedGenre == 'Sci-Fi',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Mystery',
                genre: 'Mystery',
                isSelected: _selectedGenre == 'Mystery',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Adventure',
                genre: 'Adventure',
                isSelected: _selectedGenre == 'Adventure',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
              _GenreChip(
                title: 'Documentary',
                genre: 'Documentary',
                isSelected: _selectedGenre == 'Documentary',
                onSelected: (genre) {
                  setState(() {
                    _selectedGenre = genre;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenreScreen(
                        genre: genre,
                        allMovies: [...newReleases, ...mostPopular],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewReleases() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New Releases',
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF4d0066),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewAllMoviesScreen(movies: newReleases)),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF4d0066),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 281,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: newReleases
                .map(
                  (movie) => _MovieCard(
                    title: movie['title']!,
                    rating: movie['rating']!,
                    reviews: movie['reviews']!,
                    imageUrl: movie['imageUrl']!,
                    genre: movie['genre']!,
                    duration: movie['duration']!,
                    videoUrl: movie['videoUrl']!,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreMovies() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Most Popular',
              style: TextStyle(
                color: isDark ? Colors.white : const Color(0xFF4d0066),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewAllMoviesScreen(movies: mostPopular)),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF4d0066),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 281,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: mostPopular
                .map(
                  (movie) => _MovieCard(
                    title: movie['title']!,
                    rating: movie['rating']!,
                    reviews: movie['reviews']!,
                    imageUrl: movie['imageUrl']!,
                    genre: movie['genre']!,
                    duration: movie['duration']!,
                    videoUrl: movie['videoUrl']!,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF4d0066),
      selectedItemColor: const Color(0xFFF5EFE6),
      unselectedItemColor: const Color(0xFFF5EFE6).withOpacity(0.5),
      currentIndex: _selectedNavIndex,
      onTap: (index) {
        setState(() {
          _selectedNavIndex = index;
        });

        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoriteScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        // Exit the app on second back press
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [
                      const Color(0xFF660066),
                      const Color(0xFF4d004d),
                      const Color(0xFF330033),
                      const Color(0xFF1a001a),
                      const Color(0xFF000000),
                      const Color(0xFF000000),
                    ]
                  : [
                      const Color(0xFFf9e6ff),
                      const Color(0xFFf9e6ff),
                      const Color(0xFFf2ccff),
                      const Color(0xFFecb3ff),
                      const Color(0xFFe699ff),
                      const Color(0xFFdf80ff),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 20),
                  _buildFeaturedMovie(),
                  const SizedBox(height: 25),
                  _buildGenres(),
                  const SizedBox(height: 25),
                  _buildNewReleases(),
                  _buildMoreMovies(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (bannerAd != null)
              SizedBox(
                height: 50,
                child: AdWidget(ad: bannerAd!),
              ),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String title;
  final String genre;
  final bool isSelected;
  final Function(String) onSelected;

  const _GenreChip({
    required this.title,
    required this.genre,
    required this.isSelected,
    required this.onSelected,
  });

  // Function to determine the background color based on the genre
  Color getGenreColor(String genre) {
    switch (genre) {
      case 'Romance':
        return Colors.pink;
      case 'Action':
        return Colors.red;
      case 'Fantasy':
        return Colors.purple;
      case 'Drama':
        return Colors.blue;
      case 'Comedy':
        return Colors.orange;
      case 'Adventure':
        return Colors.green;
      case 'Horror':
        return Colors.brown;
      case 'Thriller':
        return Colors.deepPurple;
      case 'Sci-Fi':
        return Colors.cyan;
      case 'Mystery':
        return Colors.indigo;
      case 'Documentary':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(genre),
      hoverColor: getGenreColor(genre).withOpacity(0.5), // Highlight color on hover
      borderRadius: BorderRadius.circular(20), // Match the chip's border radius
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? getGenreColor(genre) : Colors.white, // Background color
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: getGenreColor(genre), // Border color matches the background
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : getGenreColor(genre), // Text color
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String title;
  final String rating;
  final String reviews;
  final String imageUrl;
  final String genre;
  final String duration;
  final String videoUrl;

  const _MovieCard({
    required this.title,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.genre,
    required this.duration,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        // Pass details including videoUrl to the MovieDetailsScreen.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              title: title,
              genre: genre,
              duration: duration,
              rating: rating,
              description: 'This is a detailed description of the movie $title.',
              imageUrl: imageUrl,
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Container(
        width: 160, // Set a fixed width for consistency
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isDarkMode ? Colors.black : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover, // Ensures the image scales proportionally
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2, // Prevents text overflow
                    overflow: TextOverflow.ellipsis, // Adds "..." for overflowing text
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : const Color(0xFF1A4D2E),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        rating,
                        style: TextStyle(
                          color: isDarkMode ? Colors.amber : const Color(0xFFF3C63F),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded( // Prevents the reviews text from exceeding the width
                        child: Text(
                          '($reviews reviews)',
                          maxLines: 1, // Ensures the text stays on one line
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.7)
                                : const Color(0xFF1A4D2E).withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
