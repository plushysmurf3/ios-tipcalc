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

    private static var isFirstLoad = true
    private var tipPercentages:[String:Double] = [
        "lowTip" : 0.1,
        "mediumTip" : 0.15,
        "highTip" : 0.2
    ]
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentTipAmount: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipPercentages["lowTip"] = getSetTipPercentageSetting("lowTip", override: true)
        tipPercentages["mediumTip"] = getSetTipPercentageSetting("mediumTip", override: true)
        tipPercentages["highTip"] = getSetTipPercentageSetting("highTip", override: true)
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
        
        tipPercentages["lowTip"] = getSetTipPercentageSetting("lowTip", override: overrideUserDefaults)
        tipPercentages["mediumTip"] = getSetTipPercentageSetting("mediumTip", override: overrideUserDefaults)
        tipPercentages["highTip"] = getSetTipPercentageSetting("highTip", override: overrideUserDefaults)
        
        setTitlePercentTipAmountSegmentControl(0, key: "lowTip")
        setTitlePercentTipAmountSegmentControl(1, key: "mediumTip")
        setTitlePercentTipAmountSegmentControl(2, key: "highTip")
        
        appearAnimation(self.upperView, 0.55, 89)
        appearAnimation(self.middleView, 0.65, 225)
        appearAnimation(self.lowerView, 0.75, 269)
        
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        disappearAnimation(self.upperView, 0.55)
        disappearAnimation(self.middleView, 0.65)
        disappearAnimation(self.lowerView, 0.75)
        
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        print("onTap")
        view.endEditing(true)
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
            return "lowTip"
        case 1:
            return "mediumTip"
        default:
            return "highTip"
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
    
    private func appearAnimation(_ view: UIView, _ duration: Double, _ offset: CGFloat) {
        let screenSize: CGRect = UIScreen.main.bounds
        view.alpha = 0
        view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height + view.frame.height)
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1
            view.center = CGPoint(x: screenSize.width / 2, y: view.frame.height / 2 + offset)
        })
    }
    
    private func disappearAnimation(_ view: UIView, _ duration: Double) {
        let screenSize: CGRect = UIScreen.main.bounds
        view.alpha = 1
        view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height + view.frame.height)
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
            view.center = CGPoint(x: screenSize.width / 2, y: screenSize.height + view.frame.height)
            
        })
    }
}

