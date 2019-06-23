import ReSwift

struct CalendarState: StateType, Codable
{
   var records: [Record] {
      return DBAccess.shared.getRecords()
   }
   
   var selectedRecord: Record? {
      return DBAccess.shared.getToday()
   }
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension CalendarState
{
   static func reducer(action: Action, state: CalendarState?) -> CalendarState {
      let state = state ?? CalendarState()

//      switch action {
//      default: break
//      }
      return state
   }
}
