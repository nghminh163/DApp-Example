import UIKit
import DAppLib
class ViewController: UIViewController {
    var walletConnect: DAppLib!
    var walletName: WalletName!
    var actionsController: ActionsViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        walletConnect = DAppLib(delegate: self)
        walletConnect.reconnectIfNeeded()
    }
    
    @IBAction func connect(_ sender: Any) {
        self.walletName=WalletName.Metamask
        walletConnect.connect()
    }
    
    func onMainThread(_ closure: @escaping () -> Void) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async {
                closure()
            }
        }
    }
}


extension ViewController: WalletConnectDelegate {
    func failedToConnect() {
        onMainThread { [unowned self] in
            //            if let handshakeController = self.handshakeController {
            //                handshakeController.dismiss(animated: true)
            //            }
            UIAlertController.showFailedToConnect(from: self)
        }
    }
    
    func didConnect(wcURI: String) {
        onMainThread { [unowned self] in
            if(self.walletName != nil){
                UtilsDApp.openWallet(walletName: self.walletName, uri: wcURI)
            }
            
        }
    }
    
    func didConnect() {
        onMainThread { [unowned self] in
            self.actionsController = ActionsViewController.create(walletConnect: self.walletConnect)
            if self.presentedViewController == nil {
                self.walletName=nil;
                self.present(self.actionsController, animated: false)
            }
        }
    }
    
    func didDisconnect() {
        onMainThread { [unowned self] in
            if let presented = self.presentedViewController {
                presented.dismiss(animated: false)
            }
            UIAlertController.showDisconnected(from: self)
        }
    }
}

extension UIAlertController {
    func withCloseButton() -> UIAlertController {
        addAction(UIAlertAction(title: "Close", style: .cancel))
        return self
    }
    
    static func showFailedToConnect(from controller: UIViewController) {
        let alert = UIAlertController(title: "Failed to connect", message: nil, preferredStyle: .alert)
        controller.present(alert.withCloseButton(), animated: true)
    }
    
    static func showDisconnected(from controller: UIViewController) {
        let alert = UIAlertController(title: "Did disconnect", message: nil, preferredStyle: .alert)
        controller.present(alert.withCloseButton(), animated: true)
    }
}
