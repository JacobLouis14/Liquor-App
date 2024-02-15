import 'package:flutter/material.dart';

//////////////////////////////////////FIle import
import 'package:frontend/global/globalData.dart';
import 'package:frontend/services/productSearch_filter.dart';
import 'package:provider/provider.dart';

//Header Component
class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key});

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  //Initial Function
  void initialFunction() {
    if (stateThroughLocation?.length != null) {
      for (int i = 0; i < location!.length; i++) {
        if (stateThroughLocation == location![i].stateName) {
          setState(() {
            isSelectedIndex = i;
            selectedLocation = location![i].stateName;
            isInitialRun = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    location = stateList;
    if (isInitialRun == true) {
      initialFunction();
    }
    //Filtering products based on stateLocation
    final getProductBasedState = context.read<ProductSearchAndFilter>();
    getProductBasedState
        .productFilterBasedState(stateThroughLocation ?? selectedLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Screen Diamention
    var screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 15),
      color: Colors.white,
      // height: screenSize.height * 0.28,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Location widget
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: location!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(location![index].stateName!),
                                      selected: isSelectedIndex == index,
                                      selectedTileColor: Colors.green[50],
                                      onTap: () {
                                        setState(() {
                                          selectedLocation =
                                              location![index].stateName!;
                                          isSelectedIndex = index;
                                        });
                                        final getProductBasedState = context
                                            .read<ProductSearchAndFilter>();
                                        getProductBasedState
                                            .productFilterBasedState(
                                                location![index].stateName!);
                                        Navigator.pop(context);
                                      },
                                      tileColor: Colors.grey[200],
                                    ),
                                  );
                                }),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close')),
                          ]),
                        );
                      });
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 40,
                    ),
                    Container(
                      width: screenSize.width * 0.4,
                      child: Text(
                        selectedLocation!,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //SearchBox
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05,
                  top: 10),
              child: TextField(
                onChanged: (value) {
                  final productSearchandFilter =
                      context.read<ProductSearchAndFilter>();
                  productSearchandFilter.productSearchService(value);
                },
                style: TextStyle(height: 0.8, fontSize: 20),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Discover The Endless',
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
