//
//  ViewController.swift
//  ExchangeCoin
//
//  Created by Pattanan Prarom on 1/4/2566 BE.
//

import UIKit

var coinManager = CoinManager()

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate  {
    
    @IBOutlet weak var bitLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
                  self.bitLabel.text = price
                  self.currencyLabel.text = currency
              }
    }
    
    func didFailWithError(error: Error) {
        print(error)
        print("Something went wrong")
    }
    
}






