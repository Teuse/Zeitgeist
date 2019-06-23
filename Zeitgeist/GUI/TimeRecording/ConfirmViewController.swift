import Foundation
import UIKit
import ReSwift

class ConfirmViewController: UIViewController
{
   enum ConfirmType {
      case work, sickness, vacation
   }
   
   var type: ConfirmType = .work {
      didSet { if isViewLoaded { updateView() } }
   }
   
   @IBOutlet private weak var imageView: UIImageView!
   @IBOutlet private weak var infoLabel: UILabel!
   @IBOutlet private weak var confirmButton: UIButton!
   
   override func viewWillAppear(_ animated: Bool)
   {
      super.viewWillAppear(animated)
      subscribe(self)
   }
   
   override func viewWillDisappear(_ animated: Bool)
   {
      super.viewWillDisappear(animated)
      unsubscribe(self)
   }
   
   override func viewDidLoad()
   {
      updateView()
   }
   
   private func updateView()
   {
      switch type {
      case .work:
         title = "Confirmation"
         infoLabel.text = "Are you done with work for today?"
         confirmButton.setTitle("It's home time!", for: .normal)
      case .vacation:
         title = "Add Vacation Day"
         infoLabel.text = "Are you doing vacation today?"
         confirmButton.setTitle("Add Vacation Day", for: .normal)
      case .sickness:
         title = "Add Sickness Day"
         infoLabel.text = "Are you realy sick today 🤒?"
         confirmButton.setTitle("Get well soon", for: .normal)
      }
   }
   
   @IBAction private func onConfirmClicked(_ sender: UIButton)
   {
      switch type {
      case .work:
         dispatch(action: RecordingActions.Stop())
      case .vacation:
         dispatch(action: RecordingActions.AddVacationDay())
      case .sickness:
         dispatch(action: RecordingActions.AddSicknessDay())
      }

      navigationController?.popViewController(animated: true)
   }
}

// --------------------------------------------------------------------------------
//MARK: - ReSwift

extension ConfirmViewController: StoreSubscriber
{
   func newState(state: AppState)
   {
      
   }
}
