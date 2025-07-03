import '../models/post.dart';

class PostService {
  final List<Post> _posts = [];

  void addPost(Post post) {
    _posts.insert(0, post); // ajoute en haut de la liste (ordre inverse chrono)
  }

  List<Post> getAllPosts() {
    return _posts;
  }

  void clearPosts() {
    _posts.clear();
  }
}
