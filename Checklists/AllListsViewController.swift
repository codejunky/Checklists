import UIKit

class AllListsViewController: UITableViewController {
  
  var lists: [Checklist]
  
  required init?(coder aDecoder: NSCoder) {
    lists = [Checklist]()
    
    super.init(coder: aDecoder)
    
    var list = Checklist(name: "Birthdays")
    lists.append(list)
    
    list = Checklist(name: "Croceries")
    lists.append(list)
    
    list = Checklist(name: "Cool Apps")
    lists.append(list)
    
    list = Checklist(name: "To Do")
    lists.append(list)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return lists.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = makeCell(for: tableView)
    
    let checklist = lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    cell.accessoryType = .detailDisclosureButton
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "ShowChecklist", sender: nil)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  func makeCell(for tableView: UITableView) -> UITableViewCell {
    let cellIndentifier = "Cell"
    if let cell =
      tableView.dequeueReusableCell(withIdentifier: cellIndentifier) {
      return cell
    } else {
      return UITableViewCell(style: .default,
                             reuseIdentifier: cellIndentifier)
    }
  }
  
}


















