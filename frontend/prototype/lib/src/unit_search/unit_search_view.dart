import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/login/login_view.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';
import 'package:prototype/src/http_requests.dart';

int maxOffset = 20;

var filterDict = {
  1: 'Organisation',
  2: 'License plate',
  3: 'Vehicle name',
  4: 'IMEI',
  5: 'CVR'
};

/// Displays a list of SampleItems.
class UnitSearchView extends StatefulWidget {
  final String token;

  const UnitSearchView({super.key, required this.token});
  static const routeName = '/unit_search';

  @override
  createState() => _UnitSearchViewState();
}

class _UnitSearchViewState extends State<UnitSearchView> {
  final ScrollController _scrollController = ScrollController();
  final List<Vehicle> _data = [];
  bool _isLoading = false;
  int _offset = 0;
  int _filter = 4;
  /* TYPES
  1 = orgname
  2 = license plate
  3 = vehiclename
  4 = imei
  5 = CVR
  */
  String _query = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialData();
  }

  void _resetData() {
    setState(() {
      _isLoading = true;
      _offset = 0;
      _data.clear();
    });

    _fetchInitialData();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Vehicle> initialData =
          await getDevices(_offset, maxOffset, _filter, widget.token, _query);
      setState(() {
        _data.addAll(initialData);
        _offset += maxOffset;
      });
    } catch (e) {
      throw Exception("Error fetching devices: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoading = true;
    });
    List<Vehicle> vlist =
        await getDevices(_offset, maxOffset, _filter, widget.token, _query);
    setState(() {
      _offset += maxOffset;
      _data.addAll(vlist);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Device Search'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filter = 4;
                          });
                          _showDialog(context, "IMEI");
                        },
                        child: const Card(
                          child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "IMEI",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filter = 1;
                          });
                          _showDialog(context, "Organisation");
                        },
                        child: const Card(
                          child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ORG",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filter = 2;
                          });
                          _showDialog(context, "Plate number");
                        },
                        child: const Card(
                          child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "PLATE",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filter = 3;
                          });
                          _showDialog(context, "Name");
                        },
                        child: const Card(
                          child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "NAME",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filter = 5;
                          });
                          _showDialog(context, "CVR");
                        },
                        child: const Card(
                          child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "CVR",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const Text("Search Parameters:"),
                      Text("${filterDict[_filter]} = $_query"),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                            leading: const Icon(Icons.router),
                            trailing: const Icon(Icons.launch),
                            title: Text("IMEI: ${_data[index].imei}"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UnitPageView(
                                          token: widget.token,
                                          deviceImei: "${_data[index].imei}")));
                            },
                          ));
                        })),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show a dialog
  void _showDialog(BuildContext context, type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          title: Text('Enter $type'),
          content: Column(
            mainAxisSize: MainAxisSize
                .min, // To prevent content from expanding unnecessarily
            children: [
              Text('Please enter a value for $type below:'),
              TextField(
                onChanged: (value) => setState(() {
                  _query = value;
                }),
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter something...',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _query = "";
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _resetData();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
