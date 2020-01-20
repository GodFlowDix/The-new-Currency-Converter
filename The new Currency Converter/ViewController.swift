//
//  ViewController.swift
//  The new Currency Converter
//
//  Created by Mike Dix on 1/20/20.
//  Copyright © 2020 Mike Dix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyConverterLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesButtonPressed(_ sender: Any) {
        
        // 1)Request & session
                  // 2) Response & Data
                  //3) Parsing & JSON Serialization
                  
        //1.
                  let url = URL(string: "http://data.fixer.io/api/latest?access_key=f8292ffb94d3472239c39636abf90835")
                  let session = URLSession.shared
                  
                  let task = session.dataTask(with: url!) { (data, response, error) in
                      if error != nil {
                          let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                          let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                      } else {
                        
                        //show user
                        //2.
                        if data != nil {
                            do {
                                //changing our json data into strings, boolean variables etc.
                                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> //mutable contianers let us work with arrays and libraries
                                //Dictionary string to any because all the results from the jason data are different
                                
                                //Async
                                DispatchQueue.main.async {
                                    if let rates = jsonResult["rates"] as? [String : Any] {
                                       // print(rates)
                                        
                                        if let cad = rates["CAD"] as? Double {
                                            self.cadLabel.text = "CAD: \(cad)"
                                        }
                                        if let chf = rates["CHF"] as? Double {
                                            self.chfLabel.text = "CHF: \(chf)"
                                        }
                                        if let gbp = rates["GBP"] as? Double {
                                            self.gbpLabel.text = "GBP: \(gbp)"
                                        }
                                        if let jpy = rates["JPY"] as? Double {
                                            self.jpyLabel.text = "JPY: \(jpy)"
                                        }
                                        if let usd = rates["USD"] as? Double {
                                            self.usdLabel.text = "USD: \(usd)"
                                        }
                                        if let turkish = rates["TRY"] as? Double {
                                            self.tryLabel.text = "TRY: \(turkish)"
                                         }
                                    }
                                    
                                }
                                
                            } catch {
                                print("error")
                            }
                         
                        }
                }
            }
        //starts tasks up
        task.resume()
        }
    }

