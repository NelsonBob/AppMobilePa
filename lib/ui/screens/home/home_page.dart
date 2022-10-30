import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/models/ProgrammingLanguageAssociation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/ui/screens/addPost/add_post_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_application_1/ui/helpers/helpers.dart';
import 'package:flutter_application_1/ui/screens/comments/comments_post_page.dart';
import 'package:flutter_application_1/ui/screens/notifications/notifications_page.dart';
import 'package:flutter_application_1/domain/models/response/response_post.dart';
import 'package:flutter_application_1/domain/services/post_services.dart';
import 'package:flutter_application_1/data/env/env.dart';
import 'package:flutter_application_1/ui/themes/colors_frave.dart';
import 'package:flutter_application_1/ui/widgets/widgets.dart';
import 'package:flutter_application_1/domain/blocs/post/post_bloc.dart';
import '../home/text_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingSavePost || state is LoadingPost) {
          modalLoadingShort(context);
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const TextCustom(
              text: 'social media',
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: ColorsFrave.secundary,
              isTitle: true,
            ),
            elevation: 0,
            actions: [
              IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        routeSlide(page: const AddPostPage()), (_) => false);
                  },
                  icon: SvgPicture.asset('assets/svg/add_rounded.svg',
                      height: 32)),
              IconButton(
                  splashRadius: 20,
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      routeSlide(page: const NotificationsPage()),
                      (_) => false),
                  icon: SvgPicture.asset('assets/svg/notification-icon.svg',
                      height: 26)),
            ],
          ),
          body: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 5.0),
                FutureBuilder<List<Post>>(
                  future: postService.getAllPostHome(),
                  builder: (_, snapshot) {
                    if (snapshot.data != null && snapshot.data!.isEmpty) {
                      return _ListWithoutPosts();
                    }

                    return !snapshot.hasData
                        ? Column(
                            children: const [
                              ShimmerFrave(),
                              SizedBox(height: 10.0),
                              ShimmerFrave(),
                              SizedBox(height: 10.0),
                              ShimmerFrave(),
                            ],
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, i) =>
                                _ListViewPosts(posts: snapshot.data![i]),
                          );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavigationFrave(index: 1)),
    );
  }
}

class _ListViewPosts extends StatelessWidget {
  final Post posts;

  const _ListViewPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postBloc = BlocProvider.of<PostBloc>(context);
    final List<String> listImages = posts.images.split(',');
    final time = timeago.format(posts.createdAt, locale: 'us');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        height: 500,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.grey[100]),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    Environment.baseUrl + posts.avatar),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextCustom(
                                      text: posts.username,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  TextCustom(
                                    text: time,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Flexible(
                            child: Text(' ${posts.title}',
                                style: const TextStyle(fontSize: 20)),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Flexible(
                            child: Text(' ${posts.description}'),
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: size.width,
                        height: 240,
                        child: Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: FutureBuilder(
                                  future: postService.ProgramationService(
                                      "python", posts.postUid, posts.personUid),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> text) {
                                    return Text(
                                      text.data!
                                          .replaceAll('\\n', '\n')
                                          .replaceAll('\r', "")
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Positioned(
                      bottom: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        height: 45,
                        width: size.width * .9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => postBloc.add(
                                                OnLikeOrUnLikePost(
                                                    posts.postUid,
                                                    posts.personUid)),
                                            child: posts.isLike == 1
                                                ? const Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.red)
                                                : const Icon(
                                                    Icons
                                                        .favorite_outline_rounded,
                                                    color: Colors.black),
                                          ),
                                          const SizedBox(width: 8.0),
                                          InkWell(
                                              onTap: () {},
                                              child: TextCustom(
                                                  text: posts.countLikes
                                                      .toString(),
                                                  fontSize: 16,
                                                  color: Colors.black))
                                        ],
                                      ),
                                      const SizedBox(width: 20.0),
                                      TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            routeFade(
                                                page: CommentsPostPage(
                                                    uidPost: posts.postUid))),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/message-icon.svg',
                                                color: Colors.black),
                                            const SizedBox(width: 5.0),
                                            TextCustom(
                                                text: posts.countComment
                                                    .toString(),
                                                fontSize: 16,
                                                color: Colors.black)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListWithoutPosts extends StatelessWidget {
  final List<String> svgPosts = [
    'assets/svg/without-posts-home.svg',
    'assets/svg/without-posts-home.svg',
    'assets/svg/mobile-new-posts.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          padding: const EdgeInsets.all(10.0),
          height: 350,
          width: size.width,
          // color: Colors.amber,
          child: SvgPicture.asset(svgPosts[index], height: 15),
        ),
      ),
    );
  }
}
