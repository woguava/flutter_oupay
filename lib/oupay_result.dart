/**
 * 返回支付结果
 */
class  OupayResult{
  /**
   * 返回码:
   *  (0 支付成功 -1 失败 -2 用户取消)
   */
  int retCode;

  /**
   * 错误原因
   */
  String retMsg;

  /**
   * 支付渠道:
   * (11:银联；12：支付宝；13：微信；14：招行 )
   * (unpay ,alipay, wechatpay, cmbchina)
   */
  String payChannel;

  /**
   * 支付渠道返回具体内容
   */
  dynamic channelData;

  void setOupayRest(int retCode,String retMsg,{String payChannel,dynamic channelData}){
    this.retCode = retCode;
    this.retMsg = retMsg;
    this.payChannel = payChannel;
    this.channelData = channelData;
  }

  @override
  String toString(){
     String result = '{retCode:$retCode,retMsg:$retMsg,payChannel:$payChannel,channelData:$channelData}';
     return result;
  }
}