import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/app_state.dart';
import 'package:web_app/domain/service.dart';
import 'package:web_app/widgets/cards/appointable_service_card.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const int _pageSize = 6;
  int _currentPage = 1;
  List<Service> _data = [];
  bool _isLoading = false;
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisible;
  int totalServices = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    var query =
        FirebaseFirestore.instance.collection('services').limit(_pageSize);

    if (_currentPage == 1) {
      totalServices = await FirebaseFirestore.instance
          .collection('services')
          .count()
          .get()
          .then(
            (res) => res.count ?? 0,
          );
    } else {
      query = query.startAfterDocument(lastVisible);
    }

    var newServices = await query.get().then((snapshot) {
      lastVisible = snapshot.docs[snapshot.size - 1];

      return snapshot.docs.map((doc) {
        var serviceMap = doc.data() as Map;
        serviceMap['uid'] = doc.id;
        return Service.fromMap(serviceMap);
      }).toList();
    });

    setState(() {
      _data.addAll(newServices);
      _isLoading = false;
    });
  }

  void _loadMoreData() {
    setState(() {
      _currentPage++;
    });
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    bool userIsCustomer = context.watch<AppState>().userIsCustomer();

    return Expanded(
        child: GridView.builder(
            padding: EdgeInsets.all(50),
            itemCount: _data.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 50,
                crossAxisSpacing: 30,
                childAspectRatio: 2,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              if (index == _data.length) {
                var child = _isLoading
                    ? CircularProgressIndicator()
                    : Visibility(
                        visible: _currentPage * _pageSize <= totalServices,
                        child: ElevatedButton(
                          onPressed: _loadMoreData,
                          child: Text(
                            '${_currentPage * _pageSize}/$totalServices\nCargar más',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                return Center(child: child);
              }

              return AppointableServiceCard(
                showButton: userIsCustomer,
                service: _data[index],
              );
            }));
  }
}
