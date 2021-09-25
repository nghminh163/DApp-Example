import UIKit

public class UtilsDApp{
    public class func openWallet(walletName: WalletName, uri:String){
        var deepLink:String!
        switch walletName {
        case WalletName.Metamask:
            deepLink=uri;
            break
            
        }
        
        if(deepLink != nil){
            UtilsDApp().goToLink(uri: deepLink)
        }
    }
    
    
    func goToLink(uri:String){
        if let url = URL(string: uri), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

public enum WalletName{
    case Metamask
}
