// import 'package:flutter/material.dart';

// class SafeMovieImage extends StatelessWidget {
//   final String? path;
//   final double? width;

//   const SafeMovieImage({super.key, required this.path, this.width});

//   @override
//   Widget build(BuildContext context) {
//     if (path == null || path!.isEmpty) {
//       return Container(
//         width: width,
//         color: Colors.grey.shade300,
//         child: const Icon(Icons.image_not_supported),
//       );
//     }

//     final url = "https://image.tmdb.org/t/p/w500$path";

//     return Image.network(
//       url,
//       width: width,
//       fit: BoxFit.cover,

//       errorBuilder: (context, error, stackTrace) {
//         return Container(
//           width: width,
//           color: Colors.grey.shade300,
//           child: const Icon(Icons.broken_image),
//         );
//       },

//       loadingBuilder: (context, child, progress) {
//         if (progress == null) return child;
//         return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:movies_app/data/model/movie_model.dart';

// class SafeMovieImage extends StatelessWidget {
//   final String? path;
//   final double? width;
//   final Movie? movie;
//   const SafeMovieImage({super.key, required this.path, this.width, this.movie});

//   @override
//   Widget build(BuildContext context) {
//     if (path == null || path!.isEmpty) {
//       return Container(
//         width: width,
//         color: Colors.grey.shade300,
//         child: const Icon(Icons.image_not_supported),
//       );
//     }

//     final url = "https://image.tmdb.org/t/p/w500$path";

//     return Container(
//       margin: const EdgeInsets.all(8),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         // color: AppColors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: GridTile(
//         footer: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           color: Colors.black54,
//           alignment: Alignment.bottomCenter,
//           child: Text(
//             movie!.title.toString(),
//             style: TextStyle(
//               // height: 1.3,
//               fontSize: 16,
//               // color: AppColors.white,
//               fontWeight: FontWeight.bold,
//             ),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 2,
//             textAlign: TextAlign.center,
//           ),
//         ),

//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: movie!.posterPath.isNotEmpty
//               ? FadeInImage.assetNetwork(
//                   fit: BoxFit.cover,
//                   placeholder: "assets/images/loading.gif",
//                   image: url,
//                 )
//               : Image.asset("assets/images/error.png"),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class SafeMovieImage extends StatelessWidget {
//   final String? path;
//   final double? width;
//   final double? height;

//   const SafeMovieImage({
//     super.key,
//     required this.path,
//     this.width,
//     this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (path == null || path!.isEmpty) {
//       return Container(
//         width: width,
//         height: height,
//         color: Colors.grey.shade300,
//         child: const Icon(Icons.image_not_supported),
//       );
//     }

//     final url = "https://image.tmdb.org/t/p/w500$path";

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(8),
//       child: FadeInImage.assetNetwork(
//         width: width,
//         height: height,
//         fit: BoxFit.cover,
//         placeholder: "assets/images/loading.gif",
//         image: url,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SafeMovieImage extends StatelessWidget {
  final String? path;
  final double? width;
  final String? title;

  const SafeMovieImage({super.key, required this.path, this.width, this.title});

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return Container(
        width: width,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported),
      );
    }

    final url = "https://image.tmdb.org/t/p/w500$path";

    return Image.network(
      url,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Container(
        width: width,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image),
      ),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: double.infinity,
          child: Image.asset("assets/images/loading.gif", fit: BoxFit.cover),
        );
      },
    );
  }
}
