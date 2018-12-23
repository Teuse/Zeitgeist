
import ReSwift
import UIKit

extension UIViewController
{
   //   typealias StoreSubscriberStateType = AppState

   var store: Store<AppState> {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return appDelegate.appStore
   }

   func dispatch(action: Action)
   {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.dispatch(action)
   }

   func dispatch(action: Action?)
   {
      if let action = action {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         appDelegate.appStore.dispatch(action)
      }
   }

   func subscribe<S: StoreSubscriber>(_ vc: S)
   {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.subscribe(vc, transform: nil)
   }

   func subscribe<SelectedState, S: StoreSubscriber>(
      _ vc: S, transform: ((Subscription<AppState>) -> Subscription<SelectedState>)?
      ) where S.StoreSubscriberStateType == SelectedState
   {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.subscribe(vc, transform: transform)
   }

   func unsubscribe(_ vc: AnyStoreSubscriber)
   {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.appStore.unsubscribe(vc)
   }
}
