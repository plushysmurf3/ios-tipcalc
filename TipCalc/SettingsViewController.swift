//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Savio Tsui on 9/26/16.
//  Copyright © 2016 Savio Tsui. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    private let lowTipKey = "lowTip"
    private let mediumTipKey = "mediumTip"
    private let highTipKey = "highTip"
    
    let defaults = UserDefaults.standard
    var tipPercentages:[Double] = [0.1, 0.15, 0.2]
    
    var animations: Animations!
    
    @IBOutlet weak var lowTipView: UIView!
    @IBOutlet weak var mediumTipView: UIView!
    @IBOutlet weak var highTipView: UIView!
    
    @IBOutlet weak var lowTipSlider: UISlider!
    @IBOutlet weak var mediumTipSlider: UISlider!
    @IBOutlet weak var highTipSlider: UISlider!
    
    @IBOutlet weak var lowTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var highTipLabel: UILabel!
    
    private func initDependencies(animations: Animations) {
        self.animations = animations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // need to figure out how to correctly do dependency injection
        initDependencies(animations: Animations())
        
        // Do any additional setup after loading the view.
        let lowTip = defaults.double(forKey: lowTipKey) * 100
        let mediumTip = defaults.double(forKey: mediumTipKey) * 100
        let highTip = defaults.double(forKey: highTipKey) * 100
        
        lowTipLabel.text = String(format: "%.0f%%", lowTip)
        mediumTipLabel.text = String(format: "%.0f%%", mediumTip)
        highTipLabel.text = String(format: "%.0f%%", highTip)
        
        lowTipSlider.value = Float(lowTip)
        mediumTipSlider.value = Float(mediumTip)
        highTipSlider.value = Float(highTip)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animations.appear(lowTipView, 0.55, 245)
        animations.appear(mediumTipView, 0.65, 300)
        animations.appear(highTipView, 0.75, 354)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChangedLowTipSlider(_ sender: UISlider) {
        onChangedTipSlider(Double(sender.value), key: lowTipKey, label: lowTipLabel)
    }
    
    @IBAction func onChangedMediumTipSlider(_ sender: UISlider) {
        onChangedTipSlider(Double(sender.value), key: mediumTipKey, label: mediumTipLabel)
    }
    
    @IBAction func onChangedHighTipSlider(_ sender: UISlider) {
        onChangedTipSlider(Double(sender.value), key: highTipKey, label: highTipLabel)
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
