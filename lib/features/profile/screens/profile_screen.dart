import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/auth/repository/auth_repository.dart';
import 'package:neighborgood/features/create_post/screens/create_post_screen.dart';
import 'package:neighborgood/features/posts/repository/post_repository.dart';
import 'package:neighborgood/features/profile/widgets/profile_buttons.dart';
import 'package:neighborgood/features/profile/widgets/social_count.dart';
import 'package:provider/provider.dart';

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
      body: StreamBuilder(
          stream: context
              .read<AuthRepository>()
              .getUserData(context.read<AuthRepository>().user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF6D00),
                ),
              );
            }
            final user = snapshot.data;
            return Padding(
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
                    Text(
                      user!.name,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SocialCount(user: user),
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
                          StreamBuilder(
                              stream: context
                                  .read<PostRepository>()
                                  .getUserPostsStream(
                                      context.read<AuthRepository>().user.uid,
                                      context),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                return GridView.builder(
                                  itemCount: snapshot.data?.length ?? 0,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1 / 1,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                  ),
                                  itemBuilder: (context, index) {
                                    final post = snapshot.data?[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(post!.image),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                          StreamBuilder(
                            stream: context
                                .read<PostRepository>()
                                .getSavedPostsStream(
                                    context.read<AuthRepository>().user.uid,
                                    context),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFF6D00),
                                  ),
                                );
                              }
                              return GridView.builder(
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            snapshot.data?[index].image ?? ''),
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1 / 1,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
