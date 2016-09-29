//
//  ViewController.swift
//  TipCalc
//
//  Created by Savio Tsui on 9/25/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let defaults = UserDefaults.standard

    private let lowTipKey = "lowTip"
    private let mediumTipKey = "mediumTip"
    private let highTipKey = "highTip"
    
    private static var isFirstLoad = true
    private var tipPercentages:[String:Double] = [
        "lowTip" : 0.1,
        "mediumTip" : 0.15,
        "highTip" : 0.2
    ]
    
    var animations: Animations!
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentTipAmount: UISegmentedControl!
    
    private func initDependencies(animations: Animations) {
        self.animations = animations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // need to figure out how to correctly do dependency injection
        initDependencies(animations: Animations())
        
        tipPercentages[lowTipKey] = getSetTipPercentageSetting(lowTipKey, override: true)
        tipPercentages[mediumTipKey] = getSetTipPercentageSetting(mediumTipKey, override: true)
        tipPercentages[highTipKey] = getSetTipPercentageSetting(highTipKey, override: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var overrideUserDefaults = false
        if (ViewController.isFirstLoad == true)
        {
            overrideUserDefaults = true
            ViewController.isFirstLoad = false
        }
        
        tipPercentages[lowTipKey] = getSetTipPercentageSetting(lowTipKey, override: overrideUserDefaults)
        tipPercentages[mediumTipKey] = getSetTipPercentageSetting(mediumTipKey, override: overrideUserDefaults)
        tipPercentages[highTipKey] = getSetTipPercentageSetting(highTipKey, override: overrideUserDefaults)
        
        setTitlePercentTipAmountSegmentControl(0, key: lowTipKey)
        setTitlePercentTipAmountSegmentControl(1, key: mediumTipKey)
        setTitlePercentTipAmountSegmentControl(2, key: highTipKey)
        
        animations.appear(self.upperView, 0.55, 89)
        animations.appear(self.middleView, 0.65, 225)
        animations.appear(self.lowerView, 0.75, 269)
        
        calculateTip(percentTipAmount)
        
        billAmount.becomeFirstResponder()
        
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        animations.disappear(self.upperView, 0.55)
        animations.disappear(self.middleView, 0.65)
        animations.disappear(self.lowerView, 0.75)
        
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        print("onTap")
        // view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(billAmount.text!) ?? 0
        let key = mapPercentTipAmountSegmentToKey(percentTipAmount.selectedSegmentIndex)
        let tipAmount = bill * tipPercentages[key]!
        let totalAmount = bill + tipAmount
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    private func setTitlePercentTipAmountSegmentControl(_ index: Int, key: String)
    {
        let percentage:Double = tipPercentages[key]! * 100
        let title = String(format: "%.0f%%", percentage)
        percentTipAmount.setTitle(title, forSegmentAt: index)
    }
    
    private func mapPercentTipAmountSegmentToKey(_ index: Int) -> String
    {
        switch(index)
        {
        case 0:
            return lowTipKey
        case 1:
            return mediumTipKey
        default:
            return highTipKey
        }
    }
    
    private func getSetTipPercentageSetting(_ key: String, override: Bool = false) -> Double
    {
        let value:Double;
        if ((defaults.object(forKey: key) as? Double) == nil || override)
        {
            value = tipPercentages[key]!
            defaults.set(value, forKey: key)
            defaults.synchronize()
        }
        else
        {
            value = defaults.double(forKey: key)
        }
        return value
    }
}

