import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/postModel.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class PostDetails extends StatefulWidget {
  Post? post;

  PostDetails(this.post, {Key? key}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Post? _post;

  List<Widget> _getImagesList() {
    List<String> imagesListUrl = _post!.images;
    return imagesListUrl.map((url) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url), fit: BoxFit.fitWidth)),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anúncio")),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              SizedBox(
                  height: 250,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: CarouselSlider(
                        items: _getImagesList(),
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.85,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ))),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${_post?.price}",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text("${_post?.title}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Text("Descrição",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("${_post?.description}",
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GestureDetector(
              child: Container(
                child: const Text(
                  "Chat",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(30)),
              ),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
