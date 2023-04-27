import UIKit
import Flutter
import BenefitInAppSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, BPInAppButtonDelegate{
    
    var amount = "1.0"
    var reference = "9898977"
    
    var bpButton: BPInAppButton!

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let methodChannel = FlutterMethodChannel(name: "ummatisoftwares.benefitpay", binaryMessenger: controller.binaryMessenger)
      
      methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        switch call.method {
          case "BenefitPay":
            
            guard let args = call.arguments as? [String : Any] else {return}
            self.amount = args["amount"] as! String
            self.reference = args["reference"] as! String
            
            self.checkOut(result: result)

            
//            self.bpButton = BPInAppButton(frame: CGRect(x: 0, y: 0, width: 258, height: 60))
//
//            self.bpButton.delegate = self
//
//            if let window = UIApplication.shared.keyWindow {
//                window.addSubview(self.bpButton)
//            }
//
//            self.bpButton.sendActions(for: .touchUpInside)
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func bpInAppConfiguration() -> BPInAppConfiguration {
        let configuration = BPInAppConfiguration(appId: "3253656030", andSecretKey: "4nt1zva9cb61ru59mbms5lole719b5a57a79fxpnt9ad9", andAmount: amount, andCurrencyCode: "048", andMerchantId: "004957102", andMerchantName: "DELIVER X", andMerchantCity: "Manama", andCountryCode: "BH", andMerchantCategoryId: "4215", andReferenceId: reference, andCallBackTag: "ummati.benefit")
        return configuration!
    }
    
    private func checkOut(result: FlutterResult){
        result("Success")
        result(FlutterError(code: "Fail", message: "", details: nil))
    }
}
