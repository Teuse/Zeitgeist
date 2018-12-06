import UIKit
import ReSwift

class TodayViewController: UIViewController
{
    var record: Record?
    var timer : Timer!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var pauseLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
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
    // Mark: - Actions
    
    @IBAction func onStartButton(_ sender: Any)
    {
        if record == nil {
            dispatch(action: StartAction())
        }
        else {
            dispatch(action: StopAction())
        }
    }
    
    @IBAction func onPauseButton(_ sender: Any)
    {
//        if let datum = appState.selectedDatum {
//            dispatch(action: Stop(datum: datum))
//        }
    }
    
    // --------------------------------------------------------------------------------
    // Mark: - Update UI
    private func updateUI()
    {
        if let record = record {
            dateLabel.text = dateString(from: record.begin!)
            startLabel.text = timeString(from: record.begin!)
            endLabel.text = record.end != nil ? timeString(from: record.end!) : "-"
            durationLabel.text = durationString(from: record.duration)
            pauseLabel.text = "-"
            
            startButton.isEnabled = !record.isFinished
            pauseButton.isEnabled = !record.isFinished
        }
        else {
            dateLabel.text = dateString(from: Date())
            startLabel.text = "-"
            endLabel.text = "-"
            durationLabel.text = "-"
            
            pauseLabel.text = "-"
            startButton.isEnabled = true
            pauseButton.isEnabled = false
        }
    }
}

extension TodayViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
        record = state.currentRecord
        updateUI()
    }
}
