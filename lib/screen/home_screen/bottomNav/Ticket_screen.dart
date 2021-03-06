import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:midesk/model/home/ticket/list_ticket_model.dart';
import 'package:midesk/screen/home_screen/ticket/screen_newTicket.dart';
import 'package:midesk/screen/home_screen/widget_item/item_ticket.dart';

import '../../../bloc/ticket_bloc/ticket_bloc.dart';
import '../../../network/api_provider/api_provider.dart';
import '../widget_item/item_dropdown.dart';

class TicketScreen extends StatefulWidget {
  int? page;
  TicketScreen({
    Key? key,
    this.page,
  }) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  var api = ApiProvider();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    BlocProvider.of<TicketBloc>(context).add(onLoadingTicket());
  }

// ignore: prefer_typing_uninitialized_variables
  var size, width, height;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewTicketScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.greenAccent,
        ),
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget builLoading() {
    return Container(
      padding: EdgeInsets.only(left: 150.0),
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Text(
              'Tất cả phiếu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            )),
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icon/filter-home.svg',
                width: 20.0,
                height: 20.0,
              )),
        )
      ]),
    );
  }

  Widget _buildBody(BuildContext ctt) {
    return BlocBuilder<TicketBloc, TicketState>(
      builder: (ctt, state) {
        if (state is TicketInitial) {
          return const CircularProgressIndicator();
        } else if (state is TicketLoaded) {
          return buildItem(
            ctt,
          );
          // return FutureBuilder<ListTicket>(
          //     future: api.getAllTicket(),
          //     builder: (ctx, snapshot) {
          //       if (!snapshot.hasData) {
          //         return Stack(
          //           children: [
          //             builLoading(),
          //             Center(
          //               child: CircularProgressIndicator(
          //                 color: Colors.red,
          //               ),
          //             ),
          //           ],
          //         );
          //         // return (Column(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   children: const [
          //         //     Center(
          //         //       child: CircularProgressIndicator(
          //         //         color: Colors.red,
          //         //       ),
          //         //     ),
          //         //     Text('Loadingg...')
          //         //   ],
          //         // ));
          //       } else {
          //         final ListTicket? tickets = snapshot.data;
          //         return SafeArea(
          //           child: buildItem(ctx, tickets!),
          //         );
          //       }
          //     });
        } else {
          return Text('data ticket error');
        }
      },
    );
  }

  Widget buildItem(BuildContext context) {
    //,(BuildContext context,ListTicket tickets)
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 150.0,
              ),
              Expanded(flex: 2, child: Item_DropDown(value: '')),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      Item_DropDown(value: 'null');
                    },
                    icon: SvgPicture.asset(
                      'assets/icon/filter-home.svg',
                      width: 20.0,
                      height: 20.0,
                    )),
              )
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Nhân viên phụ trách: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Phạm văn A'),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ItemTicket(
                  callback: () {},
                  title: 'Tin nhắn từ Facebook',
                  description: 'description',
                  dateTime: 'dateTime',
                  id: '123',
                  status: 'new',
                  sdt: '01234567',
                );
              },
              itemCount: 40,
            ),
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return ItemTicket(
            //       title: '${tickets.data![index].title}',
            //       description: '${tickets.data![index].requester}',
            //       dateTime: '${tickets.data![index].datecreate}',
            //       id: '${tickets.data![index].ticket_id}',
            //       status: '${tickets.data![index].status}',
            //       sdt: '${tickets.data![index].channel}',
            //     );
            //   },
            //   itemCount: tickets.data!.length,
            // ),
          ),
        ],
      ),
    );
  }
}
