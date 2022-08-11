class Product {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });
}

final List<Product> products = [
  Product(
    id: 'p1',
    title: 'Blue Shirt',
    description: 'A blue shirt',
    price: 30.00,
    imageUrl: 'https://th.bing.com/th/id/OIP.5fRJB0DfiQQ0t1IR20g4WQHaKC?pid=ImgDet&rs=1',
  ),
  Product(
    id: 'p1',
    title: 'Blue Shirt',
    description: 'A blue shirt',
    price: 30.00,
    imageUrl: 'https://media.missguided.com/i/missguided/ZX9221280_01?fmt=jpeg&fmt.jpeg.interlaced=true&\$product-page__main--3x\$',
  ),
  Product(
    id: 'p1',
    title: 'Blue Shirt',
    description: 'A blue shirt',
    price: 30.00,
    imageUrl: 'https://th.bing.com/th/id/R.a9ecb57dd4e13656eb01666e9666bf70?rik=KXDZJ7w1W%2b8mxg&pid=ImgRaw&r=0',
  ),
  Product(
    id: 'p1',
    title: 'Blue Shirt',
    description: 'A blue shirt',
    price: 30.00,
    imageUrl: 'https://www.karmakula.co.uk/images/hawaiian/63d0afc173374f37a7eb1cd5e3c77456.jpg',
  ),
  Product(
    id: 'p1',
    title: 'Blue Shirt',
    description: 'A blue shirt',
    price: 30.00,
    imageUrl: 'https://th.bing.com/th/id/OIP.5fRJB0DfiQQ0t1IR20g4WQHaKC?pid=ImgDet&rs=1',
  ),
];
