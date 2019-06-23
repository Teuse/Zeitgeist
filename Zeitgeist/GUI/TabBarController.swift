import UIKit
import ReSwift

class TabBarController: UITabBarController
{
   var animationState = false
   var isAnimating = false
   var calendarImageView: UIImageView!
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   private func runAnimation()
   {
      guard isAnimating else { return }
      isAnimating = true
      
      animateCalendarIcon() { _ in
         self.animateCalendarIcon() { _ in
            self.animateCalendarIcon()
         }
      }
      
      isAnimating = false
   }
   
   private func animateCalendarIcon(blubb: ((Bool) -> Void)? = nil)
   {
      print("blub")
      let dur = 2.0
      let icon = tabBar.subviews[2]
      UIView.animate(withDuration: dur ,animations: {
         icon.transform = CGAffineTransform(scaleX: 2, y: 2)
      }) { (success) in
         
         UIView.animate(withDuration: dur ,animations: {
            icon.transform = CGAffineTransform(scaleX: 1, y: 1)
         }) { (success) in
            blubb?(success)
         }
         
      }
   }
}

extension TabBarController: StoreSubscriber
{
   func newState(state: AppState)
   {
      if state.recordingState.animationToggle != animationState
      {
         animationState = state.recordingState.animationToggle
         animateCalendarIcon()
      }
   }
}
