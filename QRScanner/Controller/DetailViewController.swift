import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: CopyLabel!
    
    var qrData: QRData?
    var estimatedTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        detailLabel.text = qrData?.codeString
        UIPasteboard.general.string = detailLabel.text
        showToast(message : "Text copied to clipboard")

    }

    @IBAction func openInWebAction(_ sender: Any) {
        if let url = URL(string: qrData?.codeString ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            showToast(message : "Not a valid URL")
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func goButton(_ sender: UIButton) {
        textField.text = "Estimated Time: \(textField.text ?? "abc")"
        estimatedTime = textField.text!
        performSegue(withIdentifier: "lastViewSegue" , sender: sender)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "lastViewSegue", let viewController = segue.destination as? secondViewController {
        viewController.qrdata = qrData?.codeString as! String
        viewController.segueToScreen = true
        viewController.items = textField.text!
        }
    }
}

extension DetailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
