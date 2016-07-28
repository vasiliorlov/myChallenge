//
//  NewRunViewController.swift
//  myChallenge
//
//  Created by iMac on 25.07.16.
//  Copyright © 2016 vasayCo. All rights reserved.
//

import UIKit
import CoreLocation
import HealthKit
import MapKit



class NewRunViewController: UIViewController,CLLocationManagerDelegate {

    //label
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    //map view
    
    @IBOutlet var trackMapView: MKMapView!

    
    var seconds = 0.0
    var distance = 0.0
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    lazy var timer = NSTimer()
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestAlwaysAuthorization()

    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startLocationUpdates() {
        // Here, the location manager will be lazily instantiated
        locationManager.startUpdatingLocation()
    }
    
    func eachSecond(timer: NSTimer) {
        seconds += 1
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
        timeLabel.text = "Time: " + secondsQuantity.description
        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
        distanceLabel.text = "Distance: " + distanceQuantity.description
        
        let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        paceLabel.text = "Pace: " + paceQuantity.description
    }
    
    
    @IBAction func startPressed(sender: AnyObject) {
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepCapacity: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(1,
                                                       target: self,
                                                       selector: #selector(NewRunViewController.eachSecond(_:)),
                                                       userInfo: nil,
                                                       repeats: true)
        startLocationUpdates()
    }
    
    
    @IBAction func finishPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil) 
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations  {
            if location.horizontalAccuracy < 20 {
                //update distance
                if self.locations.count > 0 {
                    distance += location.distanceFromLocation(self.locations.last!)
                }
                
                //save location
                self.locations.append(location)
            }
        }
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - CLLocationManagerDelegate
//extension NewRunViewController: CLLocationManagerDelegate {
//}