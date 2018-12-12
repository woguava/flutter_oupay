class OupayOptions{
  bool isSandbox = false;
  String unpayId;
  String alipayId;
  String wechatId;
  String cmbchinaId;

  OupayOptions({bool isSandbox,
    String unpayId,
    String alipayId,
    String wechatId,
    String cmbchinaId}){
    this.isSandbox = isSandbox;
    this.unpayId = unpayId;
    this.alipayId = alipayId;
    this.wechatId = wechatId;
    this.cmbchinaId = cmbchinaId;
  }
  void setOptions({bool isSandbox,String unpayId,String alipayId,String wechatId,String cmbchinaId}){
    this.isSandbox = isSandbox;
    this.unpayId = unpayId;
    this.alipayId = alipayId;
    this.wechatId = wechatId;
    this.cmbchinaId = cmbchinaId;
  }
}