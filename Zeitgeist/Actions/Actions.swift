import Foundation
import ReSwift


struct StartAction: Action {
}

struct StopAction: Action {
}

struct WeekdayAction: Action {
  let weekday: Weekday
  let selected: Bool
}
