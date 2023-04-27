import UIKit
import Flutter
import BenefitInAppSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
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
            self.checkOut(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    })
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func checkOut(result: FlutterResult){
        result("Success")
        result(FlutterError(code: "Fail", message: "", details: nil))
    }
}
