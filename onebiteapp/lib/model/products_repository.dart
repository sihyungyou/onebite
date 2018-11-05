import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    List<Product> allProducts = <Product> [
      Product(
        category: Category.accessories,
        id: 0,
        isFeatured: true,
        name: 'Handong Hotel',
        location: 'Pohang',
        description: 'In computer programming, a software framework is an abstraction in which software providing generic functionality can be selectively changed by additional user-written code, thus providing application-specific software. A software framework provides a standard way to build and deploy applications. A software framework is a universal, reusable software environment that provides particular functionality as part of a larger software platform to facilitate development of software applications, products and solutions. Software frameworks may include support programs, compilers, code libraries, tool sets, and application programming interfaces (APIs) that bring together all the different components to enable development of a project or system.',
        call: '054-123-4567',
      ),
      Product(
        category: Category.accessories,
        id: 1,
        isFeatured: true,
        name: 'Silla Hotel',
        location: 'Seoul',
        description: 'The designers of software frameworks aim to facilitate software developments by allowing designers and programmers to devote their time to meeting software requirements rather than dealing with the more standard low-level details of providing a working system, thereby reducing overall development time.[2] For example, a team using a web framework to develop a banking website can focus on writing code particular to banking rather than the mechanics of request handling and state management.',
        call: '054-094-1935',
      ),
      Product(
        category: Category.accessories,
        id: 2,
        isFeatured: false,
        name: 'Palace Hotel',
        location: 'Daejeon',
        description: 'Frameworks often add to the size of programs, a phenomenon termed "code bloat". Due to customer-demand driven applications needs, both competing and complementary frameworks sometimes end up in a product. Further, due to the complexity of their APIs, the intended reduction in overall development time may not be achieved due to the need to spend additional time learning to use the framework; this criticism is clearly valid when a special or new framework is first encountered by development staff.[citation needed] If such a framework is not used in subsequent job taskings, the time invested in learning the framework can cost more than purpose-written code familiar to the projects staff; many programmers keep copies of useful boilerplate for common needs.',
        call: '054-852-1324',
      ),
      Product(
        category: Category.accessories,
        id: 3,
        isFeatured: true,
        name: 'Garden Hotel',
        location: 'Daegu',
        description: 'However, once a framework is learned, future projects can be faster and easier to complete; the concept of a framework is to make a one-size-fits-all solution set, and with familiarity, code production should logically rise. There are no such claims made about the size of the code eventually bundled with the output product, nor its relative efficiency and conciseness. Using any library solution necessarily pulls in extras and unused extraneous assets unless the software is a compiler-object linker making a tight (small, wholly controlled, and specified) executable module.',
        call: '054-123-4567',
      ),
      Product(
        category: Category.accessories,
        id: 4,
        isFeatured: false,
        name: 'Strut Hotel',
        location: 'Gyungju',
        description: 'The issue continues, but a decade-plus of industry experience[citation needed] has shown that the most effective frameworks turn out to be those that evolve from re-factoring the common code of the enterprise, instead of using a generic "one-size-fits-all" framework developed by third parties for general purposes. An example of that would be how the user interface in such an application package as an office suite grows to have common look, feel, and data-sharing attributes and methods, as the once disparate bundled applications grow unified into a suite which is tighter and smaller; the newer/evolved suite can be a product that shares integral utility libraries and user interfaces.',
        call: '054-932-5554',
      ),
      Product(
        category: Category.accessories,
        id: 5,
        isFeatured: false,
        name: 'Varsity Hotel',
        location: 'Korea',
        description: 'This trend in the controversy brings up an important issue about frameworks. Creating a framework that is elegant, versus one that merely solves a problem, is still an art rather than a science. "Software elegance" implies clarity, conciseness, and little waste (extra or extraneous functionality, much of which is user defined). For those frameworks that generate code, for example, "elegance" would imply the creation of code that is clean and comprehensible to a reasonably knowledgeable programmer (and which is therefore readily modifiable), versus one that merely generates correct code.',
        call: '054-089-3847',
      ),
      Product(
        category: Category.accessories,
        id: 6,
        isFeatured: false,
        name: 'Great Hotel',
        location: 'JeonJu',
        description: 'The elegance issue is why relatively few software frameworks have stood the test of time: the best frameworks have been able to evolve gracefully as the underlying technology on which they were built advanced. Even there, having evolved, many such packages will retain legacy capabilities bloating the final software as otherwise replaced methods have been retained in parallel with the newer methods.',
        call: '054-432-9683',
      ),
      Product(
        category: Category.accessories,
        id: 7,
        isFeatured: true,
        name: 'Gatsby Hotel',
        location: 'Gwangju',
        description: 'description test gwangju',
        call: '054-754-1234',
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    }
    else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
