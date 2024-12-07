import 'package:justfood_multivendor/helper/responsive_helper.dart';
import 'package:justfood_multivendor/util/dimensions.dart';
import 'package:justfood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginatedListViewWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int? offset) onPaginate;
  final int? totalSize;
  final int? offset;
  final Widget productView;
  final bool enabledPagination;
  final bool reverse;
  const PaginatedListViewWidget({super.key, required this.scrollController, required this.onPaginate, required this.totalSize,
    required this.offset, required this.productView, this.enabledPagination = true, this.reverse = false,
  });

  @override
  State<PaginatedListViewWidget> createState() => _PaginatedListViewWidgetState();
}

class _PaginatedListViewWidgetState extends State<PaginatedListViewWidget> {
  int? _offset;
  late List<int?> _offsetList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();


    _offset = 1;
    _offsetList = [1];

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent
          && widget.totalSize != null && !_isLoading && widget.enabledPagination) {
        if(mounted && !ResponsiveHelper.isDesktop(context)) {
          _paginate();
          debugPrint('Paginate called: offset=$_offset, isLoading=$_isLoading');
        }
      }
    });
  }

  void _paginate() async {

    if (_isLoading) return;

    int pageSize = (widget.totalSize! / 10).ceil();
    if (_offset! < pageSize && !_offsetList.contains(_offset!+1)) {
      setState(() {
        _offset = _offset! + 1;
        _offsetList.add(_offset);
        _isLoading = true;
      });
      try {
        await widget.onPaginate(_offset);
      } catch (e) {
        // Handle errors gracefully
        debugPrint('Pagination error: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }else {
      if(_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.offset != null) {
      _offset = widget.offset;
      _offsetList = [];
      for(int index=1; index<=widget.offset!; index++) {
        _offsetList.add(index);
      }
    }

    return SingleChildScrollView(
      child: Column(children: [

        widget.reverse ? const SizedBox() : widget.productView,

        (ResponsiveHelper.isDesktop(context) && (widget.totalSize == null )) ? const SizedBox() : Center(child: Padding(
          padding: (_isLoading || ResponsiveHelper.isDesktop(context)) ? const EdgeInsets.all(Dimensions.paddingSizeSmall) : EdgeInsets.zero,
          child: _isLoading ? const CircularProgressIndicator() : InkWell(
            onTap: _isLoading ? null : _paginate,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
              margin: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.only(top: Dimensions.paddingSizeSmall) : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: _isLoading ? Colors.grey : Theme.of(context).primaryColor,
              ),
              child: Text('view_more'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
            ),
          )
        )),

        widget.reverse ? widget.productView : const SizedBox(),

      ]),
    );
  }
}
