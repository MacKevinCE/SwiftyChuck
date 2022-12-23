//
//  InputARC.swift
//  SwiftyChuck
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

struct InputARC: InputProtocol {
    let id: UUID
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let anyObject: AnyObject

    init(
        _ id: UUID,
        _ anyObject: AnyObject,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.id = id
        self.file = file
        self.function = function
        self.line = line
        self.anyObject = anyObject
        self.type = .arc
    }

    func output() -> OutputARC {
        return OutputARC(self)
    }

    func getPreview() -> PreviewInfo {
        let attributed = "\(classAsArray().first ?? "AnyObject"):"
            .initAttributeText(color: .systemTeal, font: .semibold16)
            .printSpacer()
            .addTextWithAttributeText(text: self.getNameClass())
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: self.time.toString(), color: .gray, font: .regular12)
        return .attributed(attributed)
    }

    func getTabResume() -> NSMutableAttributedString {
        var attributeText = empty.initAttributeText(font: .regular14)

        if let name = self.getNameClass().null() {
            attributeText = attributeText
                .printTitleChuck("CLASS NAME")
                .printEnter()
                .printJSONForChuck(name)
                .printEnter()
        }

        if let type = self.classAs().null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("CLASS AS")
                .printEnter()
                .printJSONForChuck(type)
                .printEnter()
        }

        if let describing = self.describingClass().null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("ALL DESCRIBING CLASS")
                .printEnter()
                .printJSONForChuck(describing)
                .printEnter()
        }

        if let json = self.jsonClass().null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("JSON")
                .printEnter()
                .printJSONForChuck(json)
                .printEnter()
        }

        return attributeText
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [ParString] = []
        pares.append(ParString(key: "ID", value: self.id.uuidString))
        pares.append(ParString(key: "Project's Name", value: self.getNameProject()))
        pares.append(ParString(key: "Class Name", value: self.getNameClass()))
        pares.append(ParString(key: "All Describing Class", value: self.describingClass()))
        pares.append(ParString(key: "Encodable Class", value: self.jsonClass()))
        pares.append(ParString(key: "NavigationController Description", value: self.navigationControllerDescription()))
        pares.append(ParString(key: "View Description", value: self.viewDescription()))
        pares.append(ParString(key: "Class As", value: self.classAs()))
        pares.append(ParString(key: "File", value: SwiftyChuck.getPath(self.file)))
        pares.append(ParString(key: "Function", value: self.function))
        pares.append(ParString(key: "Line", value: String(self.line)))
        pares.append(ParString(key: "Time", value: self.time.toString(with: .iso8601)))
        return pares.reduce()
    }

    func classAsArray() -> [String] {
        return [
            self.inherit(with: AnyKeyPath.self),
            self.inherit(with: Bundle.self),
            self.inherit(with: BlockOperation.self),
            self.inherit(with: ByteCountFormatter.self),
            self.inherit(with: DateComponentsFormatter.self),
            self.inherit(with: Dimension.self),
            self.inherit(with: DispatchData.self),
            self.inherit(with: UIAccessibilityElement.self),
            self.inherit(with: UIAccessibilityTraits.self),
            self.inherit(with: UIActivity.self),
            self.inherit(with: UIActivityIndicatorView.self),
            self.inherit(with: UIActivityItemProvider.self),
            self.inherit(with: UIAlertAction.self),
            self.inherit(with: UIAlertController.self),
            self.inherit(with: UIApplication.self),
            self.inherit(with: UIApplicationShortcutIcon.self),
            self.inherit(with: UIApplicationShortcutItem.self),
            self.inherit(with: UIAttachmentBehavior.self),
            self.inherit(with: UIButton.self),
            self.inherit(with: UIBarItem.self),
            self.inherit(with: UIBezierPath.self),
            self.inherit(with: UIBlurEffect.self),
            self.inherit(with: UIColor.self),
            self.inherit(with: UIControl.self),
            self.inherit(with: UIContextualAction.self),
            self.inherit(with: UICollisionBehavior.self),
            self.inherit(with: UIContentSizeCategory.self),
            self.inherit(with: UICollectionReusableView.self),
            self.inherit(with: UICollectionView.self),
            self.inherit(with: UICollectionViewCell.self),
            self.inherit(with: UICollectionViewController.self),
            self.inherit(with: UICollectionViewDropProposal.self),
            self.inherit(with: UICollectionViewDropPlaceholder.self),
            self.inherit(with: UICollectionViewFlowLayout.self),
            self.inherit(with: UICollectionViewFlowLayoutInvalidationContext.self),
            self.inherit(with: UICollectionViewFocusUpdateContext.self),
            self.inherit(with: UICollectionViewLayout.self),
            self.inherit(with: UICollectionViewLayoutAttributes.self),
            self.inherit(with: UICollectionViewLayoutInvalidationContext.self),
            self.inherit(with: UICollectionViewPlaceholder.self),
            self.inherit(with: UICollectionViewUpdateItem.self),
            self.inherit(with: UICollectionViewTransitionLayout.self),
            self.inherit(with: UIDragPreviewTarget.self),
            self.inherit(with: UIDevice.self),
            self.inherit(with: UIDocument.self),
            self.inherit(with: UIDragItem.self),
            self.inherit(with: UIDatePicker.self),
            self.inherit(with: UIDragPreview.self),
            self.inherit(with: UIDropProposal.self),
            self.inherit(with: UIDictationPhrase.self),
            self.inherit(with: UIDragInteraction.self),
            self.inherit(with: UIDropInteraction.self),
            self.inherit(with: UIDynamicAnimator.self),
            self.inherit(with: UIDynamicBehavior.self),
            self.inherit(with: UIEvent.self),
            self.inherit(with: UIFont.self),
            self.inherit(with: UIFocusGuide.self),
            self.inherit(with: UIFocusSystem.self),
            self.inherit(with: UIFontMetrics.self),
            self.inherit(with: UIFieldBehavior.self),
            self.inherit(with: UIFocusDebugger.self),
            self.inherit(with: UIFontDescriptor.self),
            self.inherit(with: UIFeedbackGenerator.self),
            self.inherit(with: UIFloatRange.self),
            self.inherit(with: UIFocusUpdateContext.self),
            self.inherit(with: UIGravityBehavior.self),
            self.inherit(with: UIGraphicsRenderer.self),
            self.inherit(with: UIGestureRecognizer.self),
            self.inherit(with: UIGraphicsPDFRenderer.self),
            self.inherit(with: UIGraphicsImageRenderer.self),
            self.inherit(with: UIGraphicsRendererFormat.self),
            self.inherit(with: UIGraphicsRendererContext.self),
            self.inherit(with: UIGraphicsPDFRendererFormat.self),
            self.inherit(with: UIGraphicsPDFRendererContext.self),
            self.inherit(with: UIGraphicsImageRendererFormat.self),
            self.inherit(with: UIGraphicsImageRendererContext.self),
            self.inherit(with: UIImage.self),
            self.inherit(with: UIImageView.self),
            self.inherit(with: UIInputView.self),
            self.inherit(with: UIImageAsset.self),
            self.inherit(with: UIInputViewController.self),
            self.inherit(with: UIImagePickerController.self),
            self.inherit(with: UIImpactFeedbackGenerator.self),
            self.inherit(with: UIInterpolatingMotionEffect.self),
            self.inherit(with: UIKeyCommand.self),
            self.inherit(with: UILabel.self),
            self.inherit(with: UILexicon.self),
            self.inherit(with: UILayoutGuide.self),
            self.inherit(with: UILexiconEntry.self),
            self.inherit(with: UILayoutPriority.self),
            self.inherit(with: UILocalizedIndexedCollation.self),
            self.inherit(with: UILongPressGestureRecognizer.self),
            self.inherit(with: UIMotionEffect.self),
            self.inherit(with: UIManagedDocument.self),
            self.inherit(with: UIMotionEffectGroup.self),
            self.inherit(with: UIMarkupTextPrintFormatter.self),
            self.inherit(with: UIMutableApplicationShortcutItem.self),
            self.inherit(with: UINavigationBar.self),
            self.inherit(with: UINavigationItem.self),
            self.inherit(with: UINib.self),
            self.inherit(with: UINotificationFeedbackGenerator.self),
            self.inherit(with: UIPress.self),
            self.inherit(with: UIPrinter.self),
            self.inherit(with: UIPasteboard.self),
            self.inherit(with: UIPrintInfo.self),
            self.inherit(with: UIPickerView.self),
            self.inherit(with: UIPrintPaper.self),
            self.inherit(with: UIPageControl.self),
            self.inherit(with: UIPressesEvent.self),
            self.inherit(with: UIProgressView.self),
            self.inherit(with: UIPushBehavior.self),
            self.inherit(with: UIPreviewAction.self),
            self.inherit(with: UIPrintFormatter.self),
            self.inherit(with: UIPasteConfiguration.self),
            self.inherit(with: UIPreviewInteraction.self),
            self.inherit(with: UIPresentationController.self),
            self.inherit(with: UIPrintPageRenderer.self),
            self.inherit(with: UIPageViewController.self),
            self.inherit(with: UIPreviewActionGroup.self),
            self.inherit(with: UIPanGestureRecognizer.self),
            self.inherit(with: UIRegion.self),
            self.inherit(with: UIRefreshControl.self),
            self.inherit(with: UIRotationGestureRecognizer.self),
            self.inherit(with: UIReferenceLibraryViewController.self),
            self.inherit(with: UISwitch.self),
            self.inherit(with: UISlider.self),
            self.inherit(with: UIScreen.self),
            self.inherit(with: UIStepper.self),
            self.inherit(with: UIStoryboard.self),
            self.inherit(with: UIStackView.self),
            self.inherit(with: UISearchBar.self),
            self.inherit(with: UIScrollView.self),
            self.inherit(with: UIScreenMode.self),
            self.inherit(with: UISnapBehavior.self),
            self.inherit(with: UIStoryboardSegue.self),
            self.inherit(with: UISearchController.self),
            self.inherit(with: UISegmentedControl.self),
            self.inherit(with: UITabBar.self),
            self.inherit(with: UITableView.self),
            self.inherit(with: UITabBarItem.self),
            self.inherit(with: UITraitCollection.self),
            self.inherit(with: UITapGestureRecognizer.self),
            self.inherit(with: UITargetedDragPreview.self),
            self.inherit(with: UITableViewPlaceholder.self),
            self.inherit(with: UITableViewDropProposal.self),
            self.inherit(with: UITableViewDropPlaceholder.self),
            self.inherit(with: UITableViewFocusUpdateContext.self),
            self.inherit(with: UITableViewHeaderFooterView.self),
            self.inherit(with: UITableViewCell.self),
            self.inherit(with: UITabBarController.self),
            self.inherit(with: UITableViewDropProposal.self),
            self.inherit(with: UITableViewDropPlaceholder.self),
            self.inherit(with: UITableViewHeaderFooterView.self),
            self.inherit(with: UITableViewFocusUpdateContext.self),
            self.inherit(with: UITableViewController.self),
            self.inherit(with: UITouch.self),
            self.inherit(with: UIToolbar.self),
            self.inherit(with: UITextView.self),
            self.inherit(with: UITextField.self),
            self.inherit(with: UITextRange.self),
            self.inherit(with: UITextChecker.self),
            self.inherit(with: UITextPosition.self),
            self.inherit(with: UITextInputMode.self),
            self.inherit(with: UIVisualEffect.self),
            self.inherit(with: UIVibrancyEffect.self),
            self.inherit(with: UIVisualEffectView.self),
            self.inherit(with: UIViewPrintFormatter.self),
            self.inherit(with: UIViewPropertyAnimator.self),
            self.inherit(with: UIVideoEditorController.self),
            self.inherit(with: UIView.self),
            self.inherit(with: UINavigationController.self),
            self.inherit(with: UIViewController.self),
            self.inherit(with: UIResponder.self),
            self.inherit(with: UIWindow.self),
            self.inherit(with: Codable.self),
            self.inherit(with: Decodable.self),
            self.inherit(with: Encodable.self),
            self.inherit(with: AnyObject.self),
        ].compactMap { $0 }
    }

    func classAs() -> String {
        return self.classAsArray().joined(separator: ", ")
    }

    func inherit<T>(with type: T.Type) -> String? {
        if self.anyObject is T {
            return String(describing: T.self)
        } else {
            return nil
        }
    }

    func jsonClass() -> String {
        guard let value = (anyObject as? Encodable) else { return empty }
        let data = try? JSONEncoder().encode(value)
        return data?.prettyPrintedJSONString?.null() ?? empty
    }

    func navigationControllerDescription() -> String {
        guard let value = (anyObject as? UIViewController) else { return empty }
        return value.navigationController?.description ?? empty
    }

    func viewDescription() -> String {
        guard let value = (anyObject as? UIViewController) else { return empty }
        return value.view.description
    }

    func describingClass() -> String {
        return String(describing: self.anyObject)
    }

    func getNameComplete() -> String {
        let describing = self.describingClass()
        return String(describing.split(separator: ":").first ?? "").replacingOccurrences(of: "<", with: "")
    }

    func getNameProject() -> String {
        return String(self.getNameComplete().split(separator: ".").first ?? "")
    }

    func getNameClass() -> String {
        return String(self.getNameComplete().split(separator: ".").last ?? "")
    }
}

open class ARC {
    let idARC = UUID()
    public init() {
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCViewController: UIViewController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCTableViewCell: UITableViewCell {
    let idARC = UUID()
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCCollectionViewCell: UICollectionViewCell {
    let idARC = UUID()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}

open class ARCNavigationController: UINavigationController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        SwiftyChuck.classInit(self.idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        SwiftyChuck.classInit(self.idARC, self)
    }

    deinit {
        SwiftyChuck.removeChuck(idARC)
    }
}
