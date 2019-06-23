import ReSwift

struct RecordingState: StateType, Codable
{
   var animationToggle = false
   
   var record: Record? {
      return DBAccess.shared.getToday()
   }
   
   var isStarted: Bool {
      return record != nil
   }
   
   var isPaused: Bool {
      return false
   }
}

// --------------------------------------------------------------------------------
//MARK: - Reducer

extension RecordingState
{
   static func reducer(action: Action, state: RecordingState?) -> RecordingState {
      var state = state ?? RecordingState()

      switch action {
      case is RecordingActions.Start:
         handleStart(&state)
      case is RecordingActions.Stop:
         handleStop(&state)
      case is RecordingActions.StartPause:
         handlePause(true, &state)
      case is RecordingActions.StopPause:
         handlePause(false, &state)
      case is RecordingActions.AddVacationDay:
         handleVacation(&state)
      case is RecordingActions.AddSicknessDay:
         handleSickness(&state)
      case is RecordingActions.RunAnimation:
         state.animationToggle = !state.animationToggle
      default: break
      }
      return state
   }

   static func handleStart(_ state: inout RecordingState)
   {
      let today = state.record
      assert(today == nil, "An existing record is always started!")
      if today == nil {
         _ = DBAccess.shared.createRecord()
      }
   }

   static func handleStop(_ state: inout RecordingState)
   {
      guard let today = state.record else {
         assertionFailure("StopAction failed: TodayRecord doesn't exist!")
         return
      }
      today.end = Date()
      state.animationToggle = !state.animationToggle
   }
   
   static func handlePause(_ isStart: Bool, _ state: inout RecordingState)
   {
      
   }
   
   static func handleVacation(_ state: inout RecordingState)
   {
      let today = state.record
      assert(today == nil, "An existing record is always started!")
      if today == nil {
         let rec = DBAccess.shared.createRecord()
         rec.type = .vacation
         rec.end = rec.begin
         state.animationToggle = !state.animationToggle
      }
   }
   
   static func handleSickness(_ state: inout RecordingState)
   {
      let today = state.record
      assert(today == nil, "An existing record is always started!")
      if today == nil {
         let rec = DBAccess.shared.createRecord()
         rec.type = .sickness
         rec.end = rec.begin
         state.animationToggle = !state.animationToggle
      }
   }
}
