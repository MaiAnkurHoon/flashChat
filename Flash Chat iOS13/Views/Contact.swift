//
//  Contact.swift
//  Flash Chat iOS13
//
//  Created by Ankur Mazumder  on 14/09/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class Contact: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func contactPressed(_ sender: Any) {
        self.inputViewController?.performSegue(withIdentifier: k.chatSegue, sender: self)
    }
}
