# TSLWebviewSdk

TalkShopLive Embed Player SDK

TSLWebview sdk is a thin wrapper around embed player webview.

## Usage:
```
import TSLWebview

// Use in any view
TSLWebview(showID, theme, autoPlay, expandChat, hideChat, singleVariantButtonText, singleVariantButtonIcon, multipleVariantButtonText)
```

## Example Code
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
        // Open in webview
        TSLWebview(showID: $showID, theme: $theme, autoPlay: $autoPlay, expandChat: $expandChat, hideChat: $hideChat, singleVariantButtonText: $singleVariantButtonText, singleVariantButtonIcon: $singleVariantButtonIcon, multipleVariantButtonText: $multipleVariantButtonText)
    }
}
```

## Available Options
|           Param           |       Type       |             Info             |
|:-------------------------:|:----------------:|:----------------------------:|
|          showID           | Binding<String>  |     TalkShopLive Show ID     |
|           theme           | Binding<String?> | WebView theme(light or dark) |
|         autoPlay          |  Binding<Bool?>  |        Autoplay video        |
|        expandChat         |  Binding<Bool?>  |   Auto expand chat on open   |
|         hideChat          |  Binding<Bool?>  |     Hide chat completely     |
|  singleVariantButtonText  | Binding<String?> |       Buy button text        |
|  singleVariantButtonIcon  | Binding<String?> |       Buy button icon        |
| multipleVariantButtonText | Binding<String?> | Multiple variant button text |

