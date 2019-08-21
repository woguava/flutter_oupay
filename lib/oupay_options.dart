//支付参数
class OupayOptions{
  //银联
  bool _isSandboxByUn;
  String _unpayId;
  String _unpayScheme;
  //支付宝
  bool _isSandboxByAli;
  String _alipayId;
  String _aliapyScheme;
  //微信
  bool _isSandboxByWechat;
  String _wechatId;
  String _wechatScheme;
  //招行一网通
  bool _isSandboxByCmb;
  String _cmbAppId;
  String _cmbScheme;

  OupayOptions({bool isSandboxByUn:false,String unpayId:'unionpayappid',String unpayScheme:'unpayScheme',
    bool isSandboxByAli:false,String alipayId:'alipayappid',String aliapyScheme:'aliapyScheme',
    bool isSandboxByWechat:false, String wechatId:'wxappid',String wechatScheme:'wechatScheme',
    bool isSandboxByCmb:false,String cmbAppId:'cmbappid',String cmbScheme:'cmbScheme'
    }){

    this._isSandboxByUn = isSandboxByUn;
    this._unpayId = unpayId;
    this._unpayScheme = unpayScheme;

    this._isSandboxByAli = isSandboxByAli;
    this._alipayId = alipayId;
    this._aliapyScheme = aliapyScheme;

    this._isSandboxByWechat = isSandboxByWechat;
    this._wechatId = wechatId;
    this._wechatScheme = wechatScheme;

    this._isSandboxByCmb = isSandboxByCmb;
    this._cmbAppId = cmbAppId;
    this._cmbScheme = cmbScheme;
  }

  String get wechatId => _wechatId;

  bool get isSandboxByWechat => _isSandboxByWechat;

  String get wechatScheme => _wechatScheme;

  String get alipayId => _alipayId;

  bool get isSandboxByAli => _isSandboxByAli;

  String get alipayScheme => _aliapyScheme;

  String get unpayId => _unpayId;

  bool get isSandboxByUn => _isSandboxByUn;

  String get unpayScheme => _unpayScheme;

  String get cmbAppId => _cmbAppId;

  bool get isSanboxByCmb => _isSandboxByCmb;

  String get cmbScheme => _cmbScheme;


}