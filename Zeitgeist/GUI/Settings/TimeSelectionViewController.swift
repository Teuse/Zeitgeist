import UIKit
import ReSwift
import MapKit
import CoreLocation

class TimeSelectionViewController: UIViewController
{   
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
}

extension TimeSelectionViewController: StoreSubscriber
{
    func newState(state: AppState)
    {
    }
}
