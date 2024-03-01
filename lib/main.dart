/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//  1) Print the count total reviews of every asin number

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> fetchJsonData(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
    
//       jsonData.forEach((product) {
//         String asin = product['asin']; 
//         int reviewsCount = product['reviews']?.length ?? 0; 
//         print('ASIN: $asin has $reviewsCount reviews');
//       });
//     } else {
    
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
    
//     print('Error: $e');
//   }
// }

// void main() {
//   String jsonUrl = 'https://amz-reviews-rating-json.vercel.app/reviews'; 
//   fetchJsonData(jsonUrl);
// }


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  2) Print the all reviews who has rating bleow 2

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// import 'package:http/http.dart' as http;
// import 'dart:convert';


// Future<void> fetchJsonDataAndPrintLowRatingReviews(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
     

      
//       for (var user in jsonData) { 
//         String userId = user['asin']; 
//         List<dynamic> books = user['reviews']; 
//         for (var book in books) {
//           int rating = book['rating']; 
//           if (rating < 2) {
//             print('Asin No.: $userId, Review ID: ${book['id']}, Rating: $rating');
            
//           }
//         }
//       }
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }

// void main() {
//   String jsonUrl = 'https://amz-reviews-rating-json.vercel.app/reviews';
//   fetchJsonDataAndPrintLowRatingReviews(jsonUrl);
// }




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  3)  Add 2 extra reviews every asin who has rating 4 and above (refer rating from summary)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// import 'package:http/http.dart' as http;
// import 'dart:convert';


// Future<void> fetchJsonDataAndPrintLowRatingReviews(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
     
//        jsonData.forEach((user) {
//     if (user['summary']['rating'] >= 4) {
   
//       user['reviews'].add({"id": "new 1", "title": "New Fav", "link": "online", "rating": 4});
//       user['reviews'].add({"id": "new 2", "title": "New Fav", "link": "online", "rating": 4});
//     }
//     print("Asin No.: ${user['asin']}, Rating: ${user['summary']['rating']}, Reviews IDs: ${user['reviews'].map((book) => book['id']).join(', ')}");
//   });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
// void main() {
//   String jsonUrl = 'https://amz-reviews-rating-json.vercel.app/reviews';
//   fetchJsonDataAndPrintLowRatingReviews(jsonUrl);
// }


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 4) Remove the reviews which has rating below 3

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// import 'package:http/http.dart' as http;
// import 'dart:convert';


// Future<void> fetchJsonDataAndPrintLowRatingReviews(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);


//           jsonData.forEach((product) {
//         String asin = product['asin']; 
//         int reviewsCount = product['reviews']?.length ?? 0; 
//         print('ASIN: $asin has $reviewsCount reviews');
//       });
     
//       jsonData.forEach((user) {


  
//     var filteredBooks = (user['reviews'] as List<dynamic>).where((book) => book['rating'] >= 3).toList();
//     user['reviews'] = filteredBooks;


//     print('Asin No.: ${user['asin']}, Total Reiews: ${user['reviews'].length}  after removal count');
//   });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
// void main() {
//   String jsonUrl = 'https://amz-reviews-rating-json.vercel.app/reviews';
//   fetchJsonDataAndPrintLowRatingReviews(jsonUrl);
// }


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 5) Print all reviews with latest date on top

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchJsonDataAndPrintLowRatingReviews(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      for (var user in jsonData) {
        if (user['reviews'] != null) {
         
          user['reviews'].sort((a, b) {
            var dateA = DateTime.parse(a['date']['utc']);
            var dateB = DateTime.parse(b['date']['utc']);
            return dateB.compareTo(dateA);
          });
          for (var review in user['reviews']) {
            var bookId = review['id'];
            var bookDate = review['date']['utc'];
        
            var userId = user['asin']; 
            print('UserId: $userId, Reviews ID: $bookId, Date: $bookDate');
          }
        }
      }
    } else {
      throw Exception('Failed to load ');
    }
  } catch (e) {
    print('Error: $e');
  }


}

void main() {
  String jsonUrl = 'https://amz-reviews-rating-json.vercel.app/reviews';
  fetchJsonDataAndPrintLowRatingReviews(jsonUrl);
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 6)  Remove the asin form the list which has no reviews

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> fetchJsonDataAndPrintLowRatingReviews(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//   jsonData.forEach((user) {
//     int bookCount = (user['reviews'] as List).length;
//     print('Asin No. ${user['asin']} has $bookCount Review IDs');
    
//     if (bookCount == 0) {
//       user.remove('asin');
//       user.remove('product');
//       user.remove('summary');
//       user.remove('reviews');
//     }
//   });

//   jsonData.forEach((user) {
//     if(user.containsKey('asin')) { 
//       int bookCount = (user['reviews'] as List).length;
//       print(' Asin No. ${user['asin']} has $bookCount Reviews id after removal.');
//     } else {
      
//       print('A Userid was removed due to having 0 reviews id.');
//     }
//   });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
// void main() {
//   String jsonUrl = 'https://amz-reviews-rating-json.vercel.app/reviews';
//   fetchJsonDataAndPrintLowRatingReviews(jsonUrl);
// }












