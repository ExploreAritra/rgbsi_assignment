import UIKit
import Flutter
import CoreBluetooth
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CBCentralManagerDelegate, FlutterStreamHandler {
    
    
    private var centralManager: CBCentralManager?
    var controller : FlutterViewController!
    var methodChannel : FlutterMethodChannel!
    var eventChannel : FlutterEventChannel!
    var events : FlutterEventSink!
    var result : FlutterResult!
    var stateWhileInBackground : Bool!
    var messageWhileInBackground : String!
    var isAppInBackground : Bool = false
    var bgTask: UIBackgroundTaskIdentifier = .invalid
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        controller = window?.rootViewController as? FlutterViewController
        
        methodChannel = FlutterMethodChannel(name: "assignment/bluetooth",
                                             binaryMessenger: controller as! FlutterBinaryMessenger)
        eventChannel = FlutterEventChannel(name: "assignment/bluetoothStatus", binaryMessenger: controller as! FlutterBinaryMessenger)
        eventChannel.setStreamHandler(self)
      
        
        methodChannel.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                self.result = result
              if ("turnOnBluetooth" == call.method) {
                  
                  self.centralManager = nil
                self.changeBluetoothStatusDialog(result: result, shouldEnable: true)
              } else if ("turnOffBluetooth" == call.method) {
                  
                  self.centralManager = nil
                self.changeBluetoothStatusDialog(result: result, shouldEnable: false)
              } else {
                result(FlutterMethodNotImplemented)
              }
            })
        
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        centralManager = CBCentralManager(delegate: self, queue: .main)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.events = nil
        return nil
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("received bluetooth update callback: \(central.state)")
        DispatchQueue.main.async {
            switch central.state {
                case .unsupported:
    //                print("Bluetooth is not supported")
                self.updateEvent(message: "Bluetooth is not supported")
                case .unauthorized:
    //                print("Bluetooth is not authorized")
                self.updateEvent(message: "Bluetooth is not authorized")
                case .unknown:
    //                print("Bluetooth status is unknown")
                self.updateEvent(message: "Bluetooth status is unknown")
                case .resetting:
    //                print("Bluetooth is resetting")
                self.updateEvent(message: "Bluetooth is resetting")
                case .poweredOff:
    //                print("Bluetooth is powered off")
                self.updateEvent(message: "Bluetooth is powered off")
                case .poweredOn:
    //                print("Bluetooth is turned on and available")
                self.updateEvent(message: "Bluetooth is turned on and available")
                @unknown default:
                    fatalError()
            }
            }
        
    }
    
    func updateEvent(message: String) {
//        print("update event started")
        if(isAppInBackground) {
//            print("update event stored for app to come in foreground")
            messageWhileInBackground = message;
        } else {
//            print("update event sent to flutter")
            self.events(message)
        }
//        print("update event completed successfully")
    }
    
    func updateState(state: Bool) {
        if(isAppInBackground) {
            stateWhileInBackground = state;
        } else {
            self.result(state)
        }
    }
    
    private func changeBluetoothStatusDialog(result: @escaping FlutterResult, shouldEnable: Bool) {
        AppDelegate.openBluetoothDialogueBox(action: shouldEnable ? "On" : "Off")
//        AppDelegate.openBluetoothSettings { isSuccess in
//                if isSuccess == false {
////                    print("Error opening Settings")
//                    self.updateState(state: false)
//                } else {
//                    if(shouldEnable) {
////                        print("Please enable bluetooth from settings")
//                        self.updateState(state: true)
//                    } else {
////                        print("Please disable bluetooth from settings")
//                        self.updateState(state: true)
//                    }
//                }
//           }
        
      }
    
    
    override func applicationWillEnterForeground(_ application: UIApplication) {

        if let lastState = UserDefaults.standard.string(forKey: "lastState") {
            if lastState == "background" {
                // Came to foreground from background
                isAppInBackground = false;
//                print("App came from background to foreground")
                if(messageWhileInBackground != nil) {
                    self.events(messageWhileInBackground)
                }
                if(stateWhileInBackground != nil) {
                    self.result(stateWhileInBackground)
                }
                
            }
        }
        
        UserDefaults.standard.set("foreground", forKey: "lastState")
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        print("App in background!")
        isAppInBackground = true
        UserDefaults.standard.set("background", forKey: "lastState")
        
        // Perform background tasks
    }

}


extension AppDelegate {
    
    static func openBluetoothDialogueBox(action: String) {
        let alert = UIAlertController(title: "Bluetooth", message: "Please go to Settings > Bluetooth to turn it \(action).", preferredStyle: .alert)
                
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)

        var rootViewController = UIApplication.shared.keyWindow?.rootViewController

        while let presentedViewController = rootViewController?.presentedViewController {
            rootViewController = presentedViewController
        }

        rootViewController?.present(alert, animated: true, completion: nil)
    }

    static func openBluetoothSettings(_ sender: Any) {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
