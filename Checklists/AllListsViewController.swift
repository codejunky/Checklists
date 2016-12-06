import UIKit

class AllListsViewController: UITableViewController,
      ListDetailViewControllerDelegate, UINavigationControllerDelegate {
  
  var dataModel: DataModel!
  
  // MARK: - iOS lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    navigationController?.delegate = self
    
    let index = dataModel.indexOfSelectedChecklist
    if index >= 0 && index < dataModel.lists.count {
      let checklist = dataModel.lists[index]
      performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return dataModel.lists.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = makeCell(for: tableView)
    
    let checklist = dataModel.lists[indexPath.row]
    cell.textLabel!.text = checklist.name
    cell.accessoryType = .detailDisclosureButton
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    dataModel.indexOfSelectedChecklist = indexPath.row
    
    let checklist = dataModel.lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
  
  // MARK: - Table view delegate
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView,
                          accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
    let navigationController = storyboard!.instantiateViewController(
                                      withIdentifier: "ListDetailNavigationController") as! UINavigationController
    
    let controller = navigationController.topViewController as! ListDetailViewController
    
    controller.delegate = self
    
    let checklist = dataModel.lists[indexPath.row]
    controller.checkListToEdit = checklist
    
    present(navigationController, animated: true, completion: nil)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowChecklist" {
      let controller = segue.destination as! ChecklistViewController
      controller.checklist = sender as! Checklist
    } else if segue.identifier == "AddChecklist" {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! ListDetailViewController
      
      controller.delegate = self
      controller.checkListToEdit = nil
    }
  }
  
  // MARK: - ListDetailViewControllerDelegate protocol implementation
  
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishAdding checklist: Checklist) {
    let newRowIndex = dataModel.lists.count
    dataModel.lists.append(checklist)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    dismiss(animated: true, completion: nil)
  }
  
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishEditin checklist: Checklist) {
    if let index = dataModel.lists.index(of: checklist) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = checklist.name
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UINavigationControllerDelegate protocol implementation
  func navigationController(_ navigationController: UINavigationController,
                            willShow viewController: UIViewController,
                            animated: Bool) {
    
    if viewController === self {
      dataModel.indexOfSelectedChecklist = -1
    }
  }
  
  // MARK: - Helper methods
  
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


















