part of 'pages.dart';

class ListProjectPage extends StatefulWidget {
  final String? link, role, title;
  ListProjectPage({this.link, this.role, this.title});
  @override
  _ListProjectPageState createState() => _ListProjectPageState();
}

class _ListProjectPageState extends State<ListProjectPage> {
  bool isLoading = false;
  bool more = true;
  int page = 2;

  List<ReportModel> dataProject = [];
  ScrollController _scrollController = ScrollController();

  _loadMore() async {
    isLoading = true;
    if (mounted) setState(() {});

    final data = await ProjectService.getListProject(
        role: (widget.role == null) ? widget.link : widget.role, page: page);
    //data != null && data.reports != null &&
    if (data.reports.isNotEmpty) {
      isLoading = false;
      //dataProject.addAll(data.reports);
      page++;
      if (mounted) setState(() {});
    } else {
      isLoading = false;
      more = false;
      if (mounted) setState(() {});
    }
  }

  _loadData() async {
    // setState(() {
    //   isLoading = true;
    // });
    // final data = await ProjectService.getListProject(
    //     role: (widget.role == null) ? widget.link : widget.role);

    // if (data.reports != null && data.reports.isNotEmpty) {
    //   setState(() {
    //     dataProject.addAll(data.reports);
    //     isLoading = false;
    //   });
    //   return;
    // }
    // setState(() {
    //   isLoading = false;
    // });

    isLoading = true;
    if (mounted) setState(() {});
    final data = await ProjectService.getListProject(
        role: (widget.role == null) ? widget.link : widget.role);
    //data != null && data.reports != null &&
    if (data.reports.isNotEmpty) {
      //dataProject.addAll(data.reports);
      isLoading = false;
      if (mounted) setState(() {});
      return;
    }
    isLoading = false;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.extentBefore > 150) {
        if (more && !isLoading) _loadMore();
      }
    });
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     if (more) _loadMore();
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(widget.title!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Text(
                  "Report",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 12),
            (dataProject.isEmpty && isLoading)
                ? SizedBox(
                    child: Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.red[900],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: dataProject.map((e) {
                          return GestureDetector(
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.eventName!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Text(e.updateAt!),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditReport(
                                          eventId: e.eventId,
                                          link: widget.link,
                                          role: widget.role,
                                          name: e.eventName,
                                        ))),
                          );
                        }).toList()),
                  ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: RaisedButton(
            color: Colors.red[900],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Text(
              "Create New",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QualityControlPage(
                        link: widget.link,
                        title: widget.title,
                        role: widget.role))),
          ),
        ),
      ),
    );
  }
}
