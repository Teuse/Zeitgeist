import Foundation

class TimeTriggerProcessor
{
    typealias Callback = () -> Void
    
    var enabled = false
    
    private var startTime = Time()
    private var endTime = Time()
    
    private let callback: Callback
    private let calendar = Calendar.current
    
    func setTime(_ time: Time) {
        startTime = time
        endTime = time
        endTime.addMinutes(1)
    }
    
    func setTimeRange(start startTime: Time, end endTime: Time) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    // --------------------------------------------------------------------------------
    
    init(triggerCallback: @escaping(Callback)) {
        callback = triggerCallback
    }
    
    // --------------------------------------------------------------------------------
    
    
    
//    private func process()
//    {
//        guard enabled else { return }
//        
//        let now = Date()
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        if hour == startTime.hour && minutes == startTime.minute {
//            callback(true)
//        }
//        else if hour == endTime.hour && minutes == endTime.minute {
//            callback(false)
//        }
//    }
}
