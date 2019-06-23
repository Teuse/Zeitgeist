import UIKit
import ReSwift

class TodayViewController: UIViewController
{
   var state = RecordingState()
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
   
   @IBOutlet private weak var buttonsContainer: UIView!
   
   // --------------------------------------------------------------------------------
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self) { subcription in
         subcription.select { state in state.recordingState }
      }
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
      if let record = state.record, !record.isFinished {
         durationLabel.text = durationString(from: record.duration)
      }
   }
   
   // --------------------------------------------------------------------------------
   
   @IBAction func onStartButton(_ sender: UIButton)
   {
      dispatch(action: RecordingActions.Start())
   }
   
   @IBAction func onPauseButton(_ sender: UIButton)
   {
      if state.isPaused {
         dispatch(action: RecordingActions.StopPause())
      } else {
         dispatch(action: RecordingActions.StartPause())
      }
   }
   
   @IBAction func onCheckmarkButton(_ sender: UIButton) {
      dispatch(action: RecordingActions.RunAnimation())
   }
   
   // --------------------------------------------------------------------------------
   
   private func updateUI()
   {
      if let record = state.record
      {
         dateLabel.text = dateString(from: record.begin!)
         startLabel.text = timeString(from: record.begin!)
         durationLabel.text = durationString(from: record.duration)
         pauseLabel.text = "0:00"
         overtimeLabel.text = "0:00"
         
         startButton.isHidden = true
         stopButton.isHidden = record.isFinished
         pauseButton.isHidden = record.isFinished
         checkmarkButton.isHidden = !record.isFinished
         buttonsContainer.isHidden = true
      }
      else {
         dateLabel.text = dateString(from: Date())
         startLabel.text = "-"
         durationLabel.text = "0:00"
         overtimeLabel.text = "-"
         pauseLabel.text = "-"
         
         startButton.isHidden = false
         stopButton.isHidden = true
         pauseButton.isHidden = true
         checkmarkButton.isHidden = true
         buttonsContainer.isHidden = false
      }
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension TodayViewController: StoreSubscriber
{
   func newState(state: RecordingState)
   {
      self.state = state
      updateUI()
   }
}
