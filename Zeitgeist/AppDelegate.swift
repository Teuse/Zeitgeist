import UIKit
import CoreData
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var appStore: Store<AppState>!
   var triggerManager: TriggerManager!


   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
   {
      if launchOptions?[.location] != nil {
         print("Application launched by CoreLocation")
      }

      let state = load()
      appStore = Store<AppState>(reducer: AppState.reducer, state: state, middleware: [loggingMiddleware])

      triggerManager = TriggerManager(store: appStore)
      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      DBAccess.shared.save()
      save()
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
   }

   func applicationWillTerminate(_ application: UIApplication) {
      DBAccess.shared.save()
      save()
   }

   private var appStatePath: URL {
      let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      return docDir.appendingPathComponent("AppState.json")
   }

   private func save()
   {
      do {
         let payload: Data = try JSONEncoder().encode(appStore.state)
         try payload.write(to: appStatePath, options: .atomic)
      }
      catch {
         print("SessionFiles::saveSession: Failed to save Session to path \(appStatePath) with error \(error.localizedDescription)")
      }
   }

   private func load() -> AppState?
   {
      do {
         let payload = try Data(contentsOf: appStatePath)
         return try JSONDecoder().decode(AppState.self, from: payload)
      }
      catch {
         print("SessionFiles::loadSession: Failed to load Session at path \(appStatePath) with error \(error.localizedDescription)")
      }
      return nil
   }
}

