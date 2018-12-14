import Foundation
import ReSwift


struct ToggleSelectionViewAction: Action {
  let isStartTime: Bool
}

struct StartTimeAction: Action {
  let timeFrame: TimeFrame
}

struct EndTimeAction: Action {
  let timeFrame: TimeFrame
}
