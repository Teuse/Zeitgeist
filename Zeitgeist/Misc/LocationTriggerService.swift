import Foundation

class LocationTriggerService
{
    let enabled = false
    
    private var timer: Timer?
    
    // --------------------------------------------------------------------------------
    
    init() {
        
    }
    
    func start()
    {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block:
        { _ in self.runLoop() })
    }
    
    func stop()
    {
        timer = nil
    }
    
    // --------------------------------------------------------------------------------
    
    private func runLoop()
    {
        guard enabled else { return }
        
        
    }
    
}
