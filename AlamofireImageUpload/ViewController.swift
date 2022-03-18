//
//  ViewController.swift
//  AlamofireImageUpload
//
//  Created by MacBook on 23.02.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private var myImageView = UIImageView()
    private var myIndicator = UIActivityIndicatorView()
    private var myLabel = UILabel()
    private var myProgressView = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createImageView()
        createIndicator()
        createLabel()
        createProgressView()
        getImage()
    }
    
    private func createImageView() {
        myImageView = UIImageView(frame: self.view.bounds)
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFit
        myImageView.center = view.center
        view.addSubview(myImageView)
    }
    
    private func createIndicator() {
        myIndicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x,
        y: 670,width: 0,height: 0))
        myIndicator.color = UIColor.gray
        myIndicator.startAnimating()
        view.addSubview(myIndicator)
    }
    
    private func createLabel() {
        myLabel = UILabel(frame: CGRect(x: 100, y: 580, width: 200, height: 100))
        myLabel.text = "completed"
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.textAlignment = .center
        view.addSubview(myLabel)
    }
    
    private func createProgressView() {
        myProgressView = UIProgressView(frame: CGRect(x: 45, y: 600, width: 300, height: 50))
        myProgressView.progressViewStyle = .default
        myProgressView.progressTintColor = UIColor.systemBlue
        myProgressView.trackTintColor = UIColor.systemRed
        view.addSubview(myProgressView)
    }
    
    private func getImage() {
        AF.download("https://243408.selcdn.ru/blog/2021/04/kosmos-2.jpg")
            .validate()
            .downloadProgress { progress in
                self.myLabel.text = progress.localizedDescription
                self.myProgressView.setProgress(Float(progress.fractionCompleted), animated: true)
            }
            .responseData { (response) in
            
            if let data = response.value {
                
                self.myImageView.image = UIImage(data: data)
                
            }else {
                self.myLabel.text = "Ошибка загрузки"
            }
                
                self.myIndicator.stopAnimating()
                
                self.myProgressView.isHidden = true
                
            }
        }
    }
    


