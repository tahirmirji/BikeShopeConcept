import 'dart:ui';
import 'package:flutter/material.dart';

class Bike {
  final String url;
  final String title;
  final String price;

  const Bike({this.url, this.title, this.price});
}

const movies = [
  const Bike(
      url: 'https://bs-ather-jobs-assests.s3-ap-south-1.amazonaws.com/bpa-assests/mini-450x-referral-banner.png', title: 'Ather', price: '1,50,000'),
  const Bike(
      url:
          'https://media.zigcdn.com/media/content/2019/Nov/chetak_thumb.jpg',
      title: 'Bajaj Chetak Electric', price: '1,20,000'),
  const Bike(
      url:
          'https://images.carandbike.com/bike-images/large/revolt/rv400/revolt-rv400.jpg?v=9',
      title: 'Revolt RV400 Electric', price: '1,35,000'),
  const Bike(
    url:
        'https://imgd.aeplcdn.com/1200x900/bw/models/tvs-iqube-standard20200125210025.jpg',
    title: 'TVS iQube Electric', price: '80,000'
  ),
  const Bike(
    url: 'https://bd.gaadicdn.com/processedimages/hero-electric/optima-la/source/m_optima-la_11566279915.jpg',
    title: 'Hero Electric Optima', price: '1,10,000'
  ),
  const Bike(
    url: 'https://www.motoroids.com/wp-content/uploads/2021/01/Joy-e-bikes-hurricane.jpg',
    title: 'Joy e-bike Monster', price: '1,60,000'
  ),
  const Bike(
    url: 'https://gomechanic.in/blog/wp-content/uploads/2020/02/n-16_6730b5ee-1000x800.jpg',
    title: 'EPluto 7G Electric', price: '1,85,000'
  ),
];

class BikeConceptPage extends StatefulWidget {
  @override
  _BikeConceptPageState createState() => _BikeConceptPageState();
}

class _BikeConceptPageState extends State<BikeConceptPage> {
  final pageController = PageController(viewportFraction: 0.7);
  final ValueNotifier<double> _pageNotifier = ValueNotifier(0.0);

  void _listener() {
    _pageNotifier.value = pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_listener);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: Icon(Icons.motorcycle_outlined),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ValueListenableBuilder<double>(
                valueListenable: _pageNotifier,
                builder: (context, value, child) {
                  return Stack(
                    children: movies.reversed
                        .toList()
                        .asMap()
                        .entries
                        .map(
                          (entry) => Positioned.fill(
                            child: ClipRect(
                              clipper: MyClipper(
                                percentage: value,
                                title: entry.value.title,
                                index: entry.key,
                              ),
                              child: Image.network(
                                entry.value.url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height / 3,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white60,
                  Colors.white24,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
            ),
          ),
          PageView.builder(
              itemCount: movies.length,
              controller: pageController,
              itemBuilder: (context, index) {
                final lerp =
                    lerpDouble(0, 1, (index - _pageNotifier.value).abs());

                double opacity =
                    lerpDouble(0.0, 0.5, (index - _pageNotifier.value).abs());
                if (opacity > 1.0) opacity = 1.0;
                if (opacity < 0.0) opacity = 0.0;
                return Transform.translate(
                  offset: Offset(0.0, lerp * 50),
                  child: Opacity(
                    opacity: (1 - opacity),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        color: Colors.white,
                        borderOnForeground: true,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          height: size.height / 1.5,
                          width: size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 23.0, left: 23.0, right: 23.0),
                                  child: ClipRRect(
                                    borderRadius: borderRadius,
                                    child: Image.network(
                                      movies[index].url,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        movies[index].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.orange,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        movies[index].price,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          Positioned(
            left: size.width / 4,
            bottom: 20,
            width: size.width / 2,
            child: RaisedButton(
                color: Colors.black,
                child: Text(
                  'BOOK NOW',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => null),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(5, 5),
                      blurRadius: 20,
                      spreadRadius: 5),
                ],
              ),
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final double percentage;
  final String title;
  final int index;

  MyClipper({
    this.percentage = 0.0,
    this.title,
    this.index,
  });

  @override
  Rect getClip(Size size) {
    int currentIndex = movies.length - 1 - index;
    final realPercent = (currentIndex - percentage).abs();
    if (currentIndex == percentage.truncate()) {
      return Rect.fromLTWH(
          0.0, 0.0, size.width * (1 - realPercent), size.height);
    }
    if (percentage.truncate() > currentIndex) {
      return Rect.fromLTWH(0.0, 0.0, 0.0, size.height);
    }
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
