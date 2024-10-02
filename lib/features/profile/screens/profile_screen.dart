import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/create_post/screens/create_post_screen.dart';
import 'package:neighborgood/features/profile/widgets/profile_buttons.dart';
import 'package:neighborgood/features/profile/widgets/social_count.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  List posts = [
    'assets/posts/post1.jpeg',
    'assets/posts/post2.jpeg',
    'assets/posts/post3.jpeg',
    'assets/posts/post4.jpeg',
    'assets/posts/post5.jpeg',
    'assets/posts/post6.jpeg',
    'assets/posts/post7.jpeg',
    'assets/posts/post8.jpeg',
    'assets/posts/post9.jpeg',
    'assets/posts/post10.jpeg',
    'assets/posts/post11.jpeg',
    'assets/posts/post12.jpeg',
  ];
  List saved = [
    'assets/posts/post1.jpeg',
    'assets/posts/post11.jpeg',
    'assets/posts/post9.jpeg',
    'assets/posts/post6.jpeg',
    'assets/posts/post9.jpeg',
    'assets/posts/post12.jpeg',
  ];

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  width: 80,
                  height: 35,
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/icons/more_vert_large.svg',
              height: 30,
              width: 24,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/navigation/profile.jpg',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Wilson Saris',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Intrested in Running',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SocialCount(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileButton(
                  text: 'Edit Profile',
                  icon: 'assets/icons/profile/edit.svg',
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                ProfileButton(
                  text: 'Create Postcard',
                  icon: 'assets/icons/profile/create.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePostScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TabBar(
              indicatorColor: const Color(0xFFFF6D00),
              tabAlignment: TabAlignment.center,
              dividerHeight: 0.1,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey,
              controller: tabController,
              tabs: [
                Tab(
                  child: SvgPicture.asset(
                    'assets/icons/profile/post.svg',
                    height: 25,
                  ),
                ),
                Tab(
                  child: SvgPicture.asset(
                    'assets/icons/save.svg',
                    height: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  GridView.builder(
                    itemCount: posts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(posts[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  GridView.builder(
                    itemCount: saved.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(saved[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
