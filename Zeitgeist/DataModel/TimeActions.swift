import Foundation
import ReSwift

struct TimeActions
{
   struct EnableTrigger: Action {
      let enabled: Bool
   }
   
   struct SetStartTime: Action {
      let time: Time
   }
   
   struct SetEndTime: Action {
      let time: Time
   }
   
   struct SelectRepeat: Action {
      let weekday: Weekday
      let selected: Bool
   }
}
