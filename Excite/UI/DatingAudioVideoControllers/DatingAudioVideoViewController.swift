//
//  DatingAudioVideoViewController.swift
//  Excite
//
//  Created by Haasith Sanka on 6/19/20.
//  Copyright © 2020 Haasith Sanka. All rights reserved.
//

import UIKit
import TwilioVideo
import NotificationBannerSwift

class DatingAudioVideoViewController: UIViewController {

    var accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzc5YWM3MzQwODMzM2I4MmIxZTlmODZkODI4MWRkNzQ1LTE1OTMyMTk0ODAiLCJncmFudHMiOnsidmlkZW8iOnt9LCJpZGVudGl0eSI6ImlkZW50aXR5In0sImlzcyI6IlNLNzlhYzczNDA4MzMzYjgyYjFlOWY4NmQ4MjgxZGQ3NDUiLCJuYmYiOjE1OTMyMTk0ODAsImV4cCI6MTU5MzIyMzA4MCwic3ViIjoiQUMwNDllNzEwYmE4YTA3ODM1YzU2YmIzNTcxMWJjNGY5NCJ9.pn28uOaJA--zB2WXEkqgIC40wMUQCjVoy12LSBpHg80"
   // Configure remote URL to fetch token from
    var tokenUrl = "http://localhost:8000/token.php"

