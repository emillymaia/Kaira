import UIKit

struct HistoryPageModel {
    var image: String
    var text: String
    var button: ButtonType
    var nextViewController: UIViewController?
}

enum ButtonType {
    case next
    case finish
}
