//
//  CameraService.swift
//  ModelIt
//
//  Created by HouPeihong on 2023/7/15.
//

import SwiftUI
import UIKit
import AVFoundation

public struct Photo: Identifiable, Equatable {
    public var id: String
    public var originalData: Data
    
    public init(id: String = UUID().uuidString, originalData: Data) {
        self.id = id
        self.originalData = originalData
    }
}

extension Photo {
    public var compressedData: Data? {
        //todo: 这里差三倍，目标是480
        ImageResizer(targetWidth: 160).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
    }
    public var thumbnailData: Data? {
        ImageResizer(targetWidth: 100).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
    }
    public var thumbnailImage: UIImage? {
        guard let data = thumbnailData else { return nil }
        return UIImage(data: data)
    }
    public var image: UIImage? {
        guard let data = compressedData else { return nil }
        return UIImage(data: data)
    }
}

//dynamic var videoDeviceInputX: AVCaptureDeviceInput?

public class CameraService: NSObject, Identifiable {
    typealias PhotoCaptureSessionID = String
    
    
    
    
    @Published public var photo: Photo?
    @Published public var willCapturePhoto = false
    
    public let session = AVCaptureSession()
    // Communicate with the session and other session objects on this queue.
    let sessionQueue = DispatchQueue(label: "session queue")
    
    
    @objc dynamic var videoDeviceInput: AVCaptureDeviceInput? //TODO: check, remove this will be crash, why?
    @objc dynamic var videoDeviceInput2: AVCaptureDeviceInput?
    
    var isSessionRunning = false
    
    // MARK: Device Configuration Properties
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInDualCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    // MARK: Capturing Photos
    
    let photoOutput = AVCapturePhotoOutput()
    
    var inProgressPhotoCaptureDelegates = [Int64: PhotoCaptureProcessor]()
    
    @Published public var photoCache: [Data] = []
//    var photoCaptureProcessor:PhotoCaptureProcessor
    
    public func configure() {
        
        if !self.isSessionRunning/* && !self.isConfigured*/ {
            /*
             Setup the capture session.
             In general, it's not safe to mutate an AVCaptureSession or any of its
             inputs, outputs, or connections from multiple threads at the same time.
             
             Don't perform these tasks on the main queue because
             AVCaptureSession.startRunning() is a blocking call, which can
             take a long time. Dispatch session setup to the sessionQueue, so
             that the main queue isn't blocked, which keeps the UI responsive.
             */
//            print(self.videoDeviceInput)
            sessionQueue.async {
                self.configureSession()
            }
        }
    }
    
    // Call this on the session queue.
    /// - Tag: ConfigureSession
    private func configureSession() {
//        if setupResult != .success {
//            return
//        }
        
        session.beginConfiguration()
        
        /*
         Do not create an AVCaptureMovieFileOutput when setting up the session because
         Live Photo is not supported when AVCaptureMovieFileOutput is added to the session.
         */
//        session.sessionPreset = .photo
        session.sessionPreset = .hd1280x720
        
//        var selectedDimension:CMVideoDimensions
        // Add video input.
        do {
            var defaultVideoDevice: AVCaptureDevice?
            
            if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                // If a rear dual camera is not available, default to the rear wide angle camera.
                defaultVideoDevice = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                defaultVideoDevice = frontCameraDevice
            }
            
            guard let videoDevice = defaultVideoDevice else {
                print("Default video device is unavailable.")
//                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
            
            print("supported photo dimensions \(String(describing: defaultVideoDevice?.activeFormat.supportedMaxPhotoDimensions))")
            
            
//            selectedDimension = defaultVideoDevice?.activeFormat.supportedMaxPhotoDimensions[0] ?? CMVideoDimensions(width:1920, height:1080)
//            videoDevice.dim = defaultVideoDevice?.activeFormat.supportedMaxPhotoDimensions[0]
            
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
                
//                print(isSessionRunning)
//                print(videoDeviceInput)
//                print(self.videoDeviceInput ?? nil)
//                if(nil != self.videoDeviceInput) {
//                    self.videoDeviceInput = nil
//                }
//                videoDeviceInputX = videoDeviceInput
//                                print(videoDeviceInputX)
//                print(self.photox)
//                self.videoDeviceInput = videoDeviceInput
                self.videoDeviceInput2 = videoDeviceInput
                
            } else {
                print("Couldn't add video device input to the session.")
//                setupResult = .configurationFailed
                session.commitConfiguration()
                return
            }
        } catch {
            print("Couldn't create video device input: \(error)")
//            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        // Add the photo output.
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            
            
//            photoOutput.maxPhotoDimensions = CMVideoDimensions(width:1920, height:1080)
            photoOutput.maxPhotoQualityPrioritization = .quality
            
        } else {
            print("Could not add photo output to the session")
//            setupResult = .configurationFailed
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
//        self.isConfigured = true
        
        self.start()
    }
    
