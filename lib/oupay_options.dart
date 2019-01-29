//支付参数
class OupayOptions{
  //银联
  bool _isSandboxByUn;
  String _unpayId;
  //支付宝
  bool _isSandboxByAli;
  String _alipayId;
  //微信
  bool _isSandboxByWechat;
  String _wechatId;
  //招行一网通
  bool _isSandboxByCmb;
  String _cmbAppId;

  OupayOptions({bool isSandboxByUn:false,String unpayId:'unionpayappid',
    bool isSandboxByAli:false,String alipayId:'alipayappid',
    bool isSandboxByWechat:false, String wechatId:'wxappid',
    bool isSandboxByCmb:false,String cmbAppId:'cmbappid'
    }){

    this._isSandboxByUn = isSandboxByUn;
    this._unpayId = unpayId;

    this._isSandboxByAli = isSandboxByAli;
    this._alipayId = alipayId;

    this._isSandboxByWechat = isSandboxByWechat;
    this._wechatId = wechatId;

    this._isSandboxByCmb = isSandboxByCmb;
    this._cmbAppId = cmbAppId;
  }

  String get wechatId => _wechatId;

  bool get isSandboxByWechat => _isSandboxByWechat;

  String get alipayId => _alipayId;

  bool get isSandboxByAli => _isSandboxByAli;

  String get unpayId => _unpayId;

  bool get isSandboxByUn => _isSandboxByUn;

  String get cmbAppId => _cmbAppId;

  bool get isSanboxByCmb => _isSandboxByCmb;


}