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
            
//            self.checkOut(result: result)
            self.setupBpButton(result: result)
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func setupBpButton(result: @escaping FlutterResult) {
        
        bpButton = BPInAppButton()
        
        if let rootViewController = window?.rootViewController {
            rootViewController.view.addSubview(bpButton)
            bpButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bpButton.centerXAnchor.constraint(equalTo: rootViewController.view.centerXAnchor),
                bpButton.centerYAnchor.constraint(equalTo: rootViewController.view.centerYAnchor),
                bpButton.widthAnchor.constraint(equalToConstant: 200),
                bpButton.heightAnchor.constraint(equalToConstant: 50)
            ])
            bpButton.delegate = self
            
            //bpButton.sendActions(for: .touchUpInside)
                                                
            result("Success")
        }
    }
    
    func bpInAppConfiguration() -> BPInAppConfiguration {
        let configuration = BPInAppConfiguration(appId: "3253656030", andSecretKey: "4nt1zva9cb61ru59mbms5lole719b5a57a79fxpnt9ad9", andAmount: amount, andCurrencyCode: "048", andMerchantId: "004957102", andMerchantName: "DELIVER X", andMerchantCity: "Manama", andCountryCode: "BH", andMerchantCategoryId: "4215", andReferenceId: reference, andCallBackTag: "com.example.benefitTest")
        return configuration!
    }
    
    private func checkOut(result: FlutterResult){
        result("Success")
        result(FlutterError(code: "Fail", message: "", details: nil))
    }
    
}

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    print("hamad")
    print(options)
    let item = BPDLPaymentCallBackItem(deepLinkURL: url)
    print("Payment callback details:")
    print("Status: \(item!.status)")
    print("Merchant Name: \(item!.merchantName ?? "Hamad Merchant")")
    print("Card Number: \(item!.cardNumber ?? "Hamad Card")")
    print("Currency: \(item!.currency ?? "Hamad BHD")")
    print("Currency Code: \(item!.currencyCode ?? "Hamad Code")")
    print("Amount: \(item!.amount ?? "Hamad 0.1")")
    print("Message: \(item!.message ?? "N/A")")
    print("Reference ID: \(item!.referenceId ?? "Hamad Reference")")
    return true
}
