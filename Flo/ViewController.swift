/// Copyright (c) 2020 Razeware LLC

import UIKit

class ViewController: UIViewController {
    
    var containerView: UIView!
    var addButton: PushButton!
    var minusButton: PushButton!
    var counterView: CounterView!
    var graphView: GraphView!
    var counterLabel: UILabel!
    var titleLabel: UILabel!
    var averageWaterDrunkLabel: UILabel!
    var maxLabel: UILabel!
    var minLabel: UILabel!
    var stackView: UIStackView!
    var averageWaterDrunk: Int = 0 {
        didSet {
            averageWaterDrunkLabel.text = "Average: \(averageWaterDrunk)"
        }
    }
    
    var isGraphViewShowing = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawViews()
        addActions()
        setupGraphDisplay()
    }
    
    func addActions() {
        addButton.addTarget(self, action: #selector(buttonPushed(_:)), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(buttonPushed(_:)), for: .touchUpInside)
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(counterViewTap(_:))))
    }
    
    func drawViews() {
        containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        view.addSubview(containerView)
        
        counterView = CounterView()
        counterView.backgroundColor = .clear
        counterView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(counterView)
        
        graphView = GraphView()
        graphView.backgroundColor = .clear
        graphView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(graphView)
        
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
            graphView.heightAnchor.constraint(equalToConstant: 230),
            graphView.widthAnchor.constraint(equalToConstant: 300),
            graphView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            graphView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
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
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .natural
        titleLabel.font = FontBook.graphFont.size(12)
        titleLabel.textColor = .white
        titleLabel.text = "Water Drunk"
        averageWaterDrunkLabel = UILabel(frame: .zero)
        averageWaterDrunkLabel.translatesAutoresizingMaskIntoConstraints = false
        averageWaterDrunkLabel.textAlignment = .natural
        averageWaterDrunkLabel.font = FontBook.graphFont.size(12)
        averageWaterDrunkLabel.textColor = .white
        averageWaterDrunkLabel.text = "Average: \(averageWaterDrunk)"
        maxLabel = UILabel(frame: .zero)
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.textAlignment = .natural
        maxLabel.font = FontBook.graphFont.size(12)
        maxLabel.textColor = .white
        maxLabel.text = "99"
        minLabel = UILabel(frame: .zero)
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.textAlignment = .natural
        minLabel.font = FontBook.graphFont.size(12)
        minLabel.textColor = .white
        minLabel.text = "0"
        
        let monday = UILabel()
        monday.textAlignment = .center
        monday.font = FontBook.graphFont.size(12)
        monday.textColor = .white
        monday.text = "M"
        let tuesday = UILabel()
        tuesday.textAlignment = .center
        tuesday.font = FontBook.graphFont.size(12)
        tuesday.textColor = .white
        tuesday.text = "T"
        let wednesday = UILabel()
        wednesday.textAlignment = .center
        wednesday.font = FontBook.graphFont.size(12)
        wednesday.textColor = .white
        wednesday.text = "W"
        let thursday = UILabel()
        thursday.textAlignment = .center
        thursday.font = FontBook.graphFont.size(12)
        thursday.textColor = .white
        thursday.text = "T"
        let friday = UILabel()
        friday.textAlignment = .center
        friday.font = FontBook.graphFont.size(12)
        friday.textColor = .white
        friday.text = "F"
        let saturday = UILabel()
        saturday.textAlignment = .center
        saturday.font = FontBook.graphFont.size(12)
        saturday.textColor = .white
        saturday.text = "S"
        let sunday = UILabel()
        sunday.textAlignment = .center
        sunday.font = FontBook.graphFont.size(12)
        sunday.textColor = .white
        sunday.text = "S"
        stackView = UIStackView(
            arrangedSubviews: [
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
                sunday
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        graphView.addSubview(titleLabel)
        graphView.addSubview(averageWaterDrunkLabel)
        graphView.addSubview(maxLabel)
        graphView.addSubview(minLabel)
        graphView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: graphView.leadingAnchor, constant: GraphView.Constants.margin),
            titleLabel.topAnchor.constraint(equalTo: graphView.topAnchor, constant: GraphView.Constants.margin),
            averageWaterDrunkLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            averageWaterDrunkLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
            stackView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: -GraphView.Constants.margin),
            stackView.leadingAnchor.constraint(equalTo: graphView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: graphView.trailingAnchor),
            maxLabel.leadingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -GraphView.Constants.margin + 2),
            maxLabel.centerYAnchor.constraint(equalTo: graphView.topAnchor, constant: GraphView.Constants.topBorder),
            minLabel.leadingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -GraphView.Constants.margin + 2),
            minLabel.centerYAnchor.constraint(equalTo: graphView.bottomAnchor, constant: -GraphView.Constants.bottomBorder)
        ])
    }
    
    func setupGraphDisplay() {
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max() ?? 0)"
        
        averageWaterDrunk = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today), let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
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
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }
    
    @objc func counterViewTap(_ gesture: UITapGestureRecognizer?) {
        if isGraphViewShowing {
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            setupGraphDisplay()
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isGraphViewShowing.toggle()
    }
}
