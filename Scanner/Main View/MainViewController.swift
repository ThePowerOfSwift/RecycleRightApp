/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The view controller that selects an image and makes a prediction using Vision and Core ML.
*/

import UIKit

class MainViewController: UIViewController {
    var firstRun = true

    /// A predictor instance that uses Vision and Core ML to generate prediction strings from a photo.
    let imagePredictor = ImagePredictor()

    /// The largest number of predictions the main view controller displays the user.
    let predictionsToShow = 2

    // MARK: Main storyboard outlets
    @IBOutlet weak var startupPrompts: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
}

extension MainViewController {
    // MARK: Main storyboard actions
    /// The method the storyboard calls when the user one-finger taps the screen.
    @IBAction func singleTap() {
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            present(photoPicker, animated: false)
            return
        }

        present(cameraPicker, animated: false)
    }

    /// The method the storyboard calls when the user two-finger taps the screen.
    @IBAction func doubleTap() {
        present(photoPicker, animated: false)
    }
}

extension MainViewController {
    // MARK: Main storyboard updates
    /// Updates the storyboard's image view.
    /// - Parameter image: An image.
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    /// Updates the storyboard's prediction label.
    /// - Parameter message: A prediction or message string.
    /// - Tag: updatePredictionLabel
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = message
        }

        if firstRun {
            DispatchQueue.main.async {
                self.firstRun = false
                self.predictionLabel.superview?.isHidden = false
                self.startupPrompts.isHidden = true
            }
        }
    }
    /// Notifies the view controller when a user selects a photo in the camera picker or photo library picker.
    /// - Parameter photo: A photo from the camera or photo library.
    func userSelectedPhoto(_ photo: UIImage) {
        updateImage(photo)
        updatePredictionLabel("Making predictions for the photo...")

        DispatchQueue.global(qos: .userInitiated).async {
            self.classifyImage(photo)
        }
    }

}

extension MainViewController {
    // MARK: Image prediction methods
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            updatePredictionLabel("No predictions. (Check console log.)")
            return
        }

        let formattedPredictions = formatPredictions(predictions)
        let elecMsg = "Electronic waste \nUse special recycling facility";
        let plMsg = "Recycling Bin";
        let bigMsg = "Too big to recycle\nUse special recycling facility";
        let paperMsg = "Paper\nRecycling Bin";
        let miscMsg = "Use special recycling facility";
        let miscMsplasg = "Bring to store's drop-off \n recycling center";
        let metalMsg = "Recycling Bin";
        let donateMsg = "Consider donating :)";
        let cleanMsg = "Recycle Bin if clean";
        let recMsg = "Recycle Bin";
        let foodMsg = "Food please use compost"

        let recycleDict = ["notebook": elecMsg,
                           "computer": elecMsg,
                           "laptop": elecMsg,
                           "keyboard": elecMsg,
                           "iPod": elecMsg,
                           "cellular": elecMsg,
                           "orange": foodMsg,
                           "lemon": foodMsg,
                           "banana": foodMsg,
                           "apple": foodMsg,
                           "fruit": foodMsg,
                           "lawn": foodMsg,
                           "grass": foodMsg,
                           "leaf": foodMsg,
                           "mouse": elecMsg,
                           "lotion": plMsg,
                           "perfume": plMsg,
                           "bottle": plMsg,
                           "ladle": plMsg,
                           "pen": miscMsg,
                           "pencil": miscMsg,
                           "plastic": miscMsplasg,
                           "sunglasses": miscMsplasg,
                           "soap": plMsg,
                           "cup": plMsg,
                           "measuring": plMsg,
                           "water": recMsg,
                           "binder": paperMsg,
                           "cardboard": paperMsg,
                           "envelope": paperMsg,
                           "pin": metalMsg,
                           "clip": metalMsg,
                           "table": bigMsg,
                           "bench": bigMsg,
                           "desk": bigMsg,
                           "chair": bigMsg,
                           "sofa": bigMsg,
                           "chiffonier": bigMsg,
                           "food": metalMsg,
                           "comb": plMsg,
                           "bath": donateMsg,
                           "shoes": miscMsplasg,
                           "towel": donateMsg,
                           "sheet": donateMsg,
                           "blanket": donateMsg,
                           "velvet": donateMsg,
                           "curtain": donateMsg,
                           "doormat": donateMsg,
                           "jersey": donateMsg,
                           "pillow": donateMsg,
                           "jean": donateMsg,
                           "iron": elecMsg,
                           "shower": donateMsg,
                           "backpack": donateMsg,
                           "remote": elecMsg,
                           "switch": elecMsg,
                           "digital": elecMsg,
                           "watch": elecMsg,
                           "ballpoint": miscMsg,
                           "ball": plMsg,
                           "paper": cleanMsg,
                           "wardrobe": bigMsg,
                           "quilt": donateMsg,
                           "vacuum": elecMsg,

                            ]
        
        let msg = formattedPredictions[0].split(separator: " ")
        let msgFull = formattedPredictions[0].split(separator: "-")
        let newcode = msg[0]
        print(newcode)
        if let message = recycleDict[String(newcode)] {
            ///print("Response \(newcode): \(message)")
            let predictionString = String(msgFull[0]) + "\n" + message
            updatePredictionLabel(String(predictionString))
        } else {
            ///print("Unknown response \(newcode)")
            let predictionString = String(msgFull[0]) + "\n" + "Please use your discretion"
            updatePredictionLabel(String(predictionString))
        }
        ///let predictionString = formattedPredictions.joined(separator: "\n")
        ///updatePredictionLabel(predictionString)
    }

    /// Converts a prediction's observations into human-readable strings.
    /// - Parameter observations: The classification observations from a Vision request.
    /// - Tag: formatPredictions
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }
}
