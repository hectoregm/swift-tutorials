//
//  ViewController.swift
//  TipCalculator
//
//  Created by Hector Enrique Gomez Morales on 6/15/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var totalTextField : UITextField
    @IBOutlet var taxPctSlider : UISlider
    @IBOutlet var taxPctLabel : UILabel
    @IBOutlet var resultsTextView : UITextView
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshUI() {
        totalTextField.text = String(tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value)))%"
        resultsTextView.text = ""
    }
    
    @IBAction func calculateTapped(sender: AnyObject) {
        tipCalc.total = Double(totalTextField.text.bridgeToObjectiveC().doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        
        for (tipPct, tipValue) in possibleTips {
            results += "\(tipPct)%: \(tipValue)\n"
        }
        
        resultsTextView.text = results
    }
    
    @IBAction func taxPercentageChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        totalTextField.resignFirstResponder()
    }


}

