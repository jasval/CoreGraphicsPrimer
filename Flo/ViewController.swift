/// Copyright (c) 2020 Razeware LLC

import UIKit

class ViewController: UIViewController {
    
    var addButton: PushButton!
    var counterView: CounterView!
    var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawCounter()
        drawButton()

        addButton.addTarget(self, action: #selector(addButtonPushed(_:)), for: .touchUpInside)
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
            counterView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        counterLabel = UILabel()
        counterLabel.font = UIFont.systemFont(ofSize: 36)
        counterLabel.textAlignment = .center
        counterLabel.text = String(counterView.counter)
        
        counterView.addSubview(counterLabel)
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
            addButton.topAnchor.constraint(equalTo: counterView.bottomAnchor, constant: 40)
        ])
    }
    

    /// Introducing @IBDesignable --> 'Live Rendering' allows views to draw themselves more accurately in a storyboard by running draw(_:)
    
    // MARK: - Actions
    
    @objc func addButtonPushed(_ sender: PushButton?) {
        counterView.counter += 1
        counterLabel.text = String(counterView.counter)
    }
}
