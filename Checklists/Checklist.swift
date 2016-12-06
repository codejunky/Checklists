import UIKit

class Checklist: NSObject, NSCoding {
  var name = ""
  var items = [ChecklistItem]()
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "Name") as! String
    items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
  }
  
  init(name: String) {
    self.name = name
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "Name")
    aCoder.encode(items, forKey: "Items")
  }
  
  func countUncheckedItems() -> Int {
    return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
  }
 }
