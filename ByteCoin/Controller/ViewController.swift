//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManadger = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManadger.delegate = self
        
        let initCurrency = coinManadger.currencyArray[0]
        currencyLabel.text = initCurrency
        coinManadger.getCoinPrice(for: initCurrency)
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManadger.currencyArray.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManadger.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManadger.currencyArray[row]
        
        coinManadger.getCoinPrice(for: currency)
        currencyLabel.text = currency
    }
}

extension ViewController: CoinManagerDelegate {
    func didGetExchangeRate(_ manager: CoinManager, exchageRate: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", exchageRate)
        }
    }
}

