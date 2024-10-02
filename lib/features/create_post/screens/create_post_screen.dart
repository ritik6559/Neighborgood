import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/common/provider/storage_reposiotry.dart';
import 'package:neighborgood/common/utils/pick_image.dart';
import 'package:neighborgood/common/utils/show_snackbar.dart';
import 'package:neighborgood/common/widgets/custom_button.dart';
import 'package:neighborgood/common/widgets/custom_text_field.dart';
import 'package:neighborgood/features/auth/repository/auth_repository.dart';
import 'package:neighborgood/features/posts/repository/post_repository.dart';
import 'package:neighborgood/models/post.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? bannerFile;
  final PostRepository postRepository = PostRepository();
  final StorageRepository storageRepository = StorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  );
  bool isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void selecteBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void sharePosts(BuildContext context, String uid) async {
    final user = await context.read<AuthRepository>().getUserDetails();
    String postId = const Uuid().v1();
    if (bannerFile != null &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      final bannerUrl = await storageRepository.storeFile(
        path: 'posts/${user!.uid}',
        id: postId,
        file: bannerFile,
        context: context,
      );
      context.read<PostRepository>().addPost(
            Post(
              id: postId,
              uid: user.uid,
              authorName: user.name,
              authorImage: user.profilePic,
              authorDescription: '',
              description: _descriptionController.text.trim(),
              image: bannerUrl!,
              createdAt: DateTime.now(),
              likedBy: [],
              savedBy: [],
              comments: [],
            ),
            context,
          );
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        'Post created successfully',
        'Success',
      );
    } else if (bannerFile == null) {
      showSnackBar(
        context,
        'Please select an image',
        'Error',
      );
    } else if (_titleController.text.isEmpty) {
      showSnackBar(
        context,
        'Please enter a title',
        'Error',
      );
    } else if (_descriptionController.text.isEmpty) {
      showSnackBar(
        context,
        'Please enter a description',
        'Error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthRepository>().user.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF6D00),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: selecteBannerImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      color: Colors.grey,
                      dashPattern: const [10, 8],
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade100,
                        ),
                        child: bannerFile == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/upload_file.svg',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Upload a  Image here',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'JPG or PNG file size no more than 10MB',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              )
                            : Image.file(
                                bannerFile!,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Event Title*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    controller: _titleController,
                    hintText: 'Post Title',
                    iconPath: '',
                    isPassword: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Description*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: 'Write your description...',
                    iconPath: '',
                    isPassword: false,
                    maxLines: 7,
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Create Post',
                    onTap: () => sharePosts(context, uid),
                    color: const Color(0xFFFF6D00),
                  ),
                ],
              ),
      ),
    );
  }
}
