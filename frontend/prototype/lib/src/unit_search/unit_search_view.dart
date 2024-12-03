import 'package:flutter/material.dart';
import 'package:prototype/src/DAOs/Vehicle.dart';
import 'package:prototype/src/login/login_view.dart';
import 'package:prototype/src/unit_page/unit_page_view.dart';
import 'package:prototype/src/unit_search/unit_search_button.dart';
import 'package:prototype/src/unit_search/unit_search_http.dart';

int maxOffset = 20;

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
  String query = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Vehicle> initialData =
          await getDevices(_offset, maxOffset, _filter, widget.token, query);
      setState(() {
        _data.addAll(initialData);
      });
    } catch (e) {
      print("Error fetching devices: $e");
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

    setState(() async {
      _offset += maxOffset;
      _data.addAll(
          await getDevices(_offset, maxOffset, _filter, widget.token, query));
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Future.delayed(Duration.zero, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
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
              const SizedBox(height: 30),
              const Text("Filter"),
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Imei",
                      icon: const Icon(Icons.fingerprint),
                      onPressed: () {
                        _showDialog(
                            context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Firma",
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        _showDialog(
                            context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Plade",
                      icon: const Icon(Icons.local_shipping),
                      onPressed: () {
                        _showDialog(
                            context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: UnitSearchButton(
                      initialText: "Online",
                      icon: const Icon(Icons.link),
                      onPressed: () {
                        _showDialog(
                            context); // Trigger the dialog when button is pressed
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              // Wrapping the ListView in Expanded directly
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                child: ListTile(
                                  leading: Icon(Icons.router),
                                  trailing: Icon(Icons.launch),
                              title: Text(_data[index].imei.toString()),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UnitPageView(
                                            token: widget.token,
                                            device_id: _data[index].id)));
                              },
                            ));
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show a dialog
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: const Text('Enter Value'),
          content: Column(
            mainAxisSize: MainAxisSize
                .min, // To prevent content from expanding unnecessarily
            children: [
              const Text('Please enter a value below:'),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter something...',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // You can access the text entered in _controller.text
                print("User entered: ${_controller.text}");
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
