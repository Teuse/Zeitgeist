import Foundation
import ReSwift


struct TimeTriggerActions
{
  struct SetStartTime: Action {
    let time: Time
  }
  struct SetEndTime: Action {
    let time: Time
  }
}
