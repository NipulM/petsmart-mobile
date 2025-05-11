// ignore_for_file: prefer_const_constructors
import 'package:cb011999/screens/about/widgets/blog_container.dart';
import 'package:cb011999/screens/about/widgets/hero_container.dart';
import 'package:cb011999/screens/about/widgets/image_container.dart';
import 'package:cb011999/screens/about/widgets/our_mission_cotainer.dart';
import 'package:cb011999/screens/about/widgets/why_choose_us_conainer.dart';
import 'package:flutter/material.dart';
import 'package:cb011999/services/blog_service.dart';
import 'package:cb011999/models/blog.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final BlogService _blogService = BlogService();
  List<Blog> _blogs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    try {
      final blogs = await _blogService.getAllBlogs();
      print(blogs);
      setState(() {
        _blogs = blogs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
      print('Error fetching blogs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: Text("Welcome to PetSmart!",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Roboto Medium',
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          HeroContainer(),
          OurMissionConatiner(),
          WhyChooseUsConainer(),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Looking for tips on pet grooming, training, or sustainable living? Check out our blog, where we share weekly articles and videos to help you care for your pets with love and knowledge.",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto Regular',
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Thank you for being part of the PetSmart community—where happy pets meet a healthier planet! ❤️",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto Regular',
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Care & Comfort Corner",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Roboto Bold',
                  )),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: _blogs
                      .map((blog) => BlogContainer(
                            title: blog.title,
                            description: blog.content,
                            imageUrl: blog.imageUrl,
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
