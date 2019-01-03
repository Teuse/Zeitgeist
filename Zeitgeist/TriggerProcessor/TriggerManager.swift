import ReSwift

class TriggerManager
{
   private let store: Store<AppState>
   private var timer = Timer()

   private let locationProcessor = LocationProcessor()
   private let startTimeTrigger = TimeProcessor()
   private let endTimeTrigger = TimeProcessor()

   func print() {
      
   }

   // --------------------------------------------------------------------------------

   init(store: Store<AppState>) {
      self.store = store
      locationProcessor.deleate = self
      startTimeTrigger.deleate = self
      endTimeTrigger.deleate = self
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

   func checkTrigger() -> Bool
   {
      return false
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

extension TriggerManager: ProcessorDelegate
{
   func processorTriggeredStart()
   {
      store.dispatch(StartAction())
   }

   func processorTriggeredEnd()
   {
      store.dispatch(StopAction())
   }
}

