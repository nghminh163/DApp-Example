import UIKit
import WalletConnectSwift
import DAppLib

class ActionsViewController: UIViewController {
    var dAppRequest:DAppRequest!
    static func create(walletConnect: DAppLib) -> ActionsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "ActionsViewController") as! ActionsViewController
        controller.dAppRequest = DAppRequest(_delegate:controller,_client: walletConnect.client, _session: walletConnect.session)
        return controller
    }
    
    
    
    @IBAction func onClickDisconnect(_ sender: Any) {
        dAppRequest.disconnect()
    }
    @IBAction func onCllickSend(_ sender: Any) {
        try! dAppRequest.sendTransaction(to:"0x448Ecb63760587f8a177c5a9EA323b3e39731E4F", gas:nil, gasPrice: nil, value: "0x5AF3107A4000")
    }
}

