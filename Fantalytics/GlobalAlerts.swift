//
//  Helpers.swift
//  Fantalytics
//
//  Created by Vik Denic on 12/7/15.
//  Copyright © 2015 nektar labs. All rights reserved.
//

import UIKit

func showAlert(title : String!, message : String!, viewController : UIViewController)
{
    let alert : UIAlertController = UIAlertController(title: title,
        message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
    viewController.presentViewController(alert, animated: true, completion: nil)
}

func showAlertWithError(error : NSError!, forVC : UIViewController)
{
    let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(okAction)
    forVC.presentViewController(alert, animated: true, completion: nil)
}