import UIKit
//bin html content show page
class BBinWebContrllerViewController: BaseController,UIWebViewDelegate {
    
    var htmlContent = ""
    @IBOutlet weak var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scalesPageToFit = true
        webView.loadHTMLString(htmlContent, baseURL: URL.init(string: BASE_URL))
    }
}

extension BBinWebContrllerViewController{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        showDialog(view: self.view, loadText: "正在载入...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideDialog()
    }
    
}
