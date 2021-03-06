import 'package:demo/Repository/database.dart';
import 'package:demo/Screens/screens.dart';
import 'package:demo/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

class Debtors extends StatefulWidget {
  @override
  _DebtorsState createState() => _DebtorsState();
}

class _DebtorsState extends State<Debtors> {
  @override
  void initState() {
    super.initState();
    getDebtors();
  }

  /*Form keys */
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _formKey2 = GlobalKey();

  /*Text Controllers */
  TextEditingController search = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController debt = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[100],
        title: Text(
          "Madeni App",
          style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
        ),
        elevation: 0.0,
        centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(60.0),
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Expanded(
        //               child: Container(
        //             margin: EdgeInsets.only(left: 12.0, bottom: 18.0),
        //             decoration: BoxDecoration(
        //                 color: Colors.lightGreen[50],
        //                 borderRadius: BorderRadius.circular(24.0)),
        //             child: TextFormField(
        //               controller: search,
        //               decoration: InputDecoration(
        //                   hintText: "Search",
        //                   contentPadding: const EdgeInsets.only(left: 24.0),
        //                   border: InputBorder.none),
        //             ),
        //           )),
        //           Padding(
        //             padding: const EdgeInsets.only(
        //                 right: 0.0, bottom: 18.0, left: 8.0),
        //             child: IconButton(
        //                 icon: Icon(
        //                   Icons.search,
        //                   color: Colors.white,
        //                   size: 28.0,
        //                 ),
        //                 onPressed: () {
        //                   searchW(search.text.toLowerCase());
        //                 }),
        //           )
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 5.0),
          FutureBuilder(
              future: getDebtors(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                /*Checks the snapshot length */
                if (snapshot.data.length == 0 || snapshot.data.length == null) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: Center(
                      child: Text(
                        "No debtors found.",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  );

                  /*Return a listview of the debtors where snapshot length > 0 */
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Debts(
                                          name: "${snapshot.data[index].name}",
                                        ))).then((value) {
                              setState(() {
                                getDebtors();
                              });
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 18.0),
                            child: Container(
                                height: 75.0,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen[50],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(5.0),
                                      topRight: const Radius.circular(5.0),
                                      bottomLeft: const Radius.circular(5.0),
                                      bottomRight: const Radius.circular(5.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green[300],
                                        radius: 20.0,
                                        child: Text(
                                          snapshot.data[index].name[0]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data[index].name
                                                  .toUpperCase(),
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            Text(
                                              "0" +
                                                  snapshot.data[index].phone
                                                      .toUpperCase(),
                                              style: TextStyle(fontSize: 11.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_box,
                                          size: 22.0,
                                          color: Colors.green[300],
                                        ),
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return PlatformAlertDialog(
                                                title: Center(
                                                    child:
                                                        Text('Add New Debt')),
                                                content: SingleChildScrollView(
                                                  child: Form(
                                                    key: _formKey2,
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller: debt,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: "DEBT",
                                                            labelStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Source Sans Pro',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                            .green[
                                                                        300])),
                                                          ),
                                                          validator:
                                                              // ignore: missing_return
                                                              (String value) {
                                                            if (value.isEmpty) {
                                                              return "DEBT field cannot be blank";
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        TextFormField(
                                                          controller: amount,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: "AMOUNT",
                                                            labelStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Source Sans Pro',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .grey[400],
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                            .green[
                                                                        300])),
                                                          ),
                                                          keyboardType:
                                                              TextInputType
                                                                  .phone,
                                                          validator:
                                                              // ignore: missing_return
                                                              (String value) {
                                                            if (value.isEmpty) {
                                                              return "AMOUNT field cannot be blank";
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  PlatformDialogAction(
                                                      child: Text('SUBMIT'),
                                                      actionType:
                                                          ActionType.Preferred,
                                                      onPressed: () {
                                                        /*Validate the form before submission */
                                                        var form2 = _formKey2
                                                            .currentState;

                                                        if (form2.validate()) {
                                                          /*Gets the current timestamp */
                                                          var now =
                                                              DateTime.now();
                                                          var timestamp =
                                                              DateFormat
                                                                      .yMMMEd()
                                                                  .format(now);

                                                          /*Initializes new debt data */
                                                          var newDebt = Debt(
                                                            name: snapshot
                                                                .data[index]
                                                                .name
                                                                .toLowerCase(),
                                                            debt: debt.text,
                                                            amount: amount.text,
                                                            timestamp:
                                                                timestamp,
                                                          );

                                                          /*Inserts new debt to db */
                                                          insertDebt(newDebt);
                                                          /*Updates payment records for debtor */
                                                          updatePayment(snapshot
                                                              .data[index]
                                                              .name);

                                                          /*Returns to the debtors screen */
                                                          Navigator.pop(
                                                              context);

                                                          /*Clears textform fields */
                                                          debt.clear();
                                                          amount.clear();
                                                        }
                                                      }),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(height: 50.0),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Add debtor"),
          backgroundColor: Colors.green[300],
          tooltip: 'Add new debtor',
          icon: Icon(
            Icons.add_circle,
            size: 30.0,
          ),
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return PlatformAlertDialog(
                  title: Center(child: Text('Add New Debtor')),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: "NAME",
                              labelStyle: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green[300])),
                            ),
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "NAME field cannot be blank";
                              }
                            },
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: phone,
                            decoration: InputDecoration(
                              labelText: "PHONE",
                              labelStyle: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green[300])),
                            ),
                            keyboardType: TextInputType.phone,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "PHONE field cannot be blank";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: Text('SUBMIT'),
                      actionType: ActionType.Preferred,
                      onPressed: () {
                        var form = _formKey.currentState;
                        if (form.validate()) {
                          /*Initializes new debtor data */
                          var newDebtor = Debtor(
                            name: name.text.toLowerCase(),
                            phone: phone.text,
                          );

                          /*Inserts new debtor to db */
                          insertDebtor(newDebtor);

                          /*initializes new payment record data for debtor */
                          var newPayment = Payment(
                            name: name.text,
                            total: 0,
                            paid: 0,
                          );

                          /*Inserts new payment record for debtor to db */
                          insertPayment(newPayment);

                          /*Returns to the debtors screen */
                          Navigator.of(context).pop();
                          setState(() {
                            getDebtors();
                          });

                          /*Clears textform fields */
                          name.clear();
                          phone.clear();
                        }
                      },
                    ),
                    PlatformDialogAction(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                );
              },
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
