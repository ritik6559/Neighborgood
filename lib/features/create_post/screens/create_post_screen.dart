import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/common/widgets/custom_text_field.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DottedBorder(
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
                child: Column(
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
          ],
        ),
      ),
    );
  }
}
