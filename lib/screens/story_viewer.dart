import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class StoryViewer extends StatefulWidget {
  final List<String> mediaPaths; // Liste des chemins des images/vidéos
  final int startIndex; // Index initial à afficher
  final String username;

  const StoryViewer({
    super.key,
    required this.mediaPaths,
    required this.startIndex,
    required this.username,
  });

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;
  final Duration storyDuration = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(storyDuration, (timer) {
      if (_currentIndex < widget.mediaPaths.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pop(context); // Fermer la story à la fin
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) {
          _timer.cancel(); // pause sur interaction
        },
        onTapUp: (_) {
          _startAutoScroll(); // reprise après interaction
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            if (_currentIndex > 0) {
              _currentIndex--;
              _pageController.animateToPage(
                _currentIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          } else if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            if (_currentIndex < widget.mediaPaths.length - 1) {
              _currentIndex++;
              _pageController.animateToPage(
                _currentIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.mediaPaths.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return Image.file(
                  File(widget.mediaPaths[index]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
            Positioned(
              top: 40,
              left: 16,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/avatar_placeholder.png'), // à remplacer
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.username,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
