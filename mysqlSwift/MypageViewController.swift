//
//  MypageViewController.swift
//  mysqlSwift
//
//  Created by shin on 2018/02/13.
//  Copyright © 2018年 nishun0419. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController {
    @IBOutlet weak var welcomemes: UILabel!
    @IBOutlet weak var UserName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.text = UserDefaults.standard.string(forKey: "id")! + "様";
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id");
        let loginviewcontroller: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController;
        self.present(loginviewcontroller,animated: true, completion: nil);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
