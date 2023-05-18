//
//  ViewController.swift
//  ApiWeather
//
//  Created by Alper Erden on 17.05.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    
    let celciusLabel = UILabel()
    let feelsLabel = UILabel()
    let windLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .white
        let celciusImageView = UIImageView()
        celciusImageView.image = UIImage(systemName: "thermometer.medium")
        view.addSubview(celciusImageView)
        
        celciusImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
            make.width.height.equalTo(60)
        }
        
        
        celciusLabel.text = "20"
        celciusLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        view.addSubview(celciusLabel)
        
        celciusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
        }
        
        let celciusText = UILabel()
        celciusText.text = "Current Temp"
        celciusText.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        view.addSubview(celciusText)
        
        celciusText.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
        }
        
        let feelsImageView = UIImageView()
        feelsImageView.image = UIImage(systemName: "humidity")
        view.addSubview(feelsImageView)
        
        feelsImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        
        feelsLabel.text = "20"
        feelsLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        view.addSubview(feelsLabel)
        
        feelsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let feelsText = UILabel()
        feelsText.text = "Feels Like "
        feelsText.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        view.addSubview(feelsText)
        
        feelsText.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let windImageView = UIImageView()
        windImageView.image = UIImage(systemName: "wind")
        view.addSubview(windImageView)
        
        windImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
            make.width.height.equalTo(60)
        }
        
        
        windLabel.text = "9"
        windLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        view.addSubview(windLabel)
        
        windLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
        }
        
        let windText = UILabel()
        windText.text = "Wind Speed"
        windText.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        view.addSubview(windText)
        
        windText.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
        }
        
        let sendButton = UIButton()
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.black, for: .normal)
        sendButton.backgroundColor = .lightGray
        sendButton.addTarget(self, action: #selector(sendBtnTapped), for: .touchUpInside)
        view.addSubview(sendButton)
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
        }
    }
}
 
extension ViewController {
    @objc func sendBtnTapped() {
        WeatherService().apicall { [weak self] jsonResponse in
            DispatchQueue.main.async {
                if let main = jsonResponse?["main"] as? [String: Any] {
                    if let temp = main["temp"] as? Double {
                        self?.celciusLabel.text = String(temp)
                    }
                    if let feels = main["feels_like"] as? Double {
                        self?.feelsLabel.text = String(feels)
                    }
                    if let wind = jsonResponse?["wind"] as? [String: Any] {
                        if let speed = wind["speed"] as? Double {
                            self?.windLabel.text = String(Int(speed))
                        }
                    }
                }
            }
        }
    }

    
}
