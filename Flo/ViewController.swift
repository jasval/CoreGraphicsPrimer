/// Copyright (c) 2020 Razeware LLC

import UIKit

class ViewController: UIViewController {
    
    var containerView: UIView!
    var addButton: PushButton!
    var minusButton: PushButton!
    var counterView: CounterView!
    var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawViews()
        addActions()
    }
    
    func addActions() {
        addButton.addTarget(self, action: #selector(buttonPushed(_:)), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(buttonPushed(_:)), for: .touchUpInside)
    }
    
    func drawViews() {
        containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .yellow
        view.addSubview(containerView)
        
        counterView = CounterView()
        counterView.backgroundColor = .white
        counterView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(counterView)
        
        addButton = PushButton(isAddButton: true)
        minusButton = PushButton(isAddButton: false)
        addButton.backgroundColor = .clear
        minusButton.backgroundColor = .clear
        addButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        view.addSubview(minusButton)

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 300),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterView.heightAnchor.constraint(equalToConstant: 230),
            counterView.widthAnchor.constraint(equalToConstant: 230),
            counterView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            counterView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 100),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            minusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            minusButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 8)
        ])
        
        counterLabel = UILabel()
        counterLabel.font = UIFont.systemFont(ofSize: 36)
        counterLabel.textAlignment = .center
        counterLabel.text = String(counterView.counter)
        
        counterView.addSubview(counterLabel)
    }

    /// Introducing @IBDesignable --> 'Live Rendering' allows views to draw themselves more accurately in a storyboard by running draw(_:)
    
    // MARK: - Actions
    
    @objc func buttonPushed(_ button: PushButton) {
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
    }
}
