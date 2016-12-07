import UIKit

protocol ListDetailViewControllerDelegate: class {
  func listDetailViewControllerDidCancel(
                            _ controller: ListDetailViewController)
  
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishAdding checklist: Checklist)
  
  func listDetailViewController(_ controller: ListDetailViewController,
                                didFinishEditin checklist: Checklist)
}

class ListDetailViewController: UITableViewController,
                                    UITextFieldDelegate, IconPickerViewControllerDelegate {
  
  @IBOutlet weak var textField : UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var iconImageView: UIImageView!
  
  
  weak var delegate: ListDetailViewControllerDelegate?
  
  var checkListToEdit: Checklist?
  var iconName = "Folder"
  
  // MARK: - iOS lifecycle methods
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func viewDidLoad() {
     super.viewDidLoad()
    
    if let checklist = checkListToEdit {
      title = "Edit Checklist"
      textField.text = checklist.name
      doneBarButton.isEnabled = true
      iconName = checklist.iconName
      iconImageView.image = UIImage(named: iconName)
    }
  }
  
  // MARK: - This ViewController's actions
  
  @IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    if let checklist = checkListToEdit {
      checklist.name = textField.text!
      checklist.iconName = iconName
      delegate?.listDetailViewController(self,
                                         didFinishEditin: checklist)
    } else {
      let checklist = Checklist(name: textField.text!, iconName: iconName)
      delegate?.listDetailViewController(self,
                                         didFinishAdding: checklist)
    }
  }
  
  // MARK: - TableView datasource and delegate
  
  override func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if indexPath.section == 1 {
      return indexPath
    } else {
      return nil
    }
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PickIcon" {
      let controller = segue.destination as! IconPickerViewController
      controller.delegate = self
    }
  }
  
  // MARK: - TextFieldDelegate protocol implementation
  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    let oldText = textField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string)
                                                  as NSString
    doneBarButton.isEnabled = (newText.length > 0)
    return true
  }
  
  // MARK: - IconPickerViewControllerDelegate protocol implementation
  
  func iconPicker(_ picker: IconPickerViewController,
                  didPick iconName: String) {
    self.iconName = iconName
    iconImageView.image = UIImage(named: iconName)
    let _ = navigationController?.popViewController(animated: true)
  }
}


























