// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bookmark/model/book.dart';
import 'package:bookmark/model/book_model.dart';
import 'package:bookmark/ui/animation/fade_animation.dart';
import 'package:bookmark/ui/book_details_page/new_details.dart';
import 'package:bookmark/ui/first_time_screens/select_language.dart';
import 'package:bookmark/ui/main/order_page.dart';
import 'package:bookmark/ui/payment/payment_success.dart';
import 'package:bookmark/ui/search/searchPage.dart';
import 'package:bookmark/ui/see_more/recently_added.dart';
import 'package:bookmark/utils/location.dart';
import 'package:bookmark/utils/skelten_shimmer.dart';
import 'package:bookmark/widgets/chat_bottomModelSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:bookmark/constants/colors.dart';
import 'package:bookmark/constants/textstyles.dart';

import 'package:bookmark/ui/homepage/homepage_vm.dart';
import 'package:bookmark/widgets/my_drawer.dart';
import 'package:bookmark/widgets/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  double rating = 3.5;
  late final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  DiningVM vm = Get.put(DiningVM());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Scaffold(
        drawer: MyDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // backgroundColor: AppColors.whiteColor,
                // foregroundColor: Colors.black,
                elevation: 0,
                title: const Text(
                  'Bookmark',
                  style: TextStyle(
                    // color: AppColors.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: vm.isUserLoginedIn
                    ? [
                        IconButton(
                          icon: Icon(Icons.language),
                          onPressed: () async {
                            GetLocation().determinePosition();
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.add_a_photo_outlined),
                        //   onPressed: () async {
                        //     // await vm.getUserBookmarked();
                        //     Get.to(() => PaymentSuccess(
                        //           paymentId: '987677564213554',
                        //           orderId: 'dcfgv75vgh6r56v',
                        //         ));
                        //   },
                        // ),
                        CartIconWithBadge(
                          no: vm.cartfoods.length,
                          icon: CupertinoIcons.cart,
                          onPressed: () {
                            vm.getUserBookmarked();
                            Get.to(() => OrderPage());
                          },
                        ),
                      ]
                    : [],
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  // preferredSize : const Size.fromHeight(124),
                  preferredSize: const Size.fromHeight(65),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              vm.userTapForSearch();
                              Get.to(() => SearchPage());
                            },
                            child: SearchBar())
                      ],
                    ),
                  ),
                ),
              ),
              // ),
            ];
          },
          body: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;

                if (connected) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await vm.getBookOfSelectedGenre("Horror");
                      await vm.getAllBooks();
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                          // color: AppColors.whiteColor,
                          padding: const EdgeInsets.all(10),
                          child: Column(children: <Widget>[
                            // Expanded(
                            // child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Container(
                                //     height: 55,
                                //     // margin: const EdgeInsets.only(bottom: 10),
                                //     child: ListView.builder(
                                //         scrollDirection: Axis.horizontal,
                                //         itemCount: options.length,
                                //         itemBuilder: ((context, i) {
                                //           return BookOption();
                                //         }))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BookOption(option: vm.options[0]),
                                    BookOption(option: vm.options[1]),
                                    BookOption(option: vm.options[2]),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BookOption(option: vm.options[3]),
                                    BookOption(option: vm.options[4]),
                                  ],
                                ),
                                // vm.genreLoader
                                //     ? Center(child: CircularProgressIndicator())
                                //     : Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //         children: [
                                //           GenreOption(genre: vm.genreList[0]),
                                //           GenreOption(genre: vm.genreList[1]),
                                //         ],
                                //       ),

                                // const Divider(),
                                // Container(
                                //     height: 140,
                                //     child: vm.isCategoriesSelected
                                //         ? const SizedBox()
                                //         : ListView.builder(
                                //             scrollDirection: Axis.horizontal,
                                //             itemCount: 4,
                                //             itemBuilder: ((context, i) {
                                //               return InkWell(
                                //                 onTap: () {
                                //                   vm.update();
                                //                   // Get.to(() => BookDetails(
                                //                   //         bookModel: vm.bookData2[i])
                                //                   //     // () => CollectionScreen(
                                //                   //     // data: vm.bookData2[i]),
                                //                   //     );
                                //                 },
                                //                 child: Padding(
                                //                     padding: const EdgeInsets.all(8.0),
                                //                     child: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment.spaceEvenly,
                                //                         children: <Widget>[
                                //                           Column(
                                //                             children: <Widget>[
                                //                               CircleAvatar(
                                //                                   radius: 38,
                                //                                   backgroundImage: FadeInImage
                                //                                           .assetNetwork(
                                //                                               placeholder:
                                //                                                   'assets/images/defaultt.png',
                                //                                               image: vm
                                //                                                   .bookData2[
                                //                                                       i]
                                //                                                   .thumbnail!)
                                //                                       .image),
                                //                               //     NetworkImage(
                                //                               //   fooddata2[i].url,
                                //                               //   // height: 80,
                                //                               //   // width: 80,
                                //                               //   // fit: BoxFit.cover,

                                //                               const SizedBox(
                                //                                 height: 5.0,
                                //                               ),
                                //                               Text(vm.bookData2[i]
                                //                                   .categories!)
                                //                             ],
                                //                           )
                                //                         ])),
                                //               );
                                //             }))),
                                // vm.isCategoriesSelected
                                //     ? const Center(
                                //         child: CircularProgressIndicator(
                                //           color: Colors.black,
                                //         ),
                                //       )
                                //     : const SizedBox(),

                                // Container(
                                //     height: 140,
                                //     child: vm.isCategoriesSelected
                                //         ? const SizedBox()
                                //         : ListView.builder(
                                //             scrollDirection: Axis.horizontal,
                                //             itemCount: 4,
                                //             itemBuilder: ((context, i) {
                                //               return InkWell(
                                //                 onTap: () {
                                //                   vm.update();
                                //                   // Get.to(
                                //                   //   () => BookDetails(
                                //                   //       bookModel: vm.bookData2[i + 4]),
                                //                   // );
                                //                 },
                                //                 child: Padding(
                                //                     padding: const EdgeInsets.all(8.0),
                                //                     child: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment.spaceEvenly,
                                //                         children: <Widget>[
                                //                           Column(
                                //                             children: <Widget>[
                                //                               CircleAvatar(
                                //                                   radius: 38,
                                //                                   backgroundImage:
                                //                                       FadeInImage
                                //                                           .assetNetwork(
                                //                                     placeholder:
                                //                                         'assets/images/defaultt.png',
                                //                                     image: vm
                                //                                         .bookData2[i + 4]
                                //                                         .thumbnail!,
                                //                                   ).image),
                                //                               //     NetworkImage(
                                //                               //   fooddata2[i + 4].url,
                                //                               //   // height: 80,
                                //                               //   // width: 80,
                                //                               //   // fit: BoxFit.cover,
                                //                               // )),
                                //                               const SizedBox(
                                //                                 height: 5.0,
                                //                               ),
                                //                               Text(vm.bookData2[i + 4]
                                //                                   .categories!)
                                //                             ],
                                //                           )
                                //                         ])),
                                //               );
                                //             }))),
                                const Divider(),
                                Container(
                                  height: 280,
                                  child: vm.isGenerSelected ||
                                          vm.homeScreenLoading
                                      ? ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Skelton(
                                                      height: 200, width: 135),
                                                  const SizedBox(height: 10),
                                                  Skelton(
                                                      height: 10, width: 135),
                                                  const SizedBox(height: 10),
                                                  Skelton(
                                                      height: 10, width: 100),
                                                ]);
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 10),
                                          itemCount: 4)
                                      // Center(
                                      //     child: CircularProgressIndicator(
                                      //     backgroundColor: Theme.of(context).primaryColor,
                                      //   ))
                                      : ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              onTap: () {
                                                vm.moreBooksByUser(vm
                                                    .genreBooksList[i]
                                                    .uploadedBy!);
                                                // getBookOfSelectedGener(vm.);
                                                Get.to(() => BookDetails(
                                                    bookModel:
                                                        vm.genreBooksList[i]));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 1),
                                                width: 130,
                                                height: 280,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // rectangle22Xb8 (126:200)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 10.5),
                                                      width: Get.width,
                                                      height: 184,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Color(0x66000000),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(vm
                                                              .genreBooksList[i]
                                                              .image1
                                                              .url),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // manusiasetengahdewaKmt (126:198)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 3.5),
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 121,
                                                      ),
                                                      child: Text(
                                                        vm
                                                                    .genreBooksList[
                                                                        i]
                                                                    .bookName
                                                                    .length >
                                                                15
                                                            ? vm
                                                                .genreBooksList[
                                                                    i]
                                                                .bookName
                                                                .substring(
                                                                    0, 15)
                                                            : vm
                                                                .genreBooksList[
                                                                    i]
                                                                .bookName,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.5,
                                                          color:
                                                              Color(0x99353940),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      // iwanfalsxZx (126:199)
                                                      "by ${vm.genreBooksList[i].author ?? ""}",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.5,
                                                        color:
                                                            Color(0x99353940),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, i) {
                                            return SizedBox(width: 30);
                                          },
                                          itemCount: vm.genreBooksList.length,
                                        ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Recently Added Books',
                                          style: TextStyles.h1Heading,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(
                                                "first item : ${vm.list[0].bookName}");

                                            Get.to(
                                                () => RecentlyAddeddSeeMore());
                                          },
                                          child: Text(
                                            'see all',
                                            style: TextStyles.subTextRed,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 250,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: vm.homeScreenLoading
                                          ? ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, i) {
                                                return Stack(children: [
                                                  Skelton(
                                                      height: 230, width: 135),
                                                  Positioned(
                                                      bottom: 10,
                                                      left: 5,
                                                      child: Skelton(
                                                          height: 10,
                                                          width: 110)),
                                                  // Skelton(height: 10, width: 100),
                                                ]);
                                              },
                                              separatorBuilder: (context, i) {
                                                return SizedBox(width: 10);
                                              },
                                              itemCount: vm.homeScreenLoading
                                                  ? 4
                                                  : vm.collectionBooks.length)
                                          : ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  vm.collectionBooks.length,
                                              itemBuilder: (context, i) {
                                                return collectionBooks(
                                                    function: () {
                                                      vm.moreBooksByUser(vm
                                                          .collectionBooks[i]
                                                          .uploadedBy!);
                                                      Get.to(() => BookDetails(
                                                          bookModel:
                                                              vm.collectionBooks[
                                                                  i]));
                                                    },
                                                    image: vm.collectionBooks[i]
                                                        .image1.url,
                                                    title: vm.collectionBooks[i]
                                                        .bookName,
                                                    quality: '12');
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return const SizedBox(
                                                    width: 10);
                                              },
                                            )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // const Padding(
                                //   padding: EdgeInsets.all(8.0),
                                //   child: Text(
                                //     "Highest Rating",
                                //     style: TextStyles.h1Heading,
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Container(
                                //     height: 290,
                                //     child: ListView.builder(
                                //         scrollDirection: Axis.horizontal,
                                //         itemCount: vm.highestRatingBook.length,
                                //         itemBuilder: (context, i) {
                                //           return Stack(
                                //             children: [
                                //               InkWell(
                                //                 onTap: () {
                                //                   vm.update();
                                //                   Get.to(
                                //                     () => BookDetails(
                                //                         bookModel:
                                //                             vm.highestRatingBook[i]),
                                //                     // () => CollectionScreen(
                                //                     // data: vm.fooddata2[i]
                                //                     // ),
                                //                   );
                                //                 },
                                //                 child: Container(
                                //                   margin: const EdgeInsets.symmetric(
                                //                       horizontal: 10),
                                //                   width: 155,
                                //                   height: 285,
                                //                   decoration: BoxDecoration(
                                //                     borderRadius:
                                //                         BorderRadius.circular(16),
                                //                   ),
                                //                   child: Card(
                                //                     shape: RoundedRectangleBorder(
                                //                         side: const BorderSide(
                                //                           color: AppColors.separatorGrey,
                                //                         ),
                                //                         borderRadius:
                                //                             BorderRadius.circular(16)),
                                //                     child: Column(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .spaceBetween,
                                //                         children: [
                                //                           Column(
                                //                             children: [
                                //                               Align(
                                //                                 alignment:
                                //                                     Alignment.topCenter,
                                //                                 child: ClipRRect(
                                //                                   borderRadius:
                                //                                       const BorderRadius
                                //                                           .only(
                                //                                     topLeft:
                                //                                         Radius.circular(
                                //                                             16),
                                //                                     topRight:
                                //                                         Radius.circular(
                                //                                             16),
                                //                                   ),
                                //                                   child: Image.network(
                                //                                     vm.highestRatingBook[i]
                                //                                         .thumbnail!,
                                //                                     height: 170,
                                //                                     width: 150,
                                //                                     fit: BoxFit.cover,
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                               Padding(
                                //                                 padding: const EdgeInsets
                                //                                         .symmetric(
                                //                                     horizontal: 5,
                                //                                     vertical: 5),
                                //                                 child: RichText(
                                //                                     maxLines: 3,
                                //                                     text: TextSpan(
                                //                                       text: vm
                                //                                           .highestRatingBook[
                                //                                               i]
                                //                                           .title!,
                                //                                       style: TextStyle(
                                //                                           fontSize: 10,
                                //                                           color: Colors
                                //                                               .grey
                                //                                               .shade800,
                                //                                           fontWeight:
                                //                                               FontWeight
                                //                                                   .w600),
                                //                                     )),
                                //                               ),
                                //                               Padding(
                                //                                 padding: const EdgeInsets
                                //                                         .symmetric(
                                //                                     horizontal: 5),
                                //                                 child: Row(
                                //                                   mainAxisAlignment:
                                //                                       MainAxisAlignment
                                //                                           .spaceBetween,
                                //                                   children: [
                                //                                     Container(
                                //                                         child: Row(
                                //                                             children: [
                                //                                           const Icon(
                                //                                               Icons
                                //                                                   .watch_later_rounded,
                                //                                               size: 15),
                                //                                           const Icon(
                                //                                               Icons
                                //                                                   .circle,
                                //                                               size: 8,
                                //                                               color: Colors
                                //                                                   .grey),
                                //                                           Text(vm
                                //                                                   .highestRatingBook[
                                //                                                       i]
                                //                                                   .distance ??
                                //                                               "3.5Km"),
                                //                                         ])),
                                //                                     Container(
                                //                                       padding:
                                //                                           const EdgeInsets
                                //                                                   .symmetric(
                                //                                               horizontal:
                                //                                                   5,
                                //                                               vertical:
                                //                                                   3),
                                //                                       decoration:
                                //                                           BoxDecoration(
                                //                                         color:
                                //                                             Colors.green,
                                //                                         borderRadius:
                                //                                             BorderRadius
                                //                                                 .circular(
                                //                                                     20),
                                //                                       ),
                                //                                       child: Row(
                                //                                         children: [
                                //                                           Text(
                                //                                               vm
                                //                                                   .highestRatingBook[
                                //                                                       i]
                                //                                                   .reviews!
                                //                                                   .rating
                                //                                                   .toString(),
                                //                                               style: const TextStyle(
                                //                                                   color: Colors
                                //                                                       .white)),
                                //                                           const Icon(
                                //                                               Icons.star,
                                //                                               color: Colors
                                //                                                   .white,
                                //                                               size: 18)
                                //                                         ],
                                //                                       ),
                                //                                     ),
                                //                                   ],
                                //                                 ),
                                //                               ),
                                //                             ],
                                //                           ),
                                //                           Container(
                                //                               padding: const EdgeInsets
                                //                                       .symmetric(
                                //                                   horizontal: 5,
                                //                                   vertical: 5),
                                //                               decoration: BoxDecoration(
                                //                                 color:
                                //                                     Colors.blue.shade200,
                                //                                 borderRadius:
                                //                                     const BorderRadius
                                //                                             .only(
                                //                                         bottomLeft: Radius
                                //                                             .circular(16),
                                //                                         bottomRight:
                                //                                             Radius
                                //                                                 .circular(
                                //                                                     16)),
                                //                               ),
                                //                               child: Row(
                                //                                 children: const [
                                //                                   Icon(Icons.verified,
                                //                                       color: Colors.white,
                                //                                       size: 14),
                                //                                   Text(
                                //                                       "50% OFF upto 100"),
                                //                                 ],
                                //                               ))
                                //                         ]),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           );
                                //         })),
                                // Container(
                                //   height: 25,
                                // ),
                                (vm.featuredBooks.isEmpty &&
                                        !vm.homeScreenLoading)
                                    ? SizedBox()
                                    : Container(
                                        child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Books from your saved list',
                                              style: TextStyles.h1Heading,
                                            ),
                                            // SizedBox(
                                            //   height: 5.0,
                                            // ),
                                            // Text(
                                            //   'Everything in a list - go',
                                            //   style: TextStyles.subText,
                                            // ),
                                          ],
                                        ),
                                      )),
                                //                     SizedBox(
                                //                         height: vm.suggestionItemCard.length * 340,
                                //                         child: ListView.separated(
                                //                             physics: const NeverScrollableScrollPhysics(),
                                //                             itemBuilder: (context, i) {
                                //                               return CustomFoodCard(
                                //                                 i: i,
                                //                                 controller: controller,
                                //                                 bottomTag1: CreateTag(
                                //                                     title: '15% OFF - no code required',
                                //                                     color: AppColors.highlighterBlueDark),
                                //                               );
                                //                             },
                                //                             separatorBuilder: (context, i) {
                                //                               return const SizedBox(height: 10);
                                //                             },
                                //                             itemCount: vm.suggestionItemCard.length)),

                                const BookDetailsWidgets(),

                                // const Padding(
                                //   padding: EdgeInsets.all(10.0),
                                //   child:
                                //       Text("Featured Books", style: TextStyles.h1Heading),
                                // ),
                                // Container(
                                //   height: 275 *
                                //       (vm.loadMore ? vm.featuredBooks.length / 2 : 4),
                                //   child: ListView.builder(
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     itemBuilder: (context, i) {
                                //       return Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             BookCardVert(
                                //                 bookModel: vm.featuredBooks[2 * i]),
                                //             BookCardVert(
                                //                 bookModel: vm.featuredBooks[2 * i + 1]),
                                //           ]);
                                //     },
                                //     itemCount: vm.featuredBooks.isNotEmpty
                                //         ? vm.loadMore
                                //             ? vm.featuredBooks.length ~/ 2
                                //             : 4
                                //         : 0,
                                //   ),
                                // ),
                                // const SizedBox(height: 20),
                                // InkWell(
                                //   onTap: () {
                                //     vm.loadMoreLoading = true;
                                //     vm.update();
                                //     Future.delayed(const Duration(seconds: 2), () {
                                //       vm.loadMore = true;
                                //       vm.loadMoreLoading = false;
                                //       vm.update();
                                //     });
                                //   },
                                //   child: vm.loadMoreLoading
                                //       ? const Center(child: CircularProgressIndicator())
                                //       : vm.loadMore
                                //           ? const SizedBox()
                                //           : Center(
                                //               child: Text(
                                //                 "Load More..",
                                //                 style: TextStyle(
                                //                   color: Theme.of(context).primaryColor,
                                //                   fontWeight: FontWeight.w600,
                                //                 ),
                                //               ),
                                //             ),
                                // ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            // )
                          ])),
                    ),
                  );
                } else {
                  return Stack(
                    // fit: StackFit.expand,
                    children: [
                      Container(
                        // height: Get.height - 250,
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              if (i == vm.offlineBooksList.length) {
                                return Container(
                                  height: 25,
                                );
                              } else {
                                return vm.loadMessages
                                    ? Center(child: CircularProgressIndicator())
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ]),
                                        child: Row(children: [
                                          Container(
                                            height: 200,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200,
                                              image: DecorationImage(
                                                image: FadeInImage(
                                                  placeholder: AssetImage(
                                                      'assets/images/defaultt.png'),
                                                  image: Image.memory(
                                                          vm.offlineBooksList[i]
                                                              ["image"],
                                                          fit: BoxFit.cover)
                                                      .image,
                                                  fit: BoxFit.cover,
                                                ).image,
                                                // fit: BoxFit.cover,
                                              ),
                                            ),
                                            // child:
                                            // Container(
                                            //   color: Colors.transparent,
                                            //   child: Container(
                                            //     alignment: Alignment.topLeft,
                                            //     width: 45,
                                            //     height: 45,
                                            //     child: InkWell(
                                            //       onTap: () {
                                            //         // vm.addInCartList(vm.featuredBooks[i]);
                                            //         vm.sevetoCart(vm.featuredBooks[i]);
                                            //         // vm.increaseQuantity(vm.featuredBooks[i]);
                                            //       },
                                            //       child: Container(
                                            //         alignment: Alignment.topRight,
                                            //         width: 45,
                                            //         height: 45,
                                            //         decoration: BoxDecoration(
                                            //             color: vm.isBookInCartList(
                                            //                     vm.featuredBooks[i])
                                            //                 ? Color.fromARGB(
                                            //                     255, 235, 231, 19)
                                            //                 : Colors.grey.shade300,
                                            //             borderRadius:
                                            //                 BorderRadius.circular(25)),
                                            //         child: Center(
                                            //             child: Icon(
                                            //                 vm.isBookInCartList(
                                            //                         vm.featuredBooks[i])
                                            //                     ? Icons.bookmark
                                            //                     : Icons.bookmark_add_rounded,
                                            //                 color: Colors.grey.shade900)),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                // Get.to(() => BookDetails(
                                                //     bookModel:
                                                //         vm.featuredBooks[i]));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: Get.width > 400
                                                        ? 200
                                                        : Get.width - 140,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: Get.width > 400
                                                              ? 200
                                                              : Get.width - 180,
                                                          child: RichText(
                                                            text: TextSpan(
                                                                text: vm.offlineBooksList[
                                                                        i][
                                                                    'bookName'],
                                                                style: TextStyles
                                                                    .blueTitle),
                                                          ),
                                                        ),
                                                        // InkWell(
                                                        //   onTap: () {
                                                        //     // vm.addInCartList(
                                                        //     //     vm.collectionBooks[i]);
                                                        //     // vm.increaseQuantity(
                                                        //     //     vm.collectionBooks[i]);
                                                        //   },
                                                        //   child: Container(
                                                        //     alignment: Alignment.topRight,
                                                        //     width: 45,
                                                        //     height: 45,
                                                        //     decoration: BoxDecoration(
                                                        //         color: vm.isBookInCartList(
                                                        //                 vm.collectionBooks[i])
                                                        //             ? Colors.green.shade300
                                                        //             : Colors.grey.shade300,
                                                        //         borderRadius:
                                                        //             BorderRadius.circular(25)),
                                                        //     child: Center(
                                                        //         child: Icon(
                                                        //             vm.isBookInCartList(
                                                        //                     vm.collectionBooks[i])
                                                        //                 ? Icons.bookmark
                                                        //                 : Icons
                                                        //                     .bookmark_add_rounded,
                                                        //             color: Colors.grey.shade900)),
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  RichText(
                                                    maxLines: 3,
                                                    text: TextSpan(
                                                        text: vm.offlineBooksList[
                                                                    i][
                                                                'description'] ??
                                                            "this book is one of the best selling book in 2020",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade800,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(children: [
                                                    RichText(
                                                        text: TextSpan(
                                                            text:
                                                                "₹ ${(vm.offlineBooksList[i]['rentPerDay']! ?? 0 * 1.0).toStringAsFixed(2)}",
                                                            style: TextStyles
                                                                .blueTitle,
                                                            children: const [
                                                          TextSpan(
                                                              text: " Per day",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ))
                                                        ])),
                                                    // const SizedBox(width: 10),
                                                    // const Text('2 days ago')
                                                  ]),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    height: 45,
                                                    width: Get.width > 400
                                                        ? 200
                                                        : Get.width - 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          Colors.grey.shade900,
                                                    ),
                                                    child: const Center(
                                                      child: Text("Rent Now",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ]));
                              }
                            },
                            separatorBuilder: (context, i) {
                              return const SizedBox(height: 10);
                            },
                            itemCount: vm.offlineBooksList.length + 1),
                      ),
                      Positioned(
                        height: 24.0,
                        bottom: 0.0,
                        child: Container(
                          width: Get.width,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.75),
                          child: Center(
                            child: Text(
                              "${connected ? 'ONLINE' : 'OFFLINE'}",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
              child: SizedBox()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bottomModelWidget(context);
          },
          child: const Icon(Icons.chat),
        ),
      );
    });
  }
}