    // Video SDK components
    var room: Room?
    var camera: CameraSource?
    var previewView = VideoView()
    var localVideoTrack: LocalVideoTrack?
    var localAudioTrack: LocalAudioTrack?
    var remoteParticipant: RemoteParticipant?
    var remoteView: VideoView?
    var connectButton = UIButton()
    var verticalStackview = UIStackView(frame: .zero)
    var horizontalStackview = UIStackView(frame: .zero)
    var roomTextField = UITextField()
    var roomLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeUI()
       //    self.previewView.removeFromSuperview()
        self.startPreview()
// Disconnect and mic button will be displayed when the Client is connected to a Room.
//       self.disconnectButton.isHidden = true
//       self.micButton.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    func logMessage(messageText: String) {
        NSLog(messageText)
        print(messageText)
        let banner = GrowingNotificationBanner(title: "Error", subtitle: messageText, style: .success)
        banner.show()
    }
    override var prefersHomeIndicatorAutoHidden: Bool {
        return self.room != nil
    }
    func setupRemoteVideoView() {
        // Creating `VideoView` programmatically
//        self.remoteView = VideoView(frame: CGRect.zero, delegate: self)
//        self.view.insertSubview(self.remoteView!, at: 0)
//        // `VideoView` supports scaleToFill, scaleAspectFill and scaleAspectFit
//        // scaleAspectFit is the default mode when you create `VideoView` programmatically.
//        self.remoteView!.contentMode = .scaleAspectFit
//        let centerX = NSLayoutConstraint(item: self.remoteView!,
//                                         attribute: NSLayoutConstraint.Attribute.centerX,
//                                         relatedBy: NSLayoutConstraint.Relation.equal,
//                                         toItem: self.view,
//                                         attribute: NSLayoutConstraint.Attribute.centerX,
//                                         multiplier: 1,
//                                         constant: 0)
//        self.view.addConstraint(centerX)
//        let centerY = NSLayoutConstraint(item: self.remoteView!,
//                                         attribute: NSLayoutConstraint.Attribute.centerY,
//                                         relatedBy: NSLayoutConstraint.Relation.equal,
//                                         toItem: self.view,
//                                         attribute: NSLayoutConstraint.Attribute.centerY,
//                                         multiplier: 1,
//                                         constant: 0)
//        self.view.addConstraint(centerY)
//        let width = NSLayoutConstraint(item: self.remoteView!,
//                                       attribute: NSLayoutConstraint.Attribute.width,
//                                       relatedBy: NSLayoutConstraint.Relation.equal,
//                                       toItem: self.view,
//                                       attribute: NSLayoutConstraint.Attribute.width,
//                                       multiplier: 1,
//                                       constant: 0)
//        self.view.addConstraint(width)
//        let height = NSLayoutConstraint(item: self.remoteView!,
//                                        attribute: NSLayoutConstraint.Attribute.height,
//                                        relatedBy: NSLayoutConstraint.Relation.equal,
//                                        toItem: self.view,
//                                        attribute: NSLayoutConstraint.Attribute.height,
//                                        multiplier: 1,
//                                        constant: 0);
//        self.view.addConstraint(height)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        self.remoteView = VideoView(frame: CGRect.zero, delegate: self)
        self.view.insertSubview(self.remoteView!, at: 0)
        self.remoteView!.contentMode = .scaleAspectFit
        remoteView?.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
        })
    }
    @objc func connect(sender: AnyObject) {
        print("connected")
        // Configure access token either from server or manually.
        // If the default wasn't changed, try fetching from server.
        if accessToken == "TWILIO_ACCESS_TOKEN" {
            do {
                accessToken = try TokenUtils.fetchToken(url: tokenUrl)
            } catch {
                let message = "Failed to fetch access token"
                print(message)
                return
            }
        }
        // Prepare local media which we will share with Room Participants.
        self.prepareLocalMedia()
        // Preparing the connect options with the access token that we fetched (or hardcoded).
        let connectOptions = ConnectOptions(token: accessToken) { (builder) in
            // Use the local media that we prepared earlier.
            builder.audioTracks = self.localAudioTrack != nil ? [self.localAudioTrack!] : [LocalAudioTrack]()
            builder.videoTracks = self.localVideoTrack != nil ? [self.localVideoTrack!] : [LocalVideoTrack]()
            // Use the preferred audio codec
            if let preferredAudioCodec = Settings.shared.audioCodec {
                builder.preferredAudioCodecs = [preferredAudioCodec]
            }
            // Use the preferred video codec
            if let preferredVideoCodec = Settings.shared.videoCodec {
                builder.preferredVideoCodecs = [preferredVideoCodec]
            }
            // Use the preferred encoding parameters
            if let encodingParameters = Settings.shared.getEncodingParameters() {
                builder.encodingParameters = encodingParameters
            }
            // Use the preferred signaling region
            if let signalingRegion = Settings.shared.signalingRegion {
                builder.region = signalingRegion
            }
            // The name of the Room where the Client will attempt to connect to. Please note that if you pass an empty
            // Room `name`, the Client will create one for you. You can get the name or sid from any connected Room.
            builder.roomName = self.roomTextField.text
        }
        // Connect to the Room using the options we provided.
            room = TwilioVideoSDK.connect(options: connectOptions, delegate: self)
            logMessage(messageText: "Attempting to connect to room \(String(describing: self.roomTextField.text))")
            self.showRoomUI(inRoom: true)
            self.dismissKeyboard()
    }
    func disconnect(sender: AnyObject) {
        self.room!.disconnect()
        print( "Attempting to disconnect from room \(room!.name)")
    }
    func toggleMic(sender: AnyObject) {
        if self.localAudioTrack != nil {
            self.localAudioTrack?.isEnabled = !(self.localAudioTrack?.isEnabled)!
            // Update the button title
//            if (self.localAudioTrack?.isEnabled == true) {
//                self.micButton.setTitle("Mute", for: .normal)
//            } else {
//                self.micButton.setTitle("Unmute", for: .normal)
//            }
        }
    }
    func renderRemoteParticipant(participant: RemoteParticipant) -> Bool {
           // This example renders the first subscribed RemoteVideoTrack from the RemoteParticipant.
           let videoPublications = participant.remoteVideoTracks
           for publication in videoPublications {
               if let subscribedVideoTrack = publication.remoteTrack,
                   publication.isTrackSubscribed {
                   setupRemoteVideoView()
                   subscribedVideoTrack.addRenderer(self.remoteView!)
                   self.remoteParticipant = participant
                   return true
               }
           }
           return false
       }
    func renderRemoteParticipants(participants: [RemoteParticipant]) {
           for participant in participants {
               // Find the first renderable track.
               if participant.remoteVideoTracks.count > 0,
                   renderRemoteParticipant(participant: participant) {
                   break
               }
           }
       }

    func cleanupRemoteParticipant() {
       if self.remoteParticipant != nil {
           self.remoteView?.removeFromSuperview()
           self.remoteView = nil
           self.remoteParticipant = nil
       }
    }
    @objc func flipCamera() {
           var newDevice: AVCaptureDevice?

           if let camera = self.camera, let captureDevice = camera.device {
               if captureDevice.position == .front {
                   newDevice = CameraSource.captureDevice(position: .back)
               } else {
                   newDevice = CameraSource.captureDevice(position: .front)
               }

               if let newDevice = newDevice {
                   camera.selectCaptureDevice(newDevice) { (captureDevice, videoFormat, error) in
                       if let error = error {
                           self.logMessage(messageText: "Error selecting capture device.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
                       } else {
                           self.previewView.shouldMirror = (captureDevice.position == .front)
                       }
                   }
               }
           }
       }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        //self.tabBarController?.navigationItem.hidesBackButton = true
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    func prepareLocalMedia() {
       // We will share local audio and video when we connect to the Room.
       // Create an audio track.
       if localAudioTrack == nil {
           localAudioTrack = LocalAudioTrack(options: nil, enabled: true, name: "Microphone")

           if localAudioTrack == nil {
               logMessage(messageText: "Failed to create audio track")
           }
       }
       // Create a video track which captures from the camera.
       if localVideoTrack == nil {
           self.startPreview()
       }
    }

       // Update our UI based upon if we are in a Room or not
    func showRoomUI(inRoom: Bool) {
       self.connectButton.isHidden = inRoom
       self.roomTextField.isHidden = inRoom
       //self.roomLine.isHidden = inRoom
       self.roomLabel.isHidden = inRoom
       //self.micButton.isHidden = !inRoom
       //self.disconnectButton.isHidden = !inRoom
       self.navigationController?.setNavigationBarHidden(inRoom, animated: true)
       UIApplication.shared.isIdleTimerDisabled = inRoom

       // Show / hide the automatic home indicator on modern iPhones.
       self.setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
    func startPreview() {
           let frontCamera = CameraSource.captureDevice(position: .front)
           let backCamera = CameraSource.captureDevice(position: .back)

           if frontCamera != nil || backCamera != nil {

               let options = CameraSourceOptions { (builder) in
                   // To support building with Xcode 10.x.
                   #if XCODE_1100
                   if #available(iOS 13.0, *) {
                       // Track UIWindowScene events for the key window's scene.
                       // The example app disables multi-window support in the .plist (see UIApplicationSceneManifestKey).
                       builder.orientationTracker = UserInterfaceTracker(scene: UIApplication.shared.keyWindow!.windowScene!)
                   }
                   #endif
               }
               // Preview our local camera track in the local video preview view.
               camera = CameraSource(options: options, delegate: self)
               localVideoTrack = LocalVideoTrack(source: camera!, enabled: true, name: "Camera")

               // Add renderer to video track for local preview
               localVideoTrack!.addRenderer(self.previewView)
               logMessage(messageText: "Video track created")

               if frontCamera != nil && backCamera != nil {
                   // We will flip camera on tap.
                   let tap = UITapGestureRecognizer(target: self, action: #selector(self.flipCamera))
                   self.previewView.addGestureRecognizer(tap)
               }

               camera!.startCapture(device: frontCamera != nil ? frontCamera! : backCamera!) { (captureDevice, videoFormat, error) in
                   if let error = error {
                       self.logMessage(messageText: "Capture failed with error.\ncode = \((error as NSError).code) error = \(error.localizedDescription)")
                   } else {
                       self.previewView.shouldMirror = (captureDevice.position == .front)
                   }
               }
           } else {
               self.logMessage(messageText: "No front or back capture device found!")
           }
       }
    func makeUI() {
        let width = UIScreen.main.bounds.width - 40
        self.view.addSubview(previewView)
        self.view.addSubview(verticalStackview)
        horizontalStackview.addSubview(roomLabel)
        horizontalStackview.addSubview(roomTextField)
        verticalStackview.addSubview(horizontalStackview)
        verticalStackview.addSubview(connectButton)
        verticalStackview.spacing = 10.0

        //
        verticalStackview.axis = .vertical
        horizontalStackview.axis = .horizontal
        horizontalStackview.backgroundColor = UIColor.clear
        verticalStackview.backgroundColor = UIColor.clear
        //label and text field constraints
        roomLabel.text = "Room Name:"
        roomLabel.textAlignment = .left
        roomLabel.textColor = UIColor.white
//        roomLabel.backgroundColor = UIColor.clear
        roomLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(width/2)
        }
        roomTextField.placeholder = "Room #"
        roomTextField.text = "A"
        roomTextField.textAlignment = .left
        roomTextField.backgroundColor = UIColor.clear
        roomTextField.textColor = UIColor.white
        roomTextField.returnKeyType = UIReturnKeyType.done
        roomTextField.keyboardType = UIKeyboardType.default
        roomTextField.font = UIFont.systemFont(ofSize: 16)
        roomTextField.delegate = self
        roomTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(width/2)
        }
        horizontalStackview.snp.makeConstraints { make in
            make.height.equalTo(roomLabel.snp.height)
            //make.bottom.equalTo(startDateButton.snp.top)
        }
        let views = [roomLabel, roomTextField]
        var leftHandView: UIView?
        for view in views {
            horizontalStackview.addSubview(view)
            view.backgroundColor = UIColor.clear

            view.snp.makeConstraints { make in
                make.bottom.equalTo(connectButton.snp.top).offset(0)
                if let leftHandView = leftHandView {
                    make.left.equalTo(leftHandView.snp.right)
                    make.width.equalTo(leftHandView)
                }
                leftHandView = view
            }
        }
        connectButton.backgroundColor = .red
        connectButton.setTitle("Connect", for: .normal)
        connectButton.snp.makeConstraints { (make) -> Void in
           make.height.equalTo(40)
           make.width.equalTo(width)
        }
        connectButton.layer.cornerRadius = 20
        connectButton.layer.masksToBounds = true
        connectButton.addTarget(self, action: #selector(self.connect), for: .touchUpInside)
        verticalStackview.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(width)
            make.centerX.equalTo(UIScreen.main.bounds.width/2)
            make.bottom.equalTo(20)
        }
        previewView.backgroundColor = UIColor.black
        let height = UIScreen.main.bounds.height
        let widthPreview = UIScreen.main.bounds.width
        previewView.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(widthPreview)
            make.left.equalTo(0)
            make.top.equalTo(0)
        }
    }
    @objc func dismissKeyboard() {
        if self.roomTextField.isFirstResponder {
            self.roomTextField.resignFirstResponder()
        }
    }

}

struct TokenUtils {
    static func fetchToken(url:String) throws -> String {
        var token: String = "TWILIO_ACCESS_TOKEN"
        let requestURL: URL = URL(string: url)!
        do {
            let data = try Data(contentsOf: requestURL)
            if let tokenReponse = String(data: data, encoding: String.Encoding.utf8) {
                token = tokenReponse
            }
        } catch let error as NSError {
            print("Invalid token url, error = \(error)")
            throw error
        }
        return token
    }
}
