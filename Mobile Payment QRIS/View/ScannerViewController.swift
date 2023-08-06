//
//  ViewController.swift
//  Mobile Payment QRIS
//
//  Created by William Yulio on 05/08/23.
//

import MercariQRScanner
import AVFoundation
import UIKit


class ScannerViewController: UIViewController{
    
    var qrScannerView =  QRScannerView()
    var scannerVM: ScannerViewModel = ScannerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScanner()

    }
    
    private func setupQRScanner() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setupQRScannerView()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        DispatchQueue.main.async { [weak self] in
                            self?.setupQRScannerView()
                        }
                    }
                }
            default:
                showAlert()
            }
        }

    private func setupQRScannerView() {
        qrScannerView = QRScannerView(frame: view.bounds)
        view.addSubview(qrScannerView)
        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: false))
        qrScannerView.startRunning()
        
    }

    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

            qrScannerView.startRunning()
            qrScannerView.rescan()

    }
}

extension ScannerViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print("ada masalah\(error)")
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        
        guard let transactionData = scannerVM.getDataFromQR(result: code) else{
            return
        }
        
        let paymentVM = PaymentViewModel(dataSource: transactionData)
        let paymentDetailVC = PaymentDetailViewController(paymentVM: paymentVM)
        
        self.navigationController?.pushViewController(paymentDetailVC, animated: true)
    }
    
}