class SavedListShimmer extends StatelessWidget {
  const SavedListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skelton(height: 200, width: 130),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skelton(height: 25, width: Get.width - 180),
            const SizedBox(height: 10),
            Skelton(height: 15, width: Get.width - 180),
            const SizedBox(height: 5),
            Skelton(height: 15, width: Get.width - 180),
            const SizedBox(height: 5),
            Row(
              children: [
                Skelton(height: 40, width: 75),
                const SizedBox(width: 10),
                Skelton(height: 20, width: 50),
              ],
            ),
            const SizedBox(height: 10),
            Skelton(height: 50, width: 180)
          ],
        )
      ],
    );
  }
}

class BookCardVert extends StatelessWidget {
  BookModel bookModel;
  BookCardVert({
    required this.bookModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return InkWell(
        onTap: () {
          // Get.to(() => FoodDetailsPage(bookModel: bookModel));
          vm.moreBooksByUser(bookModel.uploadedBy!);
          Get.to(() => BookDetails(bookModel: bookModel));
        },
        child: Stack(
          children: [
            Container(
              height: 270,
              width: Get.width < 380 ? Get.width * 0.48 : 165,
              child: Column(
                children: [
                  Container(
                    height: 250 / 2 - 10,
                  ),
                  Container(
                    height: 250 / 2 + 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    // padding:
                    //     const EdgeInsets.all(5),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width < 380 ? Get.width * 0.46 : 135,
                              child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: bookModel.bookName,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const SizedBox(
                                width: 20,
                                child: Icon(Icons.more_vert_outlined,
                                    color: Colors.black, size: 30),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/defaultt.png',
                        image: bookModel.image1.url),
                    // Image.network(
                    //   bookModel.thumbnail!,
                    //   height: 200,
                    //   width: Get.width < 380 ? Get.width * 0.46 : 130,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                )),
            Positioned(
                top: 20,
                right: 8,
                child: Container(
                    // padding:
                    //     const EdgeInsets.symmetric(
                    //         vertical: 2,
                    //         horizontal: 5),
                    padding: const EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:
                        // Row(
                        //   children: [
                        //     const Icon(Icons.star,
                        //         color: Colors.yellow),
                        //     const SizedBox(
                        //       width: 5,
                        //     ),
                        //     Text(
                        //         vm.featuredBooks[2 * i]
                        //             .reviews!.rating!
                        //             .toString(),
                        //         style: const TextStyle(
                        //           fontWeight:
                        //               FontWeight.w500,
                        //         ))
                        //   ],
                        // ),
                        CircularWidget(
                            icon: bookModel.isLiked
                                ? CupertinoIcons.heart_fill
                                : Icons.favorite_outline_rounded,
                            size: 28,
                            function: () {
                              bookModel.isLiked = !bookModel.isLiked;
                              if (vm.likedBookList.contains(bookModel)) {
                                vm.likedBookList.remove(bookModel);
                              } else {
                                vm.likedBookList.add(bookModel);
                              }
                              // controller!
                              //     .reverse()
                              //     .then((value) => controller!.forward());
                              vm.update();
                            },
                            color: Colors.red)))
          ],
        ),
      );
    });
  }
}

class collectionBooks extends StatelessWidget {
  final String image;
  final String? title;
  Function function;
  final String? quality;
  collectionBooks({
    Key? key,
    required this.image,
    required this.function,
    this.title,
    this.quality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Center(
        child: Container(
          constraints: const BoxConstraints.expand(height: 220.0, width: 145),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/defaultt.png', image: image)
                  .image,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title ?? "", style: TextStyles.actionTitleWhite),
                Text(
                  quality ?? "",
                  style: TextStyles.highlighterOne,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenreOption extends StatelessWidget {
  Genre genre;
  GenreOption({Key? key, required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return InkWell(
        onTap: () {
          // vm.tapOnCategoriesSelected();
          // for (var element in vm.options) {
          //   element.selected = false;
          // }
          // option.selected = !option.selected;
          // vm.update();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: genre.selected
                  ? AppColors.highlighterBlueDark
                  : Colors.grey.withOpacity(0.3),
              width: 2,
            ),
            color: genre.selected
                ? AppColors.highlighterBlueDark.withOpacity(0.7)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(genre.image!.url,
                  width: 35, height: 35, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Text(
                genre.genre,
                style: TextStyle(
                    color: genre.selected ? AppColors.whiteColor : Colors.grey),
              )
            ],
          ),
        ),
      );
    });
  }
}

class BookOption extends StatelessWidget {
  Option option;
  BookOption({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return InkWell(
        onTap: () {
          vm.tapOnCategoriesSelected();
          for (var element in vm.options) {
            element.selected = false;
          }
          option.selected = !option.selected;
          vm.getBookOfSelectedGenre(option.name.toLowerCase());
          vm.update();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: option.selected
                  ? AppColors.highlighterBlueDark
                  : Colors.grey.withOpacity(0.3),
              width: 2,
            ),
            color: option.selected
                ? AppColors.highlighterBlueDark.withOpacity(0.7)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                option.icon,
                color: option.selected
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
              ),
              const SizedBox(width: 10),
              Text(
                option.name != "Fiction" ? option.name : "Science and Fiction",
                style: TextStyle(
                    color:
                        option.selected ? AppColors.whiteColor : Colors.grey),
              )
            ],
          ),
        ),
      );
    });
  }
}