    /// - Tag: ChangeCamera
    public func changeCamera() {
        //        MARK: Here disable all camera operation related buttons due to configuration is due upon and must not be interrupted
//        DispatchQueue.main.async {
//            self.isCameraButtonDisabled = true
//        }
//        //
        
        sessionQueue.async {
            let currentVideoDevice = self.videoDeviceInput2!.device
            let currentPosition = currentVideoDevice.position
            
            let preferredPosition: AVCaptureDevice.Position
            let preferredDeviceType: AVCaptureDevice.DeviceType
            
            switch currentPosition {
            case .unspecified, .front:
                preferredPosition = .back
                preferredDeviceType = .builtInWideAngleCamera
                
            case .back:
                preferredPosition = .front
                preferredDeviceType = .builtInWideAngleCamera
                
            @unknown default:
                print("Unknown capture position. Defaulting to back, dual-camera.")
                preferredPosition = .back
                preferredDeviceType = .builtInWideAngleCamera
            }
            let devices = self.videoDeviceDiscoverySession.devices
            var newVideoDevice: AVCaptureDevice? = nil
            
            // First, seek a device with both the preferred position and device type. Otherwise, seek a device with only the preferred position.
            if let device = devices.first(where: { $0.position == preferredPosition && $0.deviceType == preferredDeviceType }) {
                newVideoDevice = device
            } else if let device = devices.first(where: { $0.position == preferredPosition }) {
                newVideoDevice = device
            }
            
            if let videoDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                    
                    self.session.beginConfiguration()
                    
                    // Remove the existing device input first, because AVCaptureSession doesn't support
                    // simultaneous use of the rear and front cameras.
                    
                    self.session.removeInput(self.videoDeviceInput2!)
                    if self.session.canAddInput(videoDeviceInput) {
                        
                        
                        NotificationCenter.default.removeObserver(self, name: .AVCaptureDeviceSubjectAreaDidChange, object: currentVideoDevice)
//                        NotificationCenter.default.addObserver(self, selector: #selector(self.subjectAreaDidChange), name: .AVCaptureDeviceSubjectAreaDidChange, object: videoDeviceInput.device)
                        
                        self.session.addInput(videoDeviceInput)
                        self.videoDeviceInput2 = videoDeviceInput
                    }
                    else {
                        self.session.addInput(self.videoDeviceInput!)
                    }
                    
                    if let connection = self.photoOutput.connection(with: .video) {
                        if connection.isVideoStabilizationSupported {
                            connection.preferredVideoStabilizationMode = .auto
                        }
                    }
                    
                    self.photoOutput.maxPhotoQualityPrioritization = .quality
                    
                    self.session.commitConfiguration()
                } catch {
                    print("Error occurred while creating video device input: \(error)")
                }
            }
            
//            DispatchQueue.main.async {
//                //                MARK: Here enable all camera operation related buttons due to succesfull setup
//                self.isCameraButtonDisabled = false
//            }
        }
    }
    
    @objc public func start() {
//        assert(self.videoDeviceInput == nil)
        sessionQueue.async {
//            self.addObservers()
            self.session.startRunning()
//            print("CAMERA RUNNING")
            self.isSessionRunning = self.session.isRunning
            
//            if self.session.isRunning {
//                DispatchQueue.main.async {
//                    self.isCameraButtonDisabled = false
//                    self.isCameraUnavailable = false
//                }
//            }
        }
    }
    
