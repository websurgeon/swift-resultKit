//
//  Copyright © 2018 Peter Barclay. All rights reserved.
//
// A completely pointless and overly contrived example using ResultKit
// to 'resolve' a Result from a callback instead of using a switch statement.

import UIKit
import ResultKit

enum RNGError: Error {
    case maxLessThanMin
    case invalidBounds(lower: String?, upper: String?)
}

class ViewController: UIViewController {
    @IBOutlet weak var lowerBoundInput: UITextField? = nil
    @IBOutlet weak var upperBoundInput: UITextField? = nil
    @IBOutlet weak var generateButton: UIButton? = nil
    @IBOutlet weak var outputLabel: UILabel? = nil
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView? = nil

    private typealias RNGResult = Result<Int, RNGError>
    
    func performRNGAction() {
        updateUIForActionStarted()
        generateNumber(using: lowerBoundInput?.text,
                       and: upperBoundInput?.text) { [weak self] result in
            DispatchQueue.main.async {
                do {
                    let generatedNumber = try result.resolve()
                    self?.outputNumber(generatedNumber)
                } catch {
                    self?.outputError(error)
                }
                self?.updateUIOnActionEnded()
            }
        }
    }

}

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel?.text = nil
    }
    
    @IBAction func didTapButton() {
        performRNGAction()
    }

    private func updateUIForActionStarted() {
        activityIndicator?.startAnimating()
        generateButton?.isEnabled = false
        outputLabel?.text = nil
    }
    
    private func updateUIOnActionEnded() {
        generateButton?.isEnabled = true
        activityIndicator?.stopAnimating()
    }
    
    private func outputNumber(_ value: Int) {
        outputLabel?.textColor = .purple
        outputLabel?.text = "\(value)"
    }
    
    private func outputError(_ error: Error) {
        outputLabel?.textColor = .red
        outputLabel?.text = errorMessage(for: error)
    }
    
    private func generateNumber(using lower: String?,
                                and upper: String?,
                                callback: @escaping (RNGResult) -> Void) {
        DispatchQueue.global().async {
            sleep(3) //simulate stupidly slow rng generation
            guard let min = numberFromText(lower),
                let max = numberFromText(upper) else {
                    callback(.failure(.invalidBounds(lower: lower,
                                                     upper: upper)))
                    return
            }
            let rng = createRNGenerator(min: min, max: max)
            if (min <= max) {
                callback(.success(rng()))
            } else {
                callback(.failure(.maxLessThanMin))
            }
        }
    }
    
    private func generateNumber(_ min: Int,
                                _ max: Int,
                                _ callback: @escaping (RNGResult) -> Void) {
        DispatchQueue.global().async {
        }
    }
}

private func numberFromText(_ value: String?) -> Int? {
    guard let text = value else { return nil }
    return NumberFormatter().number(from: text)?.intValue
}

private func createRNGenerator(min: Int, max: Int) -> () -> Int {
    return {
        return Int(
            arc4random_uniform(
                UInt32(max - min + 1)
                ) +
                UInt32(min)
        )
    }
}

private func errorMessage(for error: Error) -> String {
    guard let rngError = error as? RNGError else {
        return "unhandled error \(error)"
    }
    var message: String
    switch rngError {
    case .maxLessThanMin:
        message = "max must be >= min"
    case .invalidBounds(let lower, let upper):
        let min = numberFromText(lower)
        let max = numberFromText(upper)
        switch (min == nil, max == nil) {
        case (true, true):
            message = "please enter value min and max"
        case (true, false):
            message = "please enter valid min"
        case (false, true):
            message = "please enter valid max"
        case (false, false):
            fatalError("unexpected scenario " +
                "lower = \(String(describing: lower))," +
                "upper = \(String(describing: upper))")
        }
    }
    return message
}


