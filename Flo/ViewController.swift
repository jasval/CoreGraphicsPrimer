/// Copyright (c) 2020 Razeware LLC

import UIKit

class ViewController: UIViewController {
    
    var addButton: PushButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawButton()
    }
    
    func drawButton() {
        addButton = PushButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    /// Introducing @IBDesignable --> 'Live Rendering' allows views to draw themselves more accurately in a storyboard by running draw(_:)
    
    
}
