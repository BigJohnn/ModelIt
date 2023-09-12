//
//  ContentView.swift
//  ModelIt
//
//  Created by HouPeihong on 2023/7/13.
//

import SwiftUI
import UIKit
import AVFoundation
import Combine

final class CameraModel: ObservableObject {
    private let service = CameraService()
    
    @Published var photo: Photo!
    
    @Published var willCapturePhoto = false
    
    @Published var imagesCached: [Data] = []
    
    var session: AVCaptureSession
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$photo.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.photo = pic
        }
        .store(in: &self.subscriptions)
        
        service.$willCapturePhoto.sink { [weak self] (val) in
            self?.willCapturePhoto = val
        }
        .store(in: &self.subscriptions)
        
        service.$photoCache.sink { [weak self] (val) in
            self?.imagesCached = val
        }
        .store(in: &self.subscriptions)
        
        /// Pipeline entrance
        Pipeline_CameraInit()
        let tmpDirURL = FileManager.default.temporaryDirectory
        Pipeline_SetOutputDataDir(tmpDirURL.absoluteString)
        
    }
    
    func configure() {
        //TODO: 加回来
//        service.checkForPermissions()
        service.configure()
    }
    
    func capturePhoto() {
        service.capturePhoto()
        self.imagesCached = service.photoCache
    }
    
    func flipCamera() {
        service.changeCamera()
    }
    
    func zoom(with factor: CGFloat) {
        service.set(zoom: factor)
    }
}

struct CameraView: View {
    @StateObject var model = CameraModel()
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    @State var filteredUIImage: [UIImage] = []
    
    var captureButton: some View {
        Button(action: {
            model.capturePhoto()
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 65, height: 65, alignment: .center)
                )
        })
    }
    
    var featureExtractButton: some View {
        Button(action: {
            
            Pipeline_FeatureExtraction()
            
            Pipeline_FeatureMatching()
            
        }, label: {
            Text("FeatureExtraction")
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
//                .overlay(
//                    Circle()
//                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
//                        .frame(width: 65, height: 65, alignment: .center)
//                )
        })
    }
    
    var capturedPhotoThumbnail: some View {
        Group {
            if model.photo != nil {
                Image(uiImage: model.photo.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.black)
            }
        }
    }
    
    var flipCameraButton: some View {
        Button(action: {
            model.flipCamera()
        }, label: {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        })
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        CameraPreview(session: model.session)
                            .gesture(
                                DragGesture().onChanged({ (val) in
                                    //  Only accept vertical drag
                                    if abs(val.translation.height) > abs(val.translation.width) {
                                        //  Get the percentage of vertical screen space covered by drag
                                        let percentage: CGFloat = -(val.translation.height / reader.size.height)
                                        //  Calculate new zoom factor
                                        let calc = currentZoomFactor + percentage
                                        //  Limit zoom factor to a maximum of 5x and a minimum of 1x
                                        let zoomFactor: CGFloat = 1//min(max(calc, 1), 5)
                                        //  Store the newly calculated zoom factor
                                        currentZoomFactor = zoomFactor
                                        //  Sets the zoom factor to the capture device session
                                        model.zoom(with: zoomFactor)
                                    }
                                })
                            )
                            .onAppear {
                                model.configure()
                            }
                            .overlay(
                                Group {
                                    if model.willCapturePhoto {
                                        Color.black
                                    }
                                }
                            )
//                            .animation(.easeInOut)
                        
                        
                        HStack {
                            NavigationLink(destination:
                                            ThumbnailView(filteredUIImage: model.imagesCached)
                            ) {
                                capturedPhotoThumbnail
                            }
                            
                            Spacer()
                            
                            captureButton
                            
                            Spacer()
                            
                            flipCameraButton
                            
                            Spacer()
                            
                            featureExtractButton
                            
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            CameraView()            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
