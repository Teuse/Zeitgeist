import ReSwift

class TriggerManager
{
   private let store: Store<AppState>
   private var timer = Timer()

   private lazy var startTimeTrigger: TimeTriggerProcessor = {
      return TimeTriggerProcessor() { [weak self] in
         self?.print()
      }
   }()
   private lazy var endTimeTrigger: TimeTriggerProcessor = {
      return TimeTriggerProcessor() { [weak self] in
         self?.print()
      }
   }()

   func print() {
      
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
      store.subscribe(self) 

      timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block:
         {[weak self] _ in self?.runLoop() })
   }

   // --------------------------------------------------------------------------------

   private func runLoop()
   {
      startTimeTrigger.process()
   }
}

extension TriggerManager: StoreSubscriber
{
   func newState(state: AppState)
   {
//      startTimeTrigger.enabled = state.startTimeTrigger.enabled
//      startTimeTrigger.setTime(state.startTimeTrigger.time)

//      endTimeTrigger.enabled = state.endTimeTrigger.enabled
//      startTimeTrigger.setTime(state.endTimeTrigger.time)
   }
}

