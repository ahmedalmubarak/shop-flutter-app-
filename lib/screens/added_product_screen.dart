import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

// Adding and Edit User input
class AddingEditingScreen extends StatefulWidget {
  static const String ROUT_NAME = '/edit-product';

  @override
  _AddingEditingScreenState createState() => _AddingEditingScreenState();
}

class _AddingEditingScreenState extends State<AddingEditingScreen> {
  // to avoid memory leg we need to set FocusNod to dispose() Func.
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  var _isInit = true;
  final _imageUrlFocusNode =
      FocusNode(); // To generate image auto without tab done.

  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isLoading = false;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context).findById(productId);
        _initValue = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': ''
          // 'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    // if TextField has no focus => Update widget.
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    // trigger Validation Fields.
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      if (_editedProduct.id != null) {
        await Provider.of<Products>(context, listen: false)
            .updateItem(_editedProduct.id, _editedProduct);
        setState(() {
          _isLoading = true;
        });
        Navigator.of(context).pop();
      } else {
        try {
          await Provider.of<Products>(context, listen: false)
              .addItem(_editedProduct);
        } on Exception catch (e) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An error occurred !'),
              content: Text('Something went wrong !'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        }
      }
      //Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Theme.of(context).canvasColor,
            ),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Title Field
                    TextFormField(
                      initialValue: _initValue['title'],
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Provide a value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                    ),

                    // Price Field
                    TextFormField(
                      initialValue: _initValue['price'],
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value),
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Sorry minimum price is \$1';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                    ),

                    // Description Field
                    TextFormField(
                      initialValue: _initValue['description'],
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 character !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      onFieldSubmitted: (_) {
                        //FocusScope.of(context).requestFocus(_focusNode);
                      },
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16.0, top: 16.0),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text(
                                  'Enter Your URL',
                                  textAlign: TextAlign.center,
                                )
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          flex: 2,
                          // Image URL Field
                          child: TextFormField(
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value,
                                  isFavorite: _editedProduct.isFavorite);
                            },
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
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
