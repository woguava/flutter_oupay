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

  OupayOptions({bool isSandboxByUn:false,String unpayId:'unionpayappid',
    bool isSandboxByAli:false,String alipayId:'alipayappid',
    bool isSandboxByWechat:false, String wechatId:'wxappid'
  }){

    this._isSandboxByUn = isSandboxByUn;
    this._unpayId = unpayId;

    this._isSandboxByAli = isSandboxByAli;
    this._alipayId = alipayId;

    this._isSandboxByWechat = isSandboxByWechat;
    this._wechatId = wechatId;
  }

  String get wechatId => _wechatId;

  bool get isSandboxByWechat => _isSandboxByWechat;

  String get alipayId => _alipayId;

  bool get isSandboxByAli => _isSandboxByAli;

  String get unpayId => _unpayId;

  bool get isSandboxByUn => _isSandboxByUn;


}
