//
//  IGCropViewController.swift
//  Cropper
//
//  Created by arshad tp on 14/09/21.
//

import UIKit

public class CropInfo: NSObject {
    let minimumPortraitZoomScale: CGFloat = 4/5
    let minimumLandScapeZoomScale: CGFloat = 1/1.91
}

let frameworkBundleID =  "org.cocoapods.IGImageCropper"
public class IGCropViewController: UIViewController {
    
    enum ZoomScale {
        case minimum
        case square
    }
    
    let image: UIImage
    let cropInfo: CropInfo
    
    var activeZoomScale: ZoomScale = .square
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var adjustZoomScaleButton: UIButton!
    @IBOutlet var cropMask: [UIView]!
    var initialScale: CGFloat = 1.0
    var isPortraitImage: Bool {
        return image.size.width <= image.size.height
    }
    
    var minZoomScale: CGFloat  {
        if (isPortraitImage) {
            return cropInfo.minimumPortraitZoomScale
        }
        return cropInfo.minimumLandScapeZoomScale
    }
    
    public init(image: UIImage, cropInfo: CropInfo?) {
        if let cropInfo = cropInfo {
            self.cropInfo = cropInfo
        } else {
            self.cropInfo = CropInfo()
        }
        self.image = image
        let bundle = Bundle(identifier: frameworkBundleID)

        super.init(nibName: "IGCropViewController", bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImageToCrop(image:UIImage){
        
        imageView.image = image
        if (isPortraitImage) {
            // For portait image make width maximum as screen width and adjust the height accordingly
            let width = UIScreen.main.bounds.width
            initialScale = width/image.size.width
            
            imageViewWidthConstraint.constant = width
            imageViewHeightContraint.constant = image.size.height * initialScale
            
        } else {
            // For portait image make height maximum as screen width and adjust the width accordingly
            let height = UIScreen.main.bounds.width // first showing in square crop where width = screen width
            initialScale = height/image.size.height
            
            imageViewWidthConstraint.constant = image.size.width * initialScale
            imageViewHeightContraint.constant = height
        }
        
        
        
        scrollView.minimumZoomScale = minZoomScale
        scrollView.maximumZoomScale = 5.0
        scrollView.contentSize = imageView.frame.size
        scrollView.delegate = self
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print("image ", UIImage.bundledImage(named: "shrink"))
        adjustZoomScaleButton.setImage(UIImage.bundledImage(named: "shrink"), for: .normal)
        adjustZoomScaleButton.setImage(UIImage.bundledImage(named: "expand"), for: .selected)
        setImageToCrop(image: image)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func chooseButtonAction(_ sender: Any) {
        
        cropImage()
    }
    
    @IBAction func adjustZoomScaleAction(_ sender: Any) {
        
        if (activeZoomScale == .square) {
            activeZoomScale = .minimum
            adjustZoomScaleButton.isSelected = true
            scrollView.setZoomScale(minZoomScale, animated: true)
        } else {
            activeZoomScale = .square
            adjustZoomScaleButton.isSelected = false
            scrollView.setZoomScale(1, animated: true)

        }
    }
    
    private func cropImage() {
        
        let zoomScale = scrollView.zoomScale
        let scale:CGFloat = 1/zoomScale * 1/initialScale
        
        let x:CGFloat =  scrollView.contentOffset.x * scale
        let y:CGFloat = scrollView.contentOffset.y * scale
        let width:CGFloat = scrollView.frame.size.width  * scale
        let height:CGFloat = scrollView.frame.size.height * scale
        
        print("crop rect ", CGRect(x: x, y: y, width: width, height: height))
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: CGRect(x: x, y: y, width: width, height: height))
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        
        print("scroll view ==" , scrollView.frame.size)
        print("result image size === ", croppedImage.size)
//        saveImage(image: croppedImage)
    }
//    func saveImage(image: UIImage) -> Bool {
//        guard let data = image.UIImageJPEGRepresentation(compressionQuality: 1) ?? image.pngData() else {
//            return false
//        }
//        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
//            return false
//        }
//        do {
//            try data.write(to: directory.appendingPathComponent("fileName.png")!)
//            print("path == ", directory.path)
//            return true
//        } catch {
//            print(error.localizedDescription)
//            return false
//        }
//    }
    
    private  func animateMaskView(alpha: CGFloat) {
        UIView.animate(withDuration: 1.5) { [weak self] in
            self?.cropMask.forEach { (view) in
                view.alpha = alpha
            }
        }
    }
}


extension IGCropViewController: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if (isPortraitImage) {
            let h = (UIScreen.main.bounds.width - imageView.frame.width)/2
            scrollView.contentInset = UIEdgeInsets.init(top: 0, left: h < 0 ? 0 : h, bottom: 0, right: 0)
        } else {
            let v = (UIScreen.main.bounds.width - imageView.frame.height)/2
            scrollView.contentInset = UIEdgeInsets.init(top: v < 0 ? 0 : v, left: 0, bottom: 0, right: 0)
        }
        
        
    }
    
    
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animateMaskView(alpha: 0.4)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        animateMaskView(alpha: 1.0)
        
    }
    
    
}

extension UIImage {
    class func bundledImage(named: String) -> UIImage? {
        let image = UIImage(named: named)
        if image == nil {
            let bundle = Bundle(identifier: "org.cocoapods.IGImageCropper")

            return UIImage(named: named, in: bundle, compatibleWith: nil)
        } // Replace MyBasePodClass with yours
        return image
    }
}
