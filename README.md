# TSLWebviewSdk

TalkShopLive Embed Player SDK

TSLWebview sdk is a thin wrapper around embed player webview.

## Usage:
```
import TSLWebview

// Use in any view
TSLWebview(showID: $showID, theme: $theme, autoPlay: $autoPlay, expandChat: $expandChat, hideChat: $hideChat, singleVariantButtonText: $singleVariantButtonText, singleVariantButtonIcon: $singleVariantButtonIcon, multipleVariantButtonText: $multipleVariantButtonText)
```

## Example Code:
```
import TSLWebview

struct ScreenView : View {
    @Binding var showID: String
    @Binding var theme: String?
    @Binding var autoPlay: Bool?
    @Binding var expandChat: Bool?
    @Binding var hideChat: Bool?
    @Binding var singleVariantButtonText: String?
    @Binding var singleVariantButtonIcon: String?
    @Binding var multipleVariantButtonText: String?
    
    var body: some View {
        VStack {
            // Open in webview
            TSLWebview(showID: $showID, theme: $theme, autoPlay: $autoPlay, expandChat: $expandChat, hideChat: $hideChat, singleVariantButtonText: $singleVariantButtonText, singleVariantButtonIcon: $singleVariantButtonIcon, multipleVariantButtonText: $multipleVariantButtonText)
        }
    }
}
```
