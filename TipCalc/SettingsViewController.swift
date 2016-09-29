//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Savio Tsui on 9/26/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let defaults = UserDefaults.standard
    var tipPercentages:[Double] = [0.1, 0.15, 0.2]
    
    @IBOutlet weak var lowTipSlider: UISlider!
    @IBOutlet weak var mediumTipSlider: UISlider!
    @IBOutlet weak var highTipSlider: UISlider!
    
    @IBOutlet weak var lowTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var highTipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let lowTip = defaults.double(forKey: "lowTip") * 100
        let mediumTip = defaults.double(forKey: "mediumTip") * 100
        let highTip = defaults.double(forKey: "highTip") * 100
        
        lowTipLabel.text = String(format: "%.0f%%", lowTip)
        mediumTipLabel.text = String(format: "%.0f%%", mediumTip)
        highTipLabel.text = String(format: "%.0f%%", highTip)
        
        lowTipSlider.value = Float(lowTip)
        mediumTipSlider.value = Float(mediumTip)
        highTipSlider.value = Float(highTip)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChangedLowTipSlider(_ sender: UISlider) {
        onChangedTipSlider(Double(sender.value), key: "lowTip", label: lowTipLabel)
    }
    
    @IBAction func onChangedMediumTipSlider(_ sender: UISlider) {
        onChangedTipSlider(Double(sender.value), key: "mediumTip", label: mediumTipLabel)
    }
    
    @IBAction func onChangedHighTipSlider(_ sender: UISlider) {
        onChangedTipSlider(Double(sender.value), key: "highTip", label: highTipLabel)
    }
    
    private func onChangedTipSlider(_ value: Double, key: String, label: UILabel) {
        let percentage:Double = round(value) / 100
        defaults.set(percentage, forKey: key)
        defaults.synchronize()
        label.text = String(format: "%.0f%%", value)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
