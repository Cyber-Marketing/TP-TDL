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
  static const int _pageSize = 7;
  int _currentPage = 1;
  List<Service> _services = [];
  bool _isLoading = false;
  late QueryDocumentSnapshot<Map<String, dynamic>> lastService;
  int totalServices = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_fetchServicesOnScroll);
    _fetchServices();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchServices() async {
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
      query = query.startAfterDocument(lastService);
    }

    var newServices = await query.get().then((snapshot) {
      lastService = snapshot.docs[snapshot.size - 1];

      return snapshot.docs.map((doc) {
        var serviceMap = doc.data() as Map;
        serviceMap['uid'] = doc.id;
        return Service.fromMap(serviceMap);
      }).toList();
    });

    setState(() {
      _services.addAll(newServices);
      _isLoading = false;
    });
  }

  void _fetchServicesOnScroll() {
    if (_services.length >= totalServices) {
      return;
    }
    setState(() {
      _currentPage++;
    });
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchServices();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool userIsCustomer = context.watch<AppState>().userIsCustomer();

    return Expanded(
        child: GridView.builder(
            padding: EdgeInsets.all(50),
            controller: _scrollController,
            itemCount: _services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 50,
                crossAxisSpacing: 30,
                childAspectRatio: 2,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : AppointableServiceCard(
                      showButton: userIsCustomer,
                      service: _services[index],
                    );
            }));
  }
}
