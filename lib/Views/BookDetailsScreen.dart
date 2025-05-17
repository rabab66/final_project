// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/Book.dart';
import '../Utils/constants.dart';





// class Book {
//   final String id;
//   final String title;
//   final String author;
//   final String coverUrl;
//   final String description;
//   final String genre;
//   final double rating;
//   final int totalPages;
//   final String pdfUrl;
//   final int currentPage;
//
//   Book({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.coverUrl,
//     required this.description,
//     required this.genre,
//     required this.rating,
//     required this.totalPages,
//     required this.pdfUrl,
//     this.currentPage = 0,
//   });
// }

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool _isLoading = false;
  String? _pdfPath;
  double _downloadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBookInfo(),
                _buildDescription(),
                // _buildReadingProgress(),
                _buildReadButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      floating: false,
      pinned: true,
      backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'book-cover-${widget.book.bookID}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image.network(
              //   widget.book.coverUrl,
              //   fit: BoxFit.cover,
              // ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.book.bookName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'by ${widget.book.author}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {
              // Add to bookmarks functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to bookmarks')),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing book...')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(widget.book.imageURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        // widget.book.genre,
                        "genre",

                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      // widget.book.rating.toString(),
                      "112",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.book, color: Colors.grey, size: 18),
                    const SizedBox(width: 4),
                    // Text(
                    //   '${widget.book.totalPages} pages',
                    //   style: TextStyle(
                    //     color: Colors.grey[600],
                    //     fontSize: 14,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoButton(Icons.bookmark_add_outlined, 'Save'),
                    const SizedBox(width: 12),
                    _buildInfoButton(Icons.rate_review_outlined, 'Review'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Future insertFavorite( ) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userID = prefs.getString("token");
    var url = "books/insertFavorite.php?bookID=" + widget.book.bookID.toString() + "&userID=" + userID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath+url);
    //setState(() { });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The book has been saved to favorites ')),
      );
  }



  Widget _buildInfoButton(IconData icon, String label) {
    return InkWell(
      onTap: () {
        insertFavorite();
        //
        // insertFavorite.php
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[700]),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Text(
          //   widget.book.description,
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: Colors.grey[700],
          //     height: 1.5,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildReadButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _isLoading
          ? Column(
        children: [
          LinearProgressIndicator(
            value: _downloadProgress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 8),
          Text('Downloading... ${(_downloadProgress * 100).toStringAsFixed(0)}%')
        ],
      )
          : SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _openPdf(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _pdfPath != null ? Icons.visibility : Icons.cloud_download,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                _pdfPath != null ? 'Continue Reading' : 'Download ',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openPdf() async {
    if (_pdfPath == null) {
      await _downloadPdf();
    }

    if (_pdfPath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(
            pdfPath: _pdfPath!,
            bookTitle: widget.book.bookName,
            // initialPage: widget.book.currentPage,
            initialPage: 1,

            // totalPages: widget.book.totalPages,
            totalPages: 200,
          ),
        ),
      );
    }
  }

  Future<void> _downloadPdf() async {
    // setState(() {
    //   _isLoading = true;
    //   _downloadProgress = 0.0;
    // });

    // try {
    //   final url = widget.book.pdfURL;
    //   final request = http.Request('GET', Uri.parse(url));
    //   final streamedResponse = await http.Client().send(request);
    //
    //   final contentLength = streamedResponse.contentLength ?? 0;
    //   final Uint8List bytes = await streamedResponse.stream.fold(
    //     Uint8List(0),
    //         (Uint8List previous, List<int> chunk) {
    //       final newList = Uint8List(previous.length + chunk.length);
    //       newList.setRange(0, previous.length, previous);
    //       newList.setRange(previous.length, newList.length, chunk);
    //
    //       // Update download progress
    //       if (contentLength > 0) {
    //         setState(() {
    //           _downloadProgress = newListx.length / contentLength;
    //         });
    //       }
    //
    //       return newList;
    //     },
    //   );

      // Save file locally
      // final dir = await getApplicationDocumentsDirectory();
      // final file = File('${dir.path}/${widget.book.bookID}.pdf');
      // // await file.writeAsBytes(bytes);
      //
      // setState(() {
      //   _pdfPath = file.path;
      //   _isLoading = false;
      // });
    // }
    // catch (e) {
    //   setState(() {
    //     _isLoading = false;
    //   });

      final url = widget.book.pdfURL;

    launch(url);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('downloading PDF ...')),
      );
    // }
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String pdfPath;
  final String bookTitle;
  final int initialPage;
  final int totalPages;

  const PDFViewerScreen({
    Key? key,
    required this.pdfPath,
    required this.bookTitle,
    required this.initialPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  int _currentPage = 0;
  bool _isReady = false;
  late PDFViewController _pdfViewController;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          widget.bookTitle,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Page bookmarked')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.pdfPath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: widget.initialPage,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (_pages) {
              setState(() {
                _isReady = true;
              });
            },
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $error')),
              );
            },
            onPageError: (page, error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error on page $page: $error')),
              );
            },
            onViewCreated: (PDFViewController viewController) {
              _pdfViewController = viewController;
            },
            onPageChanged: (int? page, int? total) {
              if (page != null) {
                setState(() {
                  _currentPage = page;
                });
              }
            },
          ),
          !_isReady
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink(),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page ${_currentPage + 1} of ${widget.totalPages}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.white),
                        onPressed: _currentPage > 0
                            ? () {
                          _pdfViewController.setPage(_currentPage - 1);
                        }
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Colors.white),
                        onPressed: _currentPage < widget.totalPages - 1
                            ? () {
                          _pdfViewController.setPage(_currentPage + 1);
                        }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionItem(Icons.text_fields, 'Font Size'),
              _buildOptionItem(Icons.brightness_6, 'Brightness'),
              _buildOptionItem(Icons.format_align_left, 'Text Layout'),
              _buildOptionItem(Icons.color_lens, 'Theme'),
              _buildOptionItem(Icons.share, 'Share'),
              _buildOptionItem(Icons.file_download, 'Download'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        // Implement functionality for each option
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label selected')),
        );
      },
    );
  }
}
