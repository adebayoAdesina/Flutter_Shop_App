import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/appdata.dart';
import 'package:shop_app/providers/product_model.dart';

class EditProductScreen extends StatefulWidget {
  static const id = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  FocusNode _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formGlobal = GlobalKey<FormState>();
  Product editProduct = Product();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    // _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
    _imageUrlFocusNode = FocusNode();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() {
    final isValid = _formGlobal.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formGlobal.currentState!.save();
    print(isValid);
  }

  @override
  Widget build(BuildContext context) {
    final productId = context.watch<AppData>().products.length;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'), actions: [
        IconButton(
          onPressed: () => saveForm(),
          icon: const Icon(Icons.save),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formGlobal,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Title'),
                  errorStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  return value!.isEmpty ? 'Please input a Title.' : null;
                },
                onChanged: (value) {
                  editProduct = Product(
                    id: productId,
                    title: value,
                    price: editProduct.price,
                    description: editProduct.description,
                    imageUrl: editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Price'),
                  errorStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  return value!.isEmpty ? 'Please input a Price.' : null;
                },
                onChanged: (value) {
                  editProduct = Product(
                    id: productId,
                    title: editProduct.title,
                    price: double.parse(value),
                    description: editProduct.description,
                    imageUrl: editProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Description'),
                  errorStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) {
                  return value!.isEmpty ? 'Please input a Description.' : null;
                },
                onChanged: (value) {
                  editProduct = Product(
                    id: productId,
                    title: editProduct.title,
                    price: editProduct.price,
                    description: value,
                    imageUrl: editProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      decoration: InputDecoration(
                        label: const Text('Image Url'),
                        errorStyle: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => saveForm(),
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Please input a Image URL.'
                            : null;
                      },
                      onChanged: (value) {
                        editProduct = Product(
                          id: productId,
                          title: editProduct.title,
                          price: editProduct.price,
                          description: editProduct.description,
                          imageUrl: value,
                        );
                      },
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
