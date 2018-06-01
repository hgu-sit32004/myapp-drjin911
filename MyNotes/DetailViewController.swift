
import UIKit
import Foundation
import CoreData
import CoreGraphics


class DetailViewController: UIViewController {
    
    var noteContentProvider: NotesContentProvider? = nil
    
    @IBOutlet weak var noteContent: UITextView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var noteTitle: UITextField!
    
    // Assign all the textfields to this action for keyboard collapse
    @IBAction func resignKeyboardTextField(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    static var noteId: String?
    
    // Timer! Property for auto-saving of a note
    var autoSaveTimer: Timer!
    
    var notes: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize Notes contentProvider
        noteContentProvider = NotesContentProvider()
        
        // Start the auto-save timer to call autoSave() every 2 seconds
        autoSaveTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoSave), userInfo: nil, repeats: true)
        
        // Prepare textfields with rounded corners
        noteTitle.layer.borderWidth = 0.5
        noteTitle.layer.cornerRadius = 5
        noteContent.layer.borderWidth = 0.5
        noteContent.layer.cornerRadius = 5
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        noteTitle.leftViewMode = .always
        noteTitle.leftView = paddingView
       
        // Do any additional setup after loading the view
        configureView()
    }
    
    var myNote: Note? {
        
        didSet {
            // Set the note Id if passed in from the MasterView
            DetailViewController.noteId = myNote?.value(forKey: "noteId") as? String
            
            // Update the view with passed in note title and content.
            configureView()
        }
    }
    
    // Display the note title and content
    func configureView() {
        
        if let title = myNote?.value(forKey: "title") as? String {
            noteTitle?.text = title
        }
        
        if let content = myNote?.value(forKey: "content") as? String {
            noteContent?.text = content
        }
    }
    
    @objc func autoSave() {
        
        // If this is a NEW note, set the Note Id
        if (DetailViewController.noteId == nil) // Insert
        {
            let id = noteContentProvider?.insert(noteTitle: "", noteContent: "")
            DetailViewController.noteId = id
        }
        else // Update
        {
            let noteId = DetailViewController.noteId
            let noteTitle = self.noteTitle.text
            let noteContent = self.noteContent.text
            noteContentProvider?.update(noteId: noteId!, noteTitle: noteTitle!, noteContent: noteContent!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Stop the auto-save timer
        if autoSaveTimer != nil {
            autoSaveTimer.invalidate()
        }
        
        // Update the note one last time unless a note was never created
        let noteId = DetailViewController.noteId
        if  noteId != nil {
            noteContentProvider?.update(noteId: (noteId)!, noteTitle: self.noteTitle.text!, noteContent: self.noteContent.text!) //Core Data
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        DetailViewController.noteId = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Dismiss keyboard when user taps on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Dismiss keyboard when user taps the return key on the keyboard after editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

