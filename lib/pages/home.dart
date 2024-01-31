import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/artical_model.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/pages/all_news.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/pages/category_news.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticalModel> articles = [];
  bool _loading = true, loading2=true;

  int activeIndex = 0;
  @override
  
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

   getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }
  getSlider() async {
    Sliders slider= Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  setState(() {
    loading2=false;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("News"),
          Text(
            "App",
            style: TextStyle(
                color: Colors.amberAccent, fontWeight: FontWeight.bold),
          )
        ]),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 70,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTitle(
                        image: categories[index].image,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Breaking NEWS!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Breaking")));
                            },
                      child:Text(
                        "View All",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                  ),],
                  )),
              loading2? Center(child: CircularProgressIndicator()):CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, realIndex) {
                    String? res = sliders[index].urlToImage;
                    String? res1 = sliders[index].title;
                    return buildImage(res!, index, res1!);
                  },
                  options: CarouselOptions(
                    height: 250,
                    //viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                      
                    },
                  )),
              SizedBox(
                height: 20.0,
              ),
              Center(child: buildIndicator()),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending NEWS!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      GestureDetector(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Trending")));
                            },
                      child:Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                  )],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Material(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            "images/business.jpg",
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                "Turn the paper All",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Text(
                                "then you can view all",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              
               Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              url:  articles[index].url!,
                                desc: articles[index].description!,
                                imageUrl: articles[index].urlToImage!,
                                title: articles[index].title!);
                          }),
          )],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,imageUrl:image,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 10.0),
            margin: EdgeInsets.only(top: 130.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ]),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blueAccent),
      );
}

class CategoryTitle extends StatelessWidget {
  final image, categoryName;
  CategoryTitle({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName)));
      },
    child:Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            image,
            width: 120,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 120,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black38,
          ),
          child: Center(
              child: Text(
            categoryName,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          )),
        )
      ]),
    ));
  }
}
class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({required this.desc, required this.imageUrl, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl:url )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                      imageUrl: imageUrl,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover, 
                          ))),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0),
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
