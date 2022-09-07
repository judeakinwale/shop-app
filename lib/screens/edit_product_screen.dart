// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  // const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  var _isInit = true;

  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _initValues = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  void _updateImageUrl() {
    final imageUrl = _imageUrlController.text;
    if (_imageUrlFocusNode.hasFocus) {
      if ((!imageUrl.startsWith('http') && !imageUrl.startsWith('https')) ||
          (!imageUrl.endsWith('.png') &&
              !imageUrl.endsWith('.jpg') &&
              !imageUrl.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final formState = _form.currentState;
    final productData = Provider.of<Products>(context, listen: false);

    if (formState == null || !formState.validate()) return;
    // // code from tutorial. has issues with null safety
    // final isValid = formState.validate();
    // if (!isValid) return;
    formState.save();

    if (_editedProduct.id != "") {
      productData.updateProduct(_editedProduct.id, _editedProduct);
    } else {
      productData.addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final productData = Provider.of<Products>(context, listen: false);
    if (_isInit) {
      // final productId = ModalRoute.of(context)?.settings.arguments as String;
      // if (productId != null) {
      //   _editedProduct =
      //       Provider.of<Products>(context, listen: false).findById(productId);
      //   _initValues = {
      //     'title': _editedProduct.title,
      //     'description': _editedProduct.description,
      //     'price': _editedProduct.price.toString(),
      //     // 'imageUrl': _editedProduct.imageUrl,
      //     'imageUrl': '',
      //   };
      //   _imageUrlController.text = _editedProduct.imageUrl;

      // final productId = ModalRoute.of(context)?.settings.arguments as String;
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        _editedProduct = productData.findById(productId as String);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a title.';
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: value as String,
                  price: _editedProduct.price,
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a price';
                final price = double.tryParse(value);
                if (price == null) return 'Please enter a valid number.';
                if (price < 1) {
                  return 'Please enter a number greater than Zero.';
                }
                // if (double.tryParse(value) == null)
                //   return 'Please enter a valid number';
                // if (double.parse(value) <= 0)
                //   return 'Please enter a number greater than Zero';
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: value as double,
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(labelText: 'Description'),
              focusNode: _descriptionFocusNode,
              maxLines: 3,
              // onFieldSubmitted: (value) => null,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a description.';
                if (value.length < 10) {
                  return 'Should be at least 10 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: _editedProduct.price,
                  description: value as String,
                  imageUrl: _editedProduct.imageUrl,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 8,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: _imageUrlController.text.isEmpty
                      ? Center(child: Text('Enter an Url'))
                      : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: _initValues['imageUrl'],
                    decoration: InputDecoration(labelText: 'Image Url'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    focusNode: _imageUrlFocusNode,
                    controller: _imageUrlController,
                    onEditingComplete: () => setState(() {}),
                    // onFieldSubmitted: (value) => null,
                    validator: (value) {
                      if (value!.isEmpty) 'Please enter an image url.';
                      if (!value.startsWith('http') &&
                          value.startsWith('http')) {
                        return 'Please enter a valid url.';
                      }
                      if (!value.endsWith('.png') &&
                          !value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg')) {
                        return 'Please enter a valid email url';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        imageUrl: value as String,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
