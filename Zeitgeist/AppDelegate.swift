import UIKit
import CoreData
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   let appStore = Store<AppState>(reducer: AppState.reducer, state: nil, middleware: [loggingMiddleware])
   var triggerManager: TriggerManager!


   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
   {
      triggerManager = TriggerManager(store: appStore)
      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      DBAccess.shared.save()
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
   }

   func applicationWillTerminate(_ application: UIApplication) {
      DBAccess.shared.save()
   }
}