// class CustomFoodCard extends StatelessWidget {
//   Widget? topTag1;
//   int i;
//   bool isLikedPage;
//   AnimationController? controller;
//   Widget? bottomTag1;
//   CustomFoodCard({
//     Key? key,
//     required this.i,
//     this.controller,
//     this.isLikedPage = false,
//     this.topTag1,
//     this.bottomTag1,
//   }) : super(key: key);

//   var rng = Random();

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DiningVM>(builder: (vm) {
//       BookModel item = isLikedPage ? vm.likedBookList[i] : vm.suggestionItemCard[i];
//       return FadeAnimation(
//         1.4,
//         Container(
//           padding: const EdgeInsets.all(5),
//           child: Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 side: const BorderSide(
//                   color: AppColors.separatorGrey,
//                 ),
//                 borderRadius: BorderRadius.circular(26)),
//             color: AppColors.whiteColor,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Center(
//                   child: Container(
//                     constraints:
//                         const BoxConstraints.expand(height: 200.0, width: 450),
//                     alignment: Alignment.bottomLeft,
//                     padding: const EdgeInsets.only(
//                         left: 16.0, bottom: 8.0, top: 8.0),
//                     decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(26),
//                             topRight: Radius.circular(26)),
//                         image: DecorationImage(
//                           image: FadeInImage.assetNetwork(
//                                   placeholder: "assets/images/defaultt.png",
//                                   image: item.thumbnail!,
//                                   fit: BoxFit.fill)
//                               .image,
//                           // fit: BoxFit.fill,
//                         )),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             item.topTags != null
//                                 ? item.topTags!.length > 1
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           CreateTag(title: item.topTags![0]),
//                                           const SizedBox(width: 10),
//                                           CreateTag(title: item.topTags![1])
//                                         ],
//                                       )
//                                     : CreateTag(
//                                         title: item.topTags![0],
//                                       )
//                                 : const SizedBox(),
//                             !isLikedPage
//                                 ? Container(
//                                     alignment: Alignment.topRight,
//                                     margin:
//                                         const EdgeInsets.only(right: 5, top: 0),
//                                     child: InkWell(
//                                       onTap: () {
//                                         item.isLiked = !item.isLiked;
//                                         if (vm.likedBookList.contains(item)) {
//                                           vm.likedBookList.remove(item);
//                                         } else {
//                                           vm.likedBookList.add(item);
//                                         }
//                                         controller!.reverse().then(
//                                             (value) => controller!.forward());
//                                         vm.update();
//                                       },
//                                       child:
//                                           // ScaleTransition(
//                                           // scale: Tween(begin: 0.7, end: 1.0)
//                                           // .animate(CurvedAnimation(
//                                           // parent: controller!,
//                                           // curve: Curves.easeOut)),
//                                           // child:
//                                           CircleAvatar(
//                                         radius: 20,
//                                         backgroundColor: item.isLiked
//                                             ? Colors.white
//                                             : Colors.red,
//                                         child: Icon(CupertinoIcons.heart_fill,
//                                             color: item.isLiked
//                                                 ? Colors.red
//                                                 : Colors.white,
//                                             size: 28),
//                                       ),
//                                       // ),
//                                     ),
//                                   )
//                                 : const SizedBox(),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             item.bottomTags != null
//                                 ? item.bottomTags!.length > 1
//                                     ? Row(
//                                         children: [
//                                           CreateTag(
//                                               title: item.bottomTags![0],
//                                               color: AppColors
//                                                   .highlighterBlueDark),
//                                           CreateTag(
//                                               title: item.bottomTags![1],
//                                               color:
//                                                   AppColors.highlighterBlueDark)
//                                         ],
//                                       )
//                                     : CreateTag(
//                                         title: item.bottomTags![0],
//                                         color: AppColors.highlighterBlueDark)
//                                 : item.specialTags != null
//                                     ? CreateTag(
//                                         title: item.specialTags![0],
//                                         color: AppColors.gold,
//                                         radius: 26)
//                                     : const SizedBox()
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: Get.width - 112,
//                             child: RichText(
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                               text: TextSpan(
//                                 text: item.title!,
//                                 style: TextStyles.actionTitle,
//                               ),
//                             ),
//                           ),
//                           Container(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 4),
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade700,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     item.reviews?.rating.toString() ?? "4.7",
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                   const Icon(Icons.star,
//                                       color: Colors.white, size: 22)
//                                 ],
//                               ))
//                         ],
//                       ),
//                       Text(
//                           item.des ??
//                               item.address ??
//                               'Dessert Parlor - Desserts, Ice Cream',
//                           style: Theme.of(context).textTheme.labelMedium),
//                       Text(
//                         '${item.distance} ${String.fromCharCode(0x00B7)} Dwarika, New Delhi',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             '\u20B9${(item.currentPrice! * (1.82)).round()}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               decoration: TextDecoration.lineThrough,
//                               color: Theme.of(context).primaryColorLight,
//                             ),
//                           ),
//                           const SizedBox(width: 20),
//                           Text(
//                             '\u20B9${item.price}',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Theme.of(context).primaryColorLight,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 // const Divider(color: Color(0xFFF2F2F2)),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

class CreateTag extends StatelessWidget {
  String title;
  Color? color;
  double? radius;
  CreateTag({
    Key? key,
    required this.title,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: color ?? AppColors.persianColor,
          borderRadius: BorderRadius.circular(radius ?? 5.0)),
      child: SizedBox(
        child: RichText(
          text: TextSpan(
              text: title,
              style:
                  const TextStyle(fontSize: 12.0, color: AppColors.whiteColor)),
        ),
      ),
    );
  }
}

class BookDetailsWidgets extends StatelessWidget {
  const BookDetailsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiningVM>(builder: (vm) {
      return Container(
          height:
              vm.homeScreenLoading ? 4 * 240 : (vm.featuredBooks.length * 240),
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: vm.homeScreenLoading
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => SavedListShimmer(),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: 4)
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(children: [
                          Container(
                            height: 200,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                              image: DecorationImage(
                                image: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/defaultt.png'),
                                  image: Image.network(
                                          vm.featuredBooks[i].image1.url,
                                          fit: BoxFit.cover)
                                      .image,
                                  fit: BoxFit.cover,
                                ).image,
                                // fit: BoxFit.cover,
                              ),
                            ),
                            // child:
                            // Container(
                            //   color: Colors.transparent,
                            //   child: Container(
                            //     alignment: Alignment.topLeft,
                            //     width: 45,
                            //     height: 45,
                            //     child: InkWell(
                            //       onTap: () {
                            //         // vm.addInCartList(vm.featuredBooks[i]);
                            //         vm.sevetoCart(vm.featuredBooks[i]);
                            //         // vm.increaseQuantity(vm.featuredBooks[i]);
                            //       },
                            //       child: Container(
                            //         alignment: Alignment.topRight,
                            //         width: 45,
                            //         height: 45,
                            //         decoration: BoxDecoration(
                            //             color: vm.isBookInCartList(
                            //                     vm.featuredBooks[i])
                            //                 ? Color.fromARGB(
                            //                     255, 235, 231, 19)
                            //                 : Colors.grey.shade300,
                            //             borderRadius:
                            //                 BorderRadius.circular(25)),
                            //         child: Center(
                            //             child: Icon(
                            //                 vm.isBookInCartList(
                            //                         vm.featuredBooks[i])
                            //                     ? Icons.bookmark
                            //                     : Icons.bookmark_add_rounded,
                            //                 color: Colors.grey.shade900)),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                vm.moreBooksByUser(
                                    vm.featuredBooks[i].uploadedBy!);
                                Get.to(() => BookDetails(
                                    bookModel: vm.featuredBooks[i]));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        Get.width > 400 ? 200 : Get.width - 140,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width > 400
                                              ? 200
                                              : Get.width - 180,
                                          child: RichText(
                                            text: TextSpan(
                                                text: vm
                                                    .featuredBooks[i].bookName,
                                                style: TextStyles.blueTitle),
                                          ),
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     // vm.addInCartList(
                                        //     //     vm.collectionBooks[i]);
                                        //     // vm.increaseQuantity(
                                        //     //     vm.collectionBooks[i]);
                                        //   },
                                        //   child: Container(
                                        //     alignment: Alignment.topRight,
                                        //     width: 45,
                                        //     height: 45,
                                        //     decoration: BoxDecoration(
                                        //         color: vm.isBookInCartList(
                                        //                 vm.collectionBooks[i])
                                        //             ? Colors.green.shade300
                                        //             : Colors.grey.shade300,
                                        //         borderRadius:
                                        //             BorderRadius.circular(25)),
                                        //     child: Center(
                                        //         child: Icon(
                                        //             vm.isBookInCartList(
                                        //                     vm.collectionBooks[i])
                                        //                 ? Icons.bookmark
                                        //                 : Icons
                                        //                     .bookmark_add_rounded,
                                        //             color: Colors.grey.shade900)),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  RichText(
                                    maxLines: 3,
                                    text: TextSpan(
                                        text: vm.featuredBooks[i].description ??
                                            "this book is one of the best selling book in 2020",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(children: [
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                "₹ ${(vm.featuredBooks[i].rentPerDay! ?? 0 * 1.0).toStringAsFixed(2)}",
                                            style: TextStyles.blueTitle,
                                            children: const [
                                          TextSpan(
                                              text: " Per day",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ))
                                        ])),
                                    // const SizedBox(width: 10),
                                    // const Text('2 days ago')
                                  ]),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 45,
                                    width:
                                        Get.width > 400 ? 200 : Get.width - 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade900,
                                    ),
                                    child: const Center(
                                      child: Text("Rent Now",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]));
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: vm.featuredBooks.length));
    });
  }
}
