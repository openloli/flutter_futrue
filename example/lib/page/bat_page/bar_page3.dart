import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/base/basestate_custom_dialog.dart';

class BarPage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BarPage3State();
  }
}

class _BarPage3State extends BaseStateForCustomDialog<BarPage3> {


  List<String> modelList = [
    'https://hbimg.huabanimg.com/0d46b9701e17ce479a8f63f9dc1dd1e6f021ff422438b-KKykf2_fw658',
    'https://hbimg.huabanimg.com/da4cb6d7b843f797768414f0fea7d2816e30b8fd23b1b-j9Z4Mf_fw658',
    'https://hbimg.huabanimg.com/16d62fbfb1ccdcc53b19c8f2db4efad286a3a49524e6c-KlQjpm_fw658',
    'https://hbimg.huabanimg.com/c9a0fe206abf931837a72b9c3de06cfe00cb4a631b04d-UibN9l_fw658',
    'https://hbimg.huabanimg.com/27bc7f6f9ec39a5a5b40fe6686780bbf3b0243ef5cd4f-T52IR1_fw658',
    'https://hbimg.huabanimg.com/b9bdc7d686dd26b40450cfefbca0cc41506222087442a-cK7Lwb_fw658',
    'https://hbimg.huabanimg.com/8d53c6e055cf23816807545e80e1668ddb52e6c4af39-fggKzE_fw658',
    'https://hbimg.huabanimg.com/e893f514d2e5888f2c54f5ffa8abdf6e451891f94ec06-nc9EG9_fw658',
    'https://hbimg.huabanimg.com/6973ec3a2862c7aca08a3daf78e20cea1765620311a53-U5BEgn_fw658',
    'https://hbimg.huabanimg.com/8b5aced59f0b60077161ceef5e308608d22b3e885421-fcmwPe_fw658',
    'https://hbimg.huabanimg.com/6b1388233122d515a9fe463d80cbe831700f885925f41-4HbUFo_fw658',
    'https://hbimg.huabanimg.com/9bbbd20cb579520b8a77adcbfe6d9a01e0925ae21f5bf-03cuQS_fw658',
    'https://hbimg.huabanimg.com/6f44508ec6fbb72e61ad24779df27f7230ef9f1d16d42-rulRIQ_fw658',
    'https://hbimg.huabanimg.com/33f83e5bd160fd89bbd18585bfec9ec599b7ca2a36ac8-HdSfpZ_fw658',
    'https://hbimg.huabanimg.com/9048055aa4926073d30fb948d7bd0bd8606af8b41bd0e-7EfWe4_fw658',
    'https://hbimg.huabanimg.com/4b5eb4b68fc951c617f613522b127acb6ec6efa71ec45-YZT3ih_fw658',
    'https://hbimg.huabanimg.com/68acddefc2f95c4966aead0cf062f8b59c8ce7cdeca5-bzswqt_fw658',
    'https://hbimg.huabanimg.com/0a1cbf43efaa2130c36f2396a5e5c6e46db83ec726fdb-h30HQ0_fw658',
    'https://hbimg.huabanimg.com/ee5dc27b7bd870bf23556fa277f4ffca090641bb1ba56-AUUraS_fw658',
    'https://hbimg.huabanimg.com/41c59132d332e65ca3497f52538e6835fe04b96d66125-JhdKaE_fw658',
    'https://hbimg.huabanimg.com/8bac245c2dcdb321527a946068c27d2522f051ef1129f-LS7Nlu_fw658',
    'https://hbimg.huabanimg.com/b6c8c939810d2fe41dba3cef261299acca34039515b02-WqMvbU_fw658',
  ];

  @override
  buildBody() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
      itemCount: modelList.length,
      itemBuilder: (context, i) {
        String itemBean = modelList[i];
        return new Material(
          elevation: 4.0,

          borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
          child: new InkWell(
              onTap: () {

              },
              child:
              new Container(
                alignment: Alignment.center,
                child: CachedNetworkImage(imageUrl: itemBean),
              )
          ),
        );
      },
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        crossAxisCount: 2,
      ),
    );
  }

//  @override
//  Future<dynamic> onRefresh() {
//    return SimpleDao.login();
//  }
//
//  @override
//  Future<dynamic> onLoading() {
//    return SimpleDao.login6();
//  }

  @override
  void useNetData(Object data) {
    print('SimplePage1 useNetData $data');
  }
}