//    public func set(zoom: CGFloat){
//        let factor = zoom < 1 ? 1 : zoom
//        let device = self.videoDeviceInput!.device
//
//        do {
//            try device.lockForConfiguration()
//            device.videoZoomFactor = factor
//            device.unlockForConfiguration()
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//    }
    
    //    MARK: Capture Photo
    
    /// - Tag: CapturePhoto
    public func capturePhoto() {
        /*
         Retrieve the video preview layer's video orientation on the main queue before
         entering the session queue. This to ensures that UI elements are accessed on
         the main thread and session configuration is done on the session queue.
         */
    
        print("capture photo ...")
        let videoPreviewLayerOrientation: AVCaptureVideoOrientation = .portrait
        
        sessionQueue.async {
            
            print("capture photo session queue ...")
            if let photoOutputConnection = self.photoOutput.connection(with: .video) {
                photoOutputConnection.videoOrientation = videoPreviewLayerOrientation
            }
            
            guard self.photoOutput.availablePhotoPixelFormatTypes.first != nil else {
                        return
                    }
            
            print("self.photoOutput.availablePhotoPixelFormatTypes == \(self.photoOutput.availablePhotoPixelFormatTypes)")
            for type in self.photoOutput.availablePhotoPixelFormatTypes
            {
                print("=====\(CVPixelBufferTypeToName(type:type))")
            }
            
            //TODO: 合适的format
            let photoSettings = AVCapturePhotoSettings(format: [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]);
//
//            let photoSettings = AVCapturePhotoSettings(rawPixelFormatType: availableRawFormat,
//                                                       processedFormat: [AVVideoCodecKey : AVVideoCodecType.hevc])
            
            // Capture HEIF photos when supported. Enable according to user settings and high-resolution photos.
//            if  self.photoOutput.availablePhotoCodecTypes.contains(.hevc) {
//                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
//            }
            
            if !photoSettings.__availablePreviewPhotoPixelFormatTypes.isEmpty {
                photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.__availablePreviewPhotoPixelFormatTypes.first!]
            }
            
            photoSettings.photoQualityPrioritization = .speed
            
            let photoCaptureProcessor = PhotoCaptureProcessor(with: photoSettings, willCapturePhotoAnimation: {
                // Flash the screen to signal that AVCam took a photo.
                DispatchQueue.main.async {
                    self.willCapturePhoto.toggle()
                    self.willCapturePhoto.toggle()
                }
            }, completionHandler: { (photoCaptureProcessor) in
                // When the capture is complete, remove a reference to the photo capture delegate so it can be deallocated.
                if let data = photoCaptureProcessor.photoData {
                    self.photo = Photo(originalData: data)
                    print("passing photo \(String(describing: self.photo?.id))")
                    
                    if(self.photoCache.count > 10) {
                        self.photoCache.remove(at: 0)
                    }
                    self.photoCache.append(self.photo?.compressedData ?? Data())
                    
                    print("Capture photo ... done!")
//                    print("self.photoCache ==> ")
//                    print(self.photoCache)
//                    print(PhotoCaptureProcessor.sfmData)
                    
                    
                    //TODO: do something with this photo cache
//                    let str = String(decoding: self.photoCache[0], as: UTF8.self)
                    
                    
//                    let sfmData: SfMData
//                    Pipeline_FeatureExtraction(UnsafeMutableRawPointer(mutating: self.photoCache))
                    
                    
                } else {
                    print("No photo data")
                }
                
                self.sessionQueue.async {
                    self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = nil
                }
            })
            
            // The photo output holds a weak reference to the photo capture delegate and stores it in an array to maintain a strong reference.
            self.inProgressPhotoCaptureDelegates[photoCaptureProcessor.requestedPhotoSettings.uniqueID] = photoCaptureProcessor
            self.photoOutput.capturePhoto(with: photoSettings, delegate: photoCaptureProcessor)
        }
    }
    
}
