//
//  ViewController.swift
//  WeekdayFinder
//
//  Created by Kirill Grunin on 17.06.2022.
//

import UIKit

class WDFViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        layout()
    }

    private let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weekday Finder"
        label.textColor = .black
        label.font = .systemFont(ofSize: 32)
        return label
    }()
    
    private let dayField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.font = .systemFont(ofSize: 16)
        field.placeholder = "Enter day"
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let monthField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.font = .systemFont(ofSize: 16)
        field.placeholder = "Enter month"
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let yearField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .black
        field.font = .systemFont(ofSize: 16)
        field.placeholder = "Enter year"
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.5
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.backgroundColor = .systemGray5
        stackView.distribution = .fillEqually
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Here you'll see the day of the week"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var resultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Find day", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private func layout() {
        
        view.addSubview(topLabel)
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            topLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        [dayField, monthField, yearField].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            dayField.topAnchor.constraint(equalTo: stackView.topAnchor),
            dayField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            dayField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            monthField.topAnchor.constraint(equalTo: dayField.bottomAnchor),
            monthField.widthAnchor.constraint(equalTo: dayField.widthAnchor),
            monthField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            yearField.topAnchor.constraint(equalTo: monthField.bottomAnchor),
            yearField.widthAnchor.constraint(equalTo: monthField.widthAnchor),
            yearField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            resultLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        view.addSubview(resultButton)
        
        NSLayoutConstraint.activate([
            resultButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 50),
            resultButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            resultButton.widthAnchor.constraint(equalToConstant: 150)
        
        ])
    }

    @objc func buttonClicked() {
        guard let day = dayField.text, let month = monthField.text, let year = yearField.text else { return }
        
        if day.isEmpty && month.isEmpty && year.isEmpty {
            dayField.shakeField()
            monthField.shakeField()
            yearField.shakeField()
        } else if day.isEmpty {
            dayField.shakeField()
        } else if month.isEmpty {
            monthField.shakeField()
        } else if year.isEmpty {
            yearField.shakeField()
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = Int(day)
        dateComponents.month = Int(month)
        dateComponents.year = Int(year)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.dateFormat = "EEEE"
        
        guard let date = calendar.date(from: dateComponents) else { return }
        
        let weekday = dateFormatter.string(from: date)
        let capitalizedWeekday = weekday.capitalized
        
        resultLabel.text = capitalizedWeekday
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIView {
    func shakeField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

