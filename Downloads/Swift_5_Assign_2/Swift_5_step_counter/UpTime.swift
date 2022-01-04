//
//  UpTime.swift
//  Swift_5_Assign_2
//
//  Created by renpeng on 2021/4/22.
//

import Foundation

public class UpTime{
    // MARK: Variables declaration
    public var state : Int = -1
    public var step : Int = -1
    private var posThrs : Double, negThrs : Double, posPeakThrs : Double, negPeakThrs : Double = 0
    
    // MARK: Member functions
    init?(){
        state = 0
        step = 0
        posThrs = 0.3
        negThrs = -0.05
        posPeakThrs = 0.6
        negPeakThrs = -0.3
    }
    
   
    // Your code here to implement the UpTime's algorithm
    // for determining its state and accumulating all steps
    // ...
    
    func upTimeAlg(input: Double)
    {
        
        if state == 0   {
            if input > posThrs{
                state = 1
            }
        }
        
        if state == 1  {
//            print("state: \(state)")
            if input < posThrs {
                state = 4
            }
            
            if input > posPeakThrs {
                state = 2
            }
        }
        
        if state == 2   {
//            print("state: \(state)")
            if input < negPeakThrs {
                state = 3
            }
        }
        
        if state == 3   {
//            print("state: \(state)")
            if input > negPeakThrs {
                state = 5
            }
        }
        
        if state == 4   {
//            print("state: \(state)")
            if input < posThrs{
                state = 0
            }
            if input > posThrs{
                state = 1
            }
        }
        
        if state == 5   {
//            print("state: \(state)")
            if input < negPeakThrs{
                state = 3
            }
            if input > negThrs{
                state = 6
            }
        }
        
        if state == 6 {
            step = step + 1
            //print(step)
            
            if input < posThrs{
                state = 0
            }
            if input > posThrs {
                state = 1
            }
        }
        
    }
}
