import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImageList extends StatelessWidget {
  final List<File> imageList;
  final Function() pickCamera;
  final Function() pickGallery;
  final Function(File image) removeImage;

  const ImageList({
    super.key,
    required this.imageList,
    required this.pickCamera,
    required this.pickGallery,
    required this.removeImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.circular(12),
              ),
              width: 70,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).disabledColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 48,
                              height: 48,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  pickCamera();
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: const Icon(Ionicons.camera_outline),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).disabledColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 48,
                              height: 48,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  pickGallery();
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: const Icon(Ionicons.images_outline),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: const Icon(Ionicons.camera_outline),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.file(
                        imageList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        removeImage(imageList[index]);
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: const Icon(
                        Ionicons.close,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 4,
              );
            },
            itemCount: imageList.length,
          ),
        ],
      ),
    );
  }
}
