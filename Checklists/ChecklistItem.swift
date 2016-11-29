import Foundation

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  
  required init?(coder aDecoder: NSCoder) {
    super.init()
  }
  
  override init() {
    super.init()
  }
  
  func toggleChecked() {
    checked = !checked
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
  }
}
