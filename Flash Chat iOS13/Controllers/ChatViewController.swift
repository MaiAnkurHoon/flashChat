//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    var messages : [message] = []
    
   
    
    
    
//    VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = Auth.auth().currentUser?.email

        
        tableView.register(UINib(nibName: k.cellNibName, bundle: nil), forCellReuseIdentifier:k.cellIdentifier)
        loadMessages()
        
    }

    func loadMessages(){
       
        
        db.collection(k.FStore.collectionName)
            .order(by: k.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                self.messages = []
                if let e = error{
                    print("issue\(e.localizedDescription)")
                }
                else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments{
                            let data = (doc.data())
                            if let messageSender =  data[k.FStore.senderField] as? String, let messageBody = data[k.FStore.bodyField] as? String{
                                
                                let newMessage = message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexpath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexpath, at: .top, animated: true)
                                }
                                
                            }
                        }
                    }
                }
                
            }
    }
//    
//    messages addition
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(
                k.FStore.collectionName).addDocument(data:[k.FStore.senderField : messageSender, k.FStore.bodyField : messageBody,
                k.FStore.dateField: Date().timeIntervalSince1970] )
            {(error) in
                if let e = error {
                    print(e.localizedDescription)
                }
                else
                {
                    DispatchQueue.main.async{
                        self.messageTextfield.text = ""
                        
                    }
                    
                }
            }
        }
       
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            
            
            navigationController?.popToRootViewController(animated: true)
            
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    

}

//    MESSAGE ADDITION

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: k.cellIdentifier, for: indexPath)
        as! MessageCell
        cell.label?.text = message.body
        
        //this is a message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: k.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: k.BrandColors.purple)
        }
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: "beige")
            cell.label.textColor = UIColor(named: k.BrandColors.lighBlue)
        }
        
        return cell
    }
    
    
}
