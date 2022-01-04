//
//  ViewController.swift
//  Swift_5_Assign_2
//
//  Created by renpeng on 2021/4/22.
// Modified by Kat Malneva
// Step Counter

import UIKit
import CoreMotion



class ViewController: UIViewController {
    var uptime = UpTime()
    
    // MARK: Outlets setup
    @IBOutlet weak var measurementLabel: UITextView!
    @IBOutlet weak var magnitudeLabel: UITextView!
    @IBOutlet weak var totalStepLabel: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    let motion = CMMotionManager()
    
    
    
    // MARK: Variables setup
    var isStart : Bool = false
    var timer: Timer?
    
    // MARK: ViewController Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetOutlets()
    }
    
    // MARK: ViewController functions
    @IBAction func buttonPressed() {
        if isStart {
            buttonOutlet.setBackgroundImage(UIImage(named:"start"), for: .normal)
            stopAccelerometer()
        }
        else {
            buttonOutlet.setBackgroundImage(UIImage(named:"stop"), for: .normal)
            startAccelerometer()
        }
        isStart = !isStart
    }
    
    /* Helper function for updating the measurement label on screen */
    func updateMeasurementLabel(_ data: CMAcceleration){
        measurementLabel.text = NSString.localizedStringWithFormat("x : %.5f\ny : %.5f\nz : %.5f\n", data.x, data.y, data.z) as String
    }
    
    /* Helper function for clearing all labels on screen */
    func resetOutlets(){
        measurementLabel.text = ""
        magnitudeLabel.text = "Acceleration Magnitude"
        totalStepLabel.text = "Total Step: 0"
    }
    

    func startAccelerometer() {
        var accelVector = 0.0000000000000
        var accelMeasure = CMAcceleration()
        
        
       // Make sure the accelerometer hardware is available.
       if self.motion.isAccelerometerAvailable {
          self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
          self.motion.startAccelerometerUpdates()

          // Configure a timer to fetch the data.
          self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                repeats: true, block: { (timer) in
             // Get the accelerometer data.
                    
             if let data = self.motion.accelerometerData {
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z

                //Magnitude Vector
                accelVector = x*x + y*y + z*z
                accelVector = accelVector.squareRoot() - 1
                self.magnitudeLabel.text = String(accelVector)
                
                //Printing components
                accelMeasure.x = Double(x)
                accelMeasure.y = Double(y)
                accelMeasure.z = Double(z)
                self.updateMeasurementLabel(accelMeasure)
                
                
                //Step counter
                self.uptime?.upTimeAlg(input: accelVector)
                self.totalStepLabel.text = "Total Step: "+String(self.uptime!.step)

              
             }
          })

          // Add the timer to the current run loop.
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
       }
    }
    
    func stopAccelerometer(){
       
        motion.stopAccelerometerUpdates()
    }
    
    
}
