//
//  LoginViewController.swift
//  mysqlSwift
//
//  Created by shin on 2018/02/13.
//  Copyright © 2018年 nishun0419. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var IDtext: UITextField!
    @IBOutlet weak var Passtext: UITextField!
    @IBOutlet weak var errorlog: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func form(_ sender: Any) {
        let id = IDtext.text;
        let pass = Passtext.text;
        var errorflag = false;
        
        if(id != "" || pass != ""){
            let requestURL = NSURL(string: "http:192.168.33.10/Adduser/hack/login.hh");
            let request = NSMutableURLRequest(url: requestURL! as URL);
            
            request.httpMethod = "POST";
            let postParam = "id="+id! + "&password="+pass!;
            request.httpBody = postParam.data(using: String.Encoding.utf8);
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if error != nil{
                    print("error is a \(error!)");
                    return;
                }
                
                do{
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary;
                    if let parseJSON = myJSON{
                        if(parseJSON["error"] != nil){
                            errorflag = true;
                            if(parseJSON["error"] as! String == "loginerror"){
                                DispatchQueue.main.async {
                                    self.errorlog.text = "ログインIDが違います";
                                }
                                return;
                            
                            }
                            else if(parseJSON["error"] as! String == "passerror"){
                                DispatchQueue.main.async {
                                    self.errorlog.text = "パスワードが違います";
                                }
                                return;
                            }
                        }
                        else{
                            let resID = parseJSON["userid"] as! String;
                            let resPass = parseJSON["password"] as! String;
                            print (resID);
                            print(resPass);
                            let userDefaults = UserDefaults.standard;
                            userDefaults.set(resID, forKey: "id");
                        
                        }
                    }
                    
                }catch{
                    print(error);
                }
            }
            task.resume();
            if(errorflag == false){
                let mypageviewcontroller: MypageViewController = self.storyboard?.instantiateViewController(withIdentifier: "mypage") as! MypageViewController;
                self.present(mypageviewcontroller,animated: true, completion: nil);
            }
        }
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
