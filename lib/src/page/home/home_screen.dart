import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_app_hotel/src/configs/constants/app_space.dart';
import 'package:web_app_hotel/src/configs/constants/constants.dart';
import 'package:web_app_hotel/src/configs/widget/form_field/app_form_field.dart';
import 'package:web_app_hotel/src/configs/widget/text/paragraph.dart';
import 'package:web_app_hotel/src/resource/model/time_model.dart';
import 'package:web_app_hotel/src/utils/app_valid.dart';
import 'package:web_app_hotel/src/utils/date_format_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/button/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectButton = 0;
  int selectDate=0;
  int selectTime=-1;

  late TextEditingController noteController;
  late TextEditingController serviceController;
  late TextEditingController amountOfPeopleController;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late DateTime dateTime;

  String? messageService;
  String? messagePhone;
  String? messageName;

  bool isEnableButton = false;

  List<TimeModel> listTimeModel = [
    TimeModel(status: 'Còn chỗ', time: '09:00'),
    TimeModel(status: 'Còn chỗ', time: '09:30'),
    TimeModel(status: 'Còn chỗ', time: '10:00'),
    TimeModel(status: 'Còn chỗ', time: '10:30'),
    TimeModel(status: 'Còn chỗ', time: '11:00'),
    TimeModel(status: 'Còn chỗ', time: '11:30'),
    TimeModel(status: 'Còn chỗ', time: '12:00'),
    TimeModel(status: 'Còn chỗ', time: '12:30'),
    TimeModel(status: 'Còn chỗ', time: '13:00'),
    TimeModel(status: 'Còn chỗ', time: '13:30'),
    TimeModel(status: 'Còn chỗ', time: '14:00'),
    TimeModel(status: 'Còn chỗ', time: '14:30'),
    TimeModel(status: 'Còn chỗ', time: '15:00'),
    TimeModel(status: 'Còn chỗ', time: '15:30'),
    TimeModel(status: 'Còn chỗ', time: '16:00'),
    TimeModel(status: 'Còn chỗ', time: '16:30'),
    TimeModel(status: 'Còn chỗ', time: '17:00'),
    TimeModel(status: 'Còn chỗ', time: '17:30'),
    TimeModel(status: 'Còn chỗ', time: '18:00'),
    TimeModel(status: 'Còn chỗ', time: '18:30'),
    TimeModel(status: 'Còn chỗ', time: '19:00'),
    TimeModel(status: 'Còn chỗ', time: '19:30'),
  ];

  Timer? timer;

  bool isShowFieldPeople=false;


  @override
  void initState() {
    super.initState();
    if (mounted) {
      noteController = TextEditingController();
      serviceController = TextEditingController();
      phoneController= TextEditingController();
      nameController= TextEditingController();
      amountOfPeopleController= TextEditingController();
      dateTime = DateTime.now();
      timer = Timer.periodic(
          const Duration(seconds: 2), (Timer t) => setState(() {}));
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> openWebView(String url) async{
    if(!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)){
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: buildAppBar(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: AppColors.BLACK_200,
                ),
                buildFormInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(){
    return Row(
      children: [
        const CircleAvatar(
          radius: 50,
        ),
        buildContentAppBar(),
      ],
    );
  }

  Widget buildContentAppBar(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeBig),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Paragraph(
            content: 'Hotel App',
            style: STYLE_VERY_BIG.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.COLOR_TEAL
            ),
          ),
          buildContentRichText(
            icon: Icons.alarm,
            content: '09:00 - 22:00',
            title:  'Giờ mở cửa: ',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeVeryVerySmall),
            child: buildContentRichText(
              icon: Icons.phone_iphone,
              content: '012345671',
              title:  'Điện thoại: ',
            ),
          ),
          buildContentRichText(
            icon: Icons.facebook,
            content: 'https://nicebarbershop.salonhero.vn/dat-lich?fbclid=IwAR0UrEELP9Sht3W_md1jRYETXUcrXz_Anf5trbPUk6DJgr4Q1bUaz1jBEPY',
            title:  'Facebook: ',
            isLaunch: true
          ),
        ],
      ),
    );
  }

  Widget buildContentRichText({IconData? icon, String? title, String? content, bool isLaunch=false}){
    return Row(
      children: [
        Icon(icon, size: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title??'',
                  style: STYLE_SMALL.copyWith(
                    color: AppColors.BLACK_500
                  )
                ),
                TextSpan(
                  text: content??'',
                  style: STYLE_SMALL.copyWith(
                    color: AppColors.COLOR_TEAL
                  ),
                  recognizer: isLaunch==false? null: TapGestureRecognizer()?..onTap = () {
                    openWebView(content??'');
                  },
                )
              ]
            )
          ),
        )
      ],
    );
  }

  Widget buildTitleInput(String title){
    return Padding(
      padding: EdgeInsets.only(bottom: SizeToPadding.sizeSmall,),
      child: Paragraph(
        content: title,
        style: STYLE_SMALL.copyWith(
          color: AppColors.COLOR_TEAL,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  Widget buildFormInput() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeToPadding.sizeMedium,
        horizontal: 250
      ),
      padding: EdgeInsets.only(
        bottom: SizeToPadding.sizeVeryBig,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleInput('Quý khách vui lòng cho biết thông tin'),
          buildFieldPhone(),
          buildFieldName(),
          buildFieldAmountOfPeople(),
          buildTitleInput('Thông tin dịch vụ'),
          buildDateBook(),
          buildChooseDate(),
          buildChooseTime(),
          buildFieldService(),
          buildFieldNoteCard(),
          // buildChooseDate(),
          buildButtonCard(),
        ],
      ),
    );
  }

  Widget buildFieldPhone(){
    return AppFormField(
      validator: messagePhone,
      textEditingController: phoneController,
      keyboardType: TextInputType.phone,
      hintText: 'Enter phone',
      onChanged: (value) async {
        await validPhone(value);
        await onEnableButton();
      },
    );
  }

   Widget buildFieldName(){
    return AppFormField(
      validator: messageName,
      textEditingController: nameController,
      hintText: 'Enter Name',
      onChanged: (value) async {
        await validName(value);
        await onEnableButton();
      },
    );
  }

  Widget buildFieldAmountOfPeople(){
    return Container(
      height: 70,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              isShowFieldPeople=!isShowFieldPeople;
              setState(() { });
            },
            child: Paragraph(
              content: 'Bạn đi theo nhóm?',
              style: STYLE_SMALL.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.PRIMARY_RED,
              ),
            ),
          ),
          Visibility(
            visible: isShowFieldPeople,
            child: Container(
              padding: EdgeInsets.only(left: SizeToPadding.sizeMedium),
              width: MediaQuery.sizeOf(context).width-650,
              child: AppFormField(
                textEditingController: amountOfPeopleController,
                keyboardType: TextInputType.number,
                hintText: 'Enter amount of people',
                onChanged: (value) async {
                  // await validMoney(value);
                  // await onEnableButton();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buildDateBook(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Paragraph(
          content: 'Thời gian đặt lịch: ',
        ),
        Paragraph(
          content: '${getDateTime(dateTime.weekday)}, ${AppDateUtils.formatFromDateTime(dateTime)}',
          style: STYLE_SMALL.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.COLOR_TEAL
          ),
        )
      ],
    );
  }

  Widget buildFieldService() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeSmall),
      child: AppFormField(
        validator: messageService,
        textEditingController: serviceController,
        hintText: 'Chọn dịch vụ',
        onChanged: (value) async {
          // await validMoney(value);
          await onEnableButton();
        },
      ),
    );
  }

  Widget buildFieldNoteCard() {
    return AppFormField(
      textEditingController: noteController,
      hintText: 'Enter Note',
      maxLines: 3,
      onChanged: (value) => onEnableButton(),
    );
  }

  Widget buildChooseDate() {
    DateTime date= DateTime.now();
    DateTime date1= date;
    DateTime date2=date;
    DateTime date3=date;
    int dayOfMonth= DateTime(date.year, date.month+1, 0).day;
    int weekday=  date.weekday;
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeSmall),
      child: Row(
        children: List.generate(3, (index) {
          weekday+= (index==0? 0:1);
          weekday= weekday>7? 1: weekday;
          if(index==1) {
            date2= DateTime((date.day+1)> dayOfMonth && date.month+1>12? date.year+1: date.year, 
            (date.day+1)> dayOfMonth && date.month+1>12? 1: (date.day+1)> dayOfMonth? date.month+1: date.month, 
            (date.day+1)> dayOfMonth? 1: date.day+1);
            date=date2;
          }else if(index==2){
            date3= DateTime(date.month+1>12? date.year+1: date.year, 
              date.month+1>12? 1: (date.day+1)> dayOfMonth? date.month+1: date.month, 
              (date.day+1)> dayOfMonth? 1: date.day+1);
            date=date3;
          }
          return InkWell(
            onTap: () {
              selectDate=index;
              dateTime= index==0? date1: index==1? date2: date3;
              dateTime= selectTime==-1? DateFormat('yyyy-MM-dd HH:mm')
                .parse('${dateTime.toString().split(' ')[0]} ${listTimeModel[selectTime].time}')
                : dateTime;
              setState(() { });
            },
            child: Container(
              width: 230,
              height: 100,
              margin: EdgeInsets.only(left: SizeToPadding.sizeMedium),
              decoration: BoxDecoration(
                color:index==selectDate? AppColors.COLOR_TEAL: AppColors.COLOR_WHITE,
                borderRadius: BorderRadius.circular(BorderRadiusSize.sizeSmall),
                border: Border.all(color: AppColors.COLOR_TEAL)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Paragraph(
                    content: index==0? 'Hôm nay': index==1? 'Ngày mai': 'Ngày kia',
                    style: STYLE_MEDIUM.copyWith(
                      color: index==selectDate? AppColors.COLOR_WHITE: AppColors.BLACK_500
                    ),
                  ),
                  Paragraph(
                    content: getDateTime(weekday),
                    style: STYLE_MEDIUM.copyWith(
                      fontWeight: FontWeight.w600,
                      color: index==selectDate? AppColors.COLOR_WHITE: AppColors.BLACK_500
                    ),
                  ),
                  Paragraph(
                    content: '${date.day}/${date.month}',
                    style: STYLE_MEDIUM.copyWith(
                      color: index==selectDate? AppColors.COLOR_WHITE: AppColors.BLACK_500
                    ),
                  ),
                ],
              ),
            ),
          ); } 
        ),
      ),
    );
  }

  Widget buildChooseTime(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeSmall),
          child: const Paragraph(
            content: 'Chọn khung giờ phục vụ',
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 50
          ), 
          itemCount: listTimeModel.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              selectTime=index;
              dateTime= DateFormat('yyyy-MM-dd HH:mm')
                .parse('${dateTime.toString().split(' ')[0]} ${listTimeModel[index].time}');
              setState(() { });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.COLOR_TEAL),
                color: selectTime==index? AppColors.COLOR_TEAL: AppColors.COLOR_WHITE,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Paragraph(
                    content: listTimeModel[index].time,
                    style: STYLE_SMALL.copyWith(  
                      fontWeight: FontWeight.w600,
                      color: selectTime==index? AppColors.COLOR_WHITE: AppColors.BLACK_500,
                    ),
                  ),
                  Paragraph(
                    content: listTimeModel[index].status,
                    style: STYLE_SMALL.copyWith(
                      color: selectTime==index? AppColors.COLOR_WHITE: AppColors.BLACK_500,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildButtonCard() {
    return AppButton(
      enableButton: isEnableButton,
      content: 'Save',
      onTap: () => onSave(),
    );
  }

  void onSave() {
    
  }

  String getDateTime(int weekday){
    switch (weekday) {
      case 1:
        return 'Thứ 2';
      case 2:
        return 'Thứ 3';
      case 3:
        return 'Thứ 4';
      case 4:
        return 'Thứ 5';
      case 5:
        return 'Thứ 6';
      case 6:
        return 'Thứ 7';
      case 7:
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  Future<void> validPhone(String? value) async {
    final result = AppValid.validatePhoneNumber(value);
    if (result != null) {
      messagePhone = result;
    } else {
      messagePhone = null;
    }
    setState(() {});
  }

  Future<void> validName(String? value) async {
    final result = AppValid.validateName(value);
    if (result != null) {
      messageName = result;
    } else {
      messageName = null;
    }
    setState(() {});
  }

  Future<void> validMoney(String? value) async {
    final result = AppValid.validMoney(value);
    if (result != null) {
      messageService = result;
    } else {
      messageService = null;
    }
    setState(() {});
  }

  Future<void> onEnableButton() async {
    if (serviceController.text == '' || messageService != null 
      || phoneController.text=='' || messagePhone!=null ||
        nameController.text=='' || messageName!=null) {
        isEnableButton = false;
    } else {
      isEnableButton = true;
    }
    
    setState(() {});
  }

  Future<void> clearData() async {
    noteController.text = '';
    serviceController.text = '';
    phoneController.text='';
    dateTime=DateTime.now();
    await onEnableButton();
    setState(() {});
  }

  Future<void> onChangeButtonSelect(int i) async{
    selectButton = i;
    phoneController.clear();
    messagePhone=null;
    await onEnableButton();
    setState(() {});
  }

  Future<void> onShowDatePicker() async{
    final DateTime? picked = await showDatePicker(
      context: context, 
      firstDate: DateTime(1970), 
      lastDate: DateTime(2100),
      initialDate: dateTime,
    );
    if(picked!=null && picked != dateTime){
      dateTime=picked;
      setState(() { });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
