import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductImagesCarousel extends StatefulWidget {
  final List<String> images;
  final Function(int) onPageChanged;

  const ProductImagesCarousel({
    super.key,
    required this.images,
    required this.onPageChanged,
  });

  @override
  State<ProductImagesCarousel> createState() => _ProductImagesCarouselState();
}

class _ProductImagesCarouselState extends State<ProductImagesCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPageChanged(index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: widget.images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.error),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: widget.images.length,
          effect: const WormEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: Color(0xFF6C63FF),
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
