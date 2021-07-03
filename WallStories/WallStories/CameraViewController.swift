//
//  CameraViewController.swift
//  WallStories
//
//  Created by Hoa Nguyen X. [2] VN.Danang on 6/6/21.
//

import UIKit
import AVFoundation

final class CameraViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet private weak var takeButton: UIButton!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var sourceCameraButton: UIButton!

    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    private var camera: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForImageView()
    }

    private func addGestureForImageView() {
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnImage)))
    }

    @objc private func tapOnImage() {
        guard let photo = photoImageView.image else {
            return
        }
        let vc = PhotoEditorViewController()
        vc.viewModel = PhotoEditorViewModel(image: photo)
        modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Setup your camera here...

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        handleCameraDevice()
        setupLivePreview()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }

    func setupLivePreview() {
        cameraView.clipsToBounds = true
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)

        //Step12
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
            //Step 13
            DispatchQueue.main.async {
                self?.videoPreviewLayer.frame = self?.cameraView.bounds ?? CGRect()
            }
        }
    }

    private func handleCameraDevice() {
        var device: AVCaptureDevice?
        if camera {
            device = AVCaptureDevice.default(for: AVMediaType.video)
            camera = false
        } else {
            device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            camera = true
        }
            do {
                let input = try AVCaptureDeviceInput(device: device!)
                if !captureSession.inputs.isEmpty {
                    let currentCameraInput: AVCaptureInput = captureSession.inputs[0]
                    captureSession.removeInput(currentCameraInput)
                }
                stillImageOutput = AVCapturePhotoOutput()
                if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                    captureSession.addInput(input)
                    captureSession.addOutput(stillImageOutput)
                }
//                setupLivePreview()
            }
            catch let error  {
                print("Error Unable to initialize camera:  \(error.localizedDescription)")
            }
    }

    private func addAnimationForCapture() {
        let xRandom: Float = Float.random(in: (Float(cameraView.frame.minX + 50)...Float(cameraView.frame.maxX - 50)))
        let yRandom: Float = Float.random(in: (Float(cameraView.frame.minY + 50)...Float(cameraView.frame.maxY - 50)))
        let imageView = UIImageView(frame: CGRect(x: Int(xRandom), y: Int(yRandom), width: 50, height: 50))
        imageView.image = UIImage(named: "icons8-heart-outline-96")
            cameraView.addSubview(imageView)
        cameraView.bringSubviewToFront(imageView)
        UIView.animate(withDuration: 0.5) {
            imageView.bounds.size.height = 300
            imageView.bounds.size.width = 300
        } completion: { (_) in
            imageView.removeFromSuperview()
        }
    }

    // MARK: - @IBAction
    @IBAction private func didTakePhoto(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        addAnimationForCapture()
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }

    @IBAction private func changeCamera(_ sender: UIButton) {
        handleCameraDevice()
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation()
        else { return }
        let image = UIImage(data: imageData)
        photoImageView.image = image
    }
}
