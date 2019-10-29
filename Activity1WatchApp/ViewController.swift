//
//  ViewController.swift
//  Activity1WatchApp
//
//  Created by Sruthi on 2019-10-28.
//  Copyright © 2019 Ankita. All rights reserved.
//

import UIKit
import WatchConnectivity
var messageCounter:Int = 0
class ViewController: UIViewController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    @IBOutlet weak var sendMessageOutput: UILabel!
    // check for WC connection
    override func viewDidLoad() {
        super.viewDidLoad()
     
        print("---PHONE APP LOADED!")
            
            // @TODO: Does the phone support communication with the watch?
            if (WCSession.isSupported() == true) {
                sendMessageOutput.text = "WC is supported!"
                
                // create a communication session with the watch
                let session = WCSession.default
                session.delegate = self
                session.activate()
            }
            else {
                sendMessageOutput.text = "WC NOT supported!"
            }
        }
    
    @IBAction func sentToWatch(_ sender: Any) {
        print("Sending Message to Watch")
               // code for sending message to WATCH
               if (WCSession.default.isReachable == true) {
                   // Here is the message you want to send to the watch
                   // All messages get sent as dictionaries
                   let message = ["name":"Banana",
                                  "color":"Yellow"] as [String : Any]
                   
                   // Send the message
                   WCSession.default.sendMessage(message, replyHandler:nil)
                   messageCounter = messageCounter + 1
                   sendMessageOutput.text = "Message Sent \(messageCounter)"
               }
                   
               else {
                   messageCounter = messageCounter + 1
                   sendMessageOutput.text = "Cannot reach watch! \(messageCounter)"
               }
               
    }
}




