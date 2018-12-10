import ReSwift

struct AppState: StateType
{
    var triggerState = TriggerState()
    
    var currentRecord: Record? {
        return DBAccess.shared.getToday()
    }
    
    // --------------------------------------------------------------------------------
    
    static func reducer(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        state.triggerState = TriggerState.reducer(action: action, state: state.triggerState)
        
        switch action {
//        case is ReSwiftInit:
        case is StartAction:
            handleStart(&state)
        case is StopAction:
            handleStop(&state)
        default: break
        }
        return state
    }
    
    static func handleStart(_ state: inout AppState)
    {
        let today = state.currentRecord
        if today == nil {
            _ = DBAccess.shared.createRecord()
        }
    }

    static func handleStop(_ state: inout AppState)
    {
        guard let today = state.currentRecord else {
            assertionFailure("StopAction failed: TodayRecord doesn't exist!")
            return
        }
        today.end = Date()
    }
}
