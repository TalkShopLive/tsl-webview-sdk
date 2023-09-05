import WebKit
import SwiftUI

let EMBED_URL = "https://publish.talkshop.live/?v=1691163266&&isEmbed=true&type=show&index=JyC00f6tVJv0&mobile=1&modus="
let DEFAULT_EMBED_URL_LIVE = EMBED_URL + "5Cn81MRw51ct"
struct Webview: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> WebviewController {
        let webviewController = WebviewController()

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webviewController.webview.load(request)

        return webviewController
    }

    func updateUIViewController(_ webviewController: WebviewController, context: Context) {
        //
    }
}

class WebviewController: UIViewController, WKNavigationDelegate {
    lazy var webviewConfiguration: WKWebViewConfiguration = {
            let configuration = WKWebViewConfiguration()
            configuration.allowsInlineMediaPlayback = true
            return configuration
        }()
    lazy var webview: WKWebView = {
            let webView = WKWebView(frame: .zero, configuration: webviewConfiguration)
            webView.uiDelegate = self
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
            return webView
        }()
    lazy var progressbar: UIProgressView = UIProgressView()

    deinit {
        self.webview.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webview.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webview.uiDelegate = self
        self.webview.navigationDelegate = self
        self.webview.allowsBackForwardNavigationGestures = true
        self.view.addSubview(self.webview)

        self.webview.frame = self.view.frame
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            self.webview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])

        self.webview.addSubview(self.progressbar)
        self.setProgressBarPosition()

        webview.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        self.progressbar.progress = 0.1
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        guard let redirectURL = (navigationAction.request.url) else {
            decisionHandler(.cancel)
            return
        }
    
        // Enable for debugging
        // let _ = print("URL ->", redirectURL)
        if (redirectURL.absoluteString.contains("isEmbed=true")) {
            // Allows opening in the webview
            decisionHandler(.allow)
        } else if (redirectURL.absoluteString.starts(with: "https://talkshop.live") ||
                   redirectURL.absoluteString.starts(with: "https://publish.talkshop.live") ||
                   redirectURL.absoluteString.starts(with: "https://support.talkshop.live") ||
                   redirectURL.absoluteString.starts(with: "https://www.facebook.com") ||
                   redirectURL.absoluteString.starts(with: "https://twitter.com") ||
                   redirectURL.absoluteString.starts(with: "https://m.facebook.com")
        ) {
            // Opens up in safari
            UIApplication.shared.open(redirectURL, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.cancel)
        }
    }

    func setProgressBarPosition() {
        self.progressbar.translatesAutoresizingMaskIntoConstraints = false
        self.webview.removeConstraints(self.webview.constraints)
        self.webview.addConstraints([
            self.progressbar.topAnchor.constraint(equalTo: self.webview.topAnchor, constant: self.webview.scrollView.contentOffset.y * -1),
            self.progressbar.leadingAnchor.constraint(equalTo: self.webview.leadingAnchor),
            self.progressbar.trailingAnchor.constraint(equalTo: self.webview.trailingAnchor),
        ])
    }

    // MARK: - Web view progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { () in
                    self.progressbar.alpha = 0.0
                }, completion: { finished in
                    self.progressbar.setProgress(0.0, animated: false)
                })
            } else {
                self.progressbar.isHidden = false
                self.progressbar.alpha = 1.0
                progressbar.setProgress(Float(self.webview.estimatedProgress), animated: true)
            }

        case "contentOffset":
            self.setProgressBarPosition()

        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension WebviewController: WKUIDelegate {

    func webView(_ webview: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        guard let url = navigationAction.request.url else {
            return nil
        }
        
        guard let targetFrame = navigationAction.targetFrame, targetFrame.isMainFrame else {
            webview.load(URLRequest(url: url))
            return nil
        }
        return nil
    }
}

@available(iOS 16, macOS 11.0, *)
public struct TSLWebview: View {
    @Binding var showID: String
    @Binding var theme: String?
    @Binding var autoPlay: Bool?
    @Binding var expandChat: Bool?
    @Binding var hideChat: Bool?
    @Binding var singleVariantButtonText: String?
    @Binding var singleVariantButtonIcon: String?
    @Binding var multipleVariantButtonText: String?
    

    public init(showID: Binding<String>, theme: Binding<String?> = .constant("light"), autoPlay: Binding<Bool?> = .constant(nil), expandChat: Binding<Bool?> = .constant(nil), hideChat: Binding<Bool?> = .constant(nil), singleVariantButtonText: Binding<String?> = .constant(nil), singleVariantButtonIcon: Binding<String?> = .constant(nil), multipleVariantButtonText: Binding<String?> = .constant(nil)) {
        self._showID = showID
        self._theme = theme
        self._autoPlay = autoPlay
        self._expandChat = expandChat
        self._hideChat = hideChat
        self._singleVariantButtonText = singleVariantButtonText
        self._singleVariantButtonIcon = singleVariantButtonIcon
        self._multipleVariantButtonText = multipleVariantButtonText
    }

    public var body: some View {
        let fullURL = "\(EMBED_URL)\(showID)&theme=\(theme ?? "light")&autoplay=\(autoPlay ?? false ? 1 : 0)&view=\(expandChat ?? false ? "chat" : "default")&hideChat=\(hideChat ?? false ? 1 : 0)&singleVariantButtonText=\(singleVariantButtonText ?? "Buy")&singleVariantButtonIcon=\(singleVariantButtonIcon ?? "" )&multipleVariantButtonText\(multipleVariantButtonText ?? "Buy")"
        
        return (
            Webview(url: URL(string: fullURL)!)
        )
    }
}
