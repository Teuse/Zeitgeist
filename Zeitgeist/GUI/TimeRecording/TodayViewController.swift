import UIKit
import ReSwift

class TodayViewController: UIViewController
{
   var record: Record?
   var timer : Timer!
   
   @IBOutlet private weak var dateLabel: UILabel!
   @IBOutlet private weak var startLabel: UILabel!
   @IBOutlet private weak var durationLabel: UILabel!
   @IBOutlet private weak var pauseLabel: UILabel!
   @IBOutlet private weak var overtimeLabel: UILabel!
   
   @IBOutlet private weak var startButton: UIButton!
   @IBOutlet private weak var stopButton: UIButton!
   @IBOutlet private weak var pauseButton: UIButton!
   @IBOutlet private weak var checkmarkButton: UIButton!
   
   // --------------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
      timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in self.runLoop() })
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
      timer = nil
   }
   
   func runLoop()
   {
      if let record = record, !record.isFinished {
         durationLabel.text = durationString(from: record.duration)
      }
   }
   
   // --------------------------------------------------------------------------------
   
   @IBAction func onStartButton(_ sender: UIButton)
   {
      assert(record == nil, "The button should be hidden")
      dispatch(action: StartAction())
   }
   
   @IBAction func onStopButton(_ sender: UIButton)
   {
      assert(record != nil, "The button should be hidden")
      dispatch(action: StopAction())
   }
   
   @IBAction func onPauseButton(_ sender: UIButton)
   {
      //        if let datum = appState.selectedDatum {
      //            dispatch(action: Stop(datum: datum))
      //        }
   }
   
   @IBAction func onCheckmarkButton(_ sender: UIButton) {
      
   }
   
   // --------------------------------------------------------------------------------
   
   private func updateUI()
   {
      if let record = record {
         dateLabel.text = dateString(from: record.begin!)
         startLabel.text = timeString(from: record.begin!)
         durationLabel.text = durationString(from: record.duration)
         pauseLabel.text = "-"
         overtimeLabel.text = "-"
         
         startButton.isHidden = true
         stopButton.isHidden = record.isFinished
         pauseButton.isHidden = record.isFinished
         checkmarkButton.isHidden = !record.isFinished
      }
      else {
         dateLabel.text = dateString(from: Date())
         startLabel.text = "-"
         durationLabel.text = "-"
         overtimeLabel.text = "-"
         pauseLabel.text = "-"
         
         startButton.isHidden = false
         stopButton.isHidden = true
         pauseButton.isHidden = true
         checkmarkButton.isHidden = true
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension TodayViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
      record = state.currentRecord
      updateUI()
   }
}
