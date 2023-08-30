# TSLWebviewSdk

TalkShopLive Embed Player SDK

TSLWebview sdk is a thin wrapper around embed player webview.

## Usage:
```
import TSLWebview

// Use in any view
TSLWebview(showID: Binding<String>, theme: Binding<String>, autoPlay: Binding<Bool>)
```

## Example Code:
```
import TSLWebview

struct ScreenView : View {
    @Binding var showID: String = "SHOW_ID"
    @Binding var theme: String = "light"
    @Binding var autoPlay: Bool = false
    
    var body: some View {
        VStack {
            // Open Embed Player in WebView
            TSLWebview(showID: $ShowID, theme: $theme, autoPlay: $autoPlay)
        }
    }
}
```
