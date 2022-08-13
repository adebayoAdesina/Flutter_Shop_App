import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const id = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  }),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            imageUrl: _imageUrlController.text,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Image Url'),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
