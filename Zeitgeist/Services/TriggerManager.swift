import ReSwift

class TriggerManager
{
    private let store: Store<AppState>
    private var timer = Timer()
    
    private var startTimeTrigger = TimeTriggerProcessor() {
        print("start timer trigger")
    }
    private var endTimeTrigger = TimeTriggerProcessor() {
        print("start timer trigger")
    }
    
    // --------------------------------------------------------------------------------
    
    init(store: Store<AppState>) {
        self.store = store
        setup()
    }
    
    deinit {
        store.unsubscribe(self)
    }

    private func setup()
    {
        store.subscribe(self) { subscriber in
            subscriber.select { $0.triggerState }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block:
            {[weak self] _ in self?.runLoop() })
    }
    
    // --------------------------------------------------------------------------------
    
    private func runLoop()
    {
        
    }
}

extension TriggerManager: StoreSubscriber
{
    func newState(state: TriggerState)
    {
        
    }
}
