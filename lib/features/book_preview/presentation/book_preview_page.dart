import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/core/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:fruit_e_commerce/core/extensions/media_query_extension.dart';

class BookPreveiwPage extends StatefulWidget {
  final String bookPdfUrl;
  final String bookName;

  const BookPreveiwPage({
    Key? key,
    required this.bookPdfUrl,
    required this.bookName,
  }) : super(key: key);

  @override
  State<BookPreveiwPage> createState() => _BookPreveiwPageState();
}

class _BookPreveiwPageState extends State<BookPreveiwPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  final TextEditingController _searchController = TextEditingController();

  int currentPage = 1;
  bool isDarkMode = false;
  bool isSearching = false;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? _pdfSearchAppBar() : _pdfAppBar(),
      body: widget.bookPdfUrl.isEmpty
          ? const Center(
              child: Text(
              "No pdf found",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 30),
            ))
          : Stack(alignment: Alignment.bottomCenter, children: [
              Column(
                children: [
                  Expanded(
                    child: ColorFiltered(
                      colorFilter: isDarkMode ? const ColorFilter.mode(Colors.white, BlendMode.difference) : const ColorFilter.mode(Colors.white, BlendMode.colorBurn),
                      child: SfPdfViewer.network(
                        onDocumentLoadFailed: (details) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("something went wrong")));
                        },
                        controller: _pdfViewerController,
                        otherSearchTextHighlightColor: AppColors.deleteButtonColor.withOpacity(0.4),
                        canShowPaginationDialog: true,
                        canShowPageLoadingIndicator: true,
                        canShowScrollStatus: true,
                        currentSearchTextHighlightColor: AppColors.primaryColor.withOpacity(0.4),
                        onPageChanged: (details) {
                          setState(() {
                            currentPage = details.newPageNumber;
                          });
                        },
                        widget.bookPdfUrl,
                        key: _pdfViewerKey,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
    );
  }

  AppBar _pdfAppBar() => AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: context.getDefaultSize() * 2.5),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // IconButton(onPressed: () {}, icon: Text("Aa", style: GoogleFonts.inter().copyWith(color: Colors.white, fontSize: context.getDefaultSize() * 3))),
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: context.getDefaultSize() * 3,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              icon: Icon(
                Icons.color_lens,
                color: Colors.white,
                size: context.getDefaultSize() * 3,
              )),
        ],
        title: Text(
          widget.bookName,
          style: GoogleFonts.inter().copyWith(color: Colors.white, fontSize: context.getDefaultSize() * 1.7),
        ),
      );

  AppBar _pdfSearchAppBar() {
    return AppBar(
        leading: IconButton(
            icon: Icon(Icons.close, color: AppColors.primaryColor, size: context.getDefaultSize() * 3),
            onPressed: () {
              setState(() {
                _searchResult.clear();
                isSearching = false;
                _searchController.clear();
              });
            }),
        backgroundColor: Colors.white,
        elevation: 0.6,
        shadowColor: AppColors.primaryColor.withOpacity(0.5),
        actions: [
          IconButton(
            onPressed: () {
              _searchResult = _pdfViewerController.searchText(_searchController.text);
              FocusManager.instance.primaryFocus?.unfocus();
            },
            icon: Icon(
              Icons.search,
              size: context.getDefaultSize() * 3,
            ),
          ),
          IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor, size: context.getDefaultSize() * 3),
              onPressed: () {
                setState(() {
                  _searchResult.previousInstance();
                });
              }),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor, size: context.getDefaultSize() * 3),
              onPressed: () {
                setState(() {
                  _searchResult.nextInstance();
                });
              }),
        ],
        title: TextField(
            controller: _searchController,
            autofocus: true,
            enableSuggestions: true,
            onSubmitted: (value) {
              setState(() {
                _searchResult = _pdfViewerController.searchText(value);
              });
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.grey,
              hintText: "Search",
              hintStyle: GoogleFonts.outfit().copyWith(fontWeight: FontWeight.w300, fontSize: context.getHight(divide: 0.04), color: Colors.grey),
              border: InputBorder.none,
            )));
  }
}
