import ReSwift



struct LocationTrigger {
    var enabled = false
    var startTime = Time()
    var endTime = Time()
    var region: Int = 0
}

struct TimeTrigger {
    var enabled = false
    var time = Time()
}

// --------------------------------------------------------------------------------

struct TriggerState: StateType
{
    var startLocationTigger = LocationTrigger()
    var endLocationTrigger = LocationTrigger()
    let locationService = LocationTriggerProcessor()

    var startTimeTrigger = TimeTrigger()
    var endTimeTrigger = TimeTrigger()
    let timeService = TimeTriggerProcessor() {
        print("blub")
    }
    
    
    static func reducer(action: Action, state: TriggerState?) -> TriggerState {
        let state = state ?? TriggerState()
        
//        switch action {
//        case is StartAction:
//        default: break
//        }
        return state
    }
}
