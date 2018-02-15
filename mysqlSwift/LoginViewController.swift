//
//  LoginViewController.swift
//  mysqlSwift
//
//  Created by shin on 2018/02/13.
//  Copyright © 2018年 nishun0419. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class LoginViewController: UIViewController {
    @IBOutlet weak var IDtext: UITextField!
    @IBOutlet weak var Passtext: UITextField!
    @IBOutlet weak var errorlog: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
//        let mypageviewcontroller: MypageViewController = self.storyboard?.instantiateViewController(withIdentifier: "mypage") as! MypageViewController;
//        self.present(mypageviewcontroller, animated:true, completion: nil);
        if(UserDefaults.standard.string(forKey: "id") != nil){
        self.errorlog.text=UserDefaults.standard.string(forKey: "id");
        }

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
        
        var data:Data?
        var response:URLResponse?
        var error:Error?
        
        if(id != "" || pass != ""){
            let requestURL = URL(string: "http://ec2-18-219-91-77.us-east-2.compute.amazonaws.com/Adduser/hack/login.hh");
            let request = NSMutableURLRequest(url: requestURL! as URL);
            
            request.httpMethod = "POST";
            let postParam = "id="+id! + "&password="+pass!;
            request.httpBody = postParam.data(using: String.Encoding.utf8);
            
//            let task = URLSession.shared.synchronousDataTask(with: request as URLRequest){
            (data, response, error) = execute(request as URLRequest);
                if error != nil{
                    print("error is a \(error!)");
                    return;
                }
                
                do{
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary;
                    if let parseJSON = myJSON{
                        if(parseJSON["error"] != nil){
                            if(parseJSON["error"] as! String == "loginerror"){
                                DispatchQueue.main.async {
                                    self.errorlog.text = "ログインIDが違います";
                                    errorflag = true;
                                }
                                return;
                            
                            }
                            else if(parseJSON["error"] as! String == "passerror"){
                                DispatchQueue.main.async {
                                    self.errorlog.text = "パスワードが違います";
                                    errorflag = true;
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
        else{
            self.errorlog.text="idとpasswordを入力してください";
            errorflag = true;
        }
            if(errorflag == false){
                let tabviewcontroller:RAMAnimatedTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabfirst") as! RAMAnimatedTabBarController;
                self.present(tabviewcontroller,animated: true, completion: nil);
            }
        }
    
    
func execute(_ request: URLRequest) -> (Data?, URLResponse?, Error?) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    var d:Data? = nil
    var r:URLResponse? = nil
    var e:Error? = nil
    let semaphore = DispatchSemaphore(value: 0)
    let task = session.dataTask(with: request) { (data, response, error) in
        d = data
        r = response
        e = error
        semaphore.signal()
        
    }
    task.resume()
    // 戻り値を無視
    _ = semaphore.wait(timeout: .distantFuture)
    return (d, r, e)
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
