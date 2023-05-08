//
//  ViewController.swift
//  project2
//
//  Created by Stratton McDonald on 10/6/21.
//

import UIKit

class ccVC: UIViewController {

    @IBOutlet var gallonsField: UITextField!
    @IBOutlet var pintsField: UITextField!
    @IBOutlet var quartsField: UITextField!
    @IBOutlet var cupsField: UITextField!
    @IBOutlet var tbspField: UITextField!
    @IBOutlet var tspField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        gallonsField.resignFirstResponder()
        pintsField.resignFirstResponder()
        quartsField.resignFirstResponder()
        cupsField.resignFirstResponder()
        tbspField.resignFirstResponder()
        tspField.resignFirstResponder()
    }
    
    @IBAction func gallonChanged(_ gallonsField: UITextField) {
        let g : Float? = Float(gallonsField.text!)
        if (g != nil) {
        pintsField.text = String(g!*8)
        quartsField.text = String(g!*4)
        cupsField.text = String(g!*16)
        tbspField.text = String(g!*256)
        tspField.text = String(g!*768)
        } else {
            pintsField.text = ""
            quartsField.text = ""
            cupsField.text = ""
            tbspField.text = ""
            tspField.text = ""
        }
    }

    @IBAction func convPint(_ pintsField: UITextField){
        let g : Float? = Float(pintsField.text!)
        if (g != nil) {
        gallonsField.text = String(g!/8)
        quartsField.text = String(g!/2)
        cupsField.text = String(g!*2)
        tbspField.text = String(g!*32)
        tspField.text = String(g!*96)
        } else {
            gallonsField.text = ""
            quartsField.text = ""
            cupsField.text = ""
            tbspField.text = ""
            tspField.text = ""
        }
    }
    
    @IBAction func convQuart(_ quartsField: UITextField){
        let g : Float? = Float(quartsField.text!)
        if (g != nil) {
        pintsField.text = String(g!*2)
        gallonsField.text = String(g!/4)
        cupsField.text = String(g!*4)
        tbspField.text = String(g!*64)
        tspField.text = String(g!*192)
        } else {
            pintsField.text = ""
            gallonsField.text = ""
            cupsField.text = ""
            tbspField.text = ""
            tspField.text = ""
        }
    }
    
    @IBAction func convCups(_ cupsField: UITextField){
        let g : Float? = Float(cupsField.text!)
        if (g != nil) {
        pintsField.text = String(g!/2)
        quartsField.text = String(g!/4)
        gallonsField.text = String(g!/16)
        tbspField.text = String(g!*16)
        tspField.text = String(g!*48)
        } else {
            pintsField.text = ""
            quartsField.text = ""
            gallonsField.text = ""
            tbspField.text = ""
            tspField.text = ""
        }
    }
    
    @IBAction func convTBSP(_ tbspField: UITextField){
        let g : Float? = Float(tbspField.text!)
        if (g != nil) {
        pintsField.text = String(g!/32)
        quartsField.text = String(g!/64)
        cupsField.text = String(g!/16)
        gallonsField.text = String(g!/256)
        tspField.text = String(g!*3)
        } else {
            pintsField.text = ""
            quartsField.text = ""
            cupsField.text = ""
            gallonsField.text = ""
            tspField.text = ""
        }
    }
    
    @IBAction func convTSP(_ tspField: UITextField){
        let g : Float? = Float(tspField.text!)
        if (g != nil) {
        pintsField.text = String(g!/96)
        quartsField.text = String(g!/192)
        cupsField.text = String(g!/48)
        tbspField.text = String(g!/3)
        gallonsField.text = String(g!/768)
        } else {
            pintsField.text = ""
            quartsField.text = ""
            cupsField.text = ""
            tbspField.text = ""
            gallonsField.text = ""
        }
    }
}
