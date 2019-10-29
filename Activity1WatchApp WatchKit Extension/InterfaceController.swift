//
//  InterfaceController.swift
//  Activity1WatchApp WatchKit Extension
//
//  Created by Sruthi on 2019-10-28.
//  Copyright © 2019 Ankita. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
var messageCounter:Int = 0
class InterfaceController: WKInterfaceController, WCSessionDelegate
{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
        
    }
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBOutlet weak var msgFromPhone: WKInterfaceLabel!
    // function to receive message from phone
    
    @IBAction func sendToPhone() {
         if (WCSession.default.isReachable == true)
                {
                    let message1 = ["name":"Pritish",
                        "age":"35"]
        //                as [String : Any]
                    
                    // send the message
                    WCSession.default.sendMessage(message1, replyHandler: nil)
                    messageCounter = messageCounter + 1
                    msgFromPhone.setText("Message Sent")
                    
                }
                        
                    else {
                       messageCounter = messageCounter + 1
                        msgFromPhone.setText("Message Cannot be sent")
                    }
                    
    }
    
    @IBOutlet weak var NameLabel: WKInterfaceLabel!
    @IBOutlet weak var ColorLabel: WKInterfaceLabel!
    //function to send message from watch to phone
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any])
       {
           // Output message to terminal
           print("WATCH: I received a message: \(message)")
           
            let name = message["name"] as! String
            let age = message["age"] as! String
          NameLabel.setText(name)
            ColorLabel.setText(age)
       }
    override func willActivate() {
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("Watch  is Loaded")
        
        if (WCSession.isSupported() == true)
        {
           msgFromPhone.setText("")
            
            // create a communication session with the phone
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else
        {
            msgFromPhone.setText("")
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
