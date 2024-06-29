abstract class Helper {

 static String? generateDownloadLink(String url) {
   
    final id = _extractGoogleDriveFileId(url);
  
    String baseUrl = "https://drive.google.com/uc?export=view&id=";
    if (id != "") {
      return baseUrl + id;
    }
    return url; // to fit when user doing update not add 
  }
static String _extractGoogleDriveFileId(String url) {
    List<String> urlParts = url.split('/');

    // Check if the URL has the expected format.
    if (urlParts.length == 7 && urlParts[4] == 'd') {
      return urlParts[5];
    } else {
      return ''; // Or throw an exception if you prefer
    }
  }

}