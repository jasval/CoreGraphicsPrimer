/// Copyright (c) 2020 Razeware LLC

import UIKit

class ViewController: UIViewController {
    
    var addButton: PushButton!
    var counterView: CounterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawButton()
        drawCounter()
    }
    
    func drawButton() {
        addButton = PushButton()
        addButton.backgroundColor = .clear
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func drawCounter() {
        counterView = CounterView()
        counterView.backgroundColor = .clear
        counterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(counterView)
        
        
        NSLayoutConstraint.activate([
            counterView.heightAnchor.constraint(equalToConstant: 230),
            counterView.widthAnchor.constraint(equalToConstant: 230),
            counterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: 40)
        ])
    }
    
    /// Introducing @IBDesignable --> 'Live Rendering' allows views to draw themselves more accurately in a storyboard by running draw(_:)
    
    
}
