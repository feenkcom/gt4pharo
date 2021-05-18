Class {
	#name : #Gt2PharoPackageCoderElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGt2WithPharoPackageCoderViewModel',
	#classTraits : 'TGt2WithPharoPackageCoderViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Views'
}

{ #category : #'private - instance creation' }
Gt2PharoPackageCoderElement >> buildContentTabs [
	<return: #BrTabGroup>
	| contentTabs |
	contentTabs := GtPhlowCompositeView new
		views: (self pharoPackageCoderViewModel pharoPackageViewsCoderViewModel pharoPackageViewCoderViewModels collect: [ :eachPackageViewViewModel | eachPackageViewViewModel phlowView ]);
		asElementDo: [ :aBrTabGroup | aBrTabGroup ].
	^ contentTabs
]

{ #category : #'private - instance creation' }
Gt2PharoPackageCoderElement >> buildPackageLabel [
	| packageNameEditor container previewButton unloadButton |
		
	container := BrHorizontalPane new
		hMatchParent;
		alignCenterLeft;
		vFitContent.
	
	packageNameEditor := BrEditableLabel new
		id: GtPackageCoderPackageNameId;
		aptitude: (BrGlamorousEditableLabelAptitude new
			defaultBackground: Color transparent;
			glamorousCodeFont;
			bold;
			fontSize: 18);
		text: self pharoPackageCoderViewModel pharoPackageCoder packageName;
		margin: (BlInsets all: 0);
		whenKey: BlKeyCombination primaryB
			labelDo: [ :aShortcutEvent| self phlow spawnTool: (GtPackageCoderTool package: self package) ];
		whenKey: BlKeyCombination primaryG
			labelDo: [ :aShortcutEvent | self phlow spawnObject: self package ];
		whenKey: BlKeyCombination primaryR
			labelDo: [ :aShortcutEvent | aShortcutEvent currentTarget switchToEditor ];
		whenKey: BlKeyCombination primaryC
			labelDo: [ :aShortcutEvent | Clipboard clipboardText: self package name asString ].

	previewButton := GtRefactoringsPreviewButton new
		margin: (BlInsets left: 5);
		visibility: BlVisibility gone;
		refactorings: [ { "RBRenamePackageRefactoring from: packageCoder package name to: packageNameEditor text asString" } ];
		when: GtRefactoringsAppliedEvent do: [ :anEvent | anEvent currentTarget visibility: BlVisibility hidden ].
		
	packageNameEditor editor
		when: BrTextEditorModifiedEvent 
		do: [ :anEvent |
			"anEvent text asString = packageCoder package name
				ifTrue: [ previewButton visibility: BlVisibility gone ]
				ifFalse: [  previewButton visibility: BlVisibility visible ]" ].

	unloadButton := GtPreviewChangeButton new
		icon: BrGlamorousVectorIcons remove;
		label: 'Unload';
		changeAction: [ self unloadPackage ];
		changeStencil: [ self buildRemovePackageLabel ].

	container addChild: packageNameEditor.
	container addChild: previewButton.
	container addChild: unloadButton.

	^ container
]

{ #category : #'private - ui' }
Gt2PharoPackageCoderElement >> buildParentLink [
	| aLinkContainer |
	aLinkContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent.
	aLinkContainer
		addChild:
			(BrLabel new
				margin: (BlInsets left: 4);
				beSmallSize;
				aptitude:
					(BrGlamorousLabelAptitude new glamorousRegularFont
						foreground: self theme button defaultTextColor);
				text: 'In: ').
	aLinkContainer
		addChild:
			(BrButton new
				aptitude:
					(BrGlamorousButtonExteriorAptitude new borderPaint: Color transparent)
						+ BrGlamorousLabelAptitude new glamorousRegularFont;
				label: 'Pharo';
				beSmallSize;
				fitContent;
				action: [ | aCoderToReplace |
					aCoderToReplace := GtCoderToReplace new
						coder: GtPharoPackagesCoder forAllPackages.
					self fireEvent: aCoderToReplace.
					aCoderToReplace isConsumed
						ifFalse: [ self phlow spawnObject: aCoderToReplace coder ] ]).
	^ aLinkContainer
]

{ #category : #'private - ui' }
Gt2PharoPackageCoderElement >> buildRemovePackageLabel [
	| labelText classCount extensionCount |

	classCount := packageCoder package definedClasses size.
	extensionCount := packageCoder package extensionMethods size.

	labelText := 'Remove package <1s> with <2p> class<3?:es> and <4p> extension method<5?:s>'
		expandMacrosWithArguments:
			{packageCoder package name.
			classCount.
			(classCount = 1).
			extensionCount.
			(extensionCount = 1)}.

	^ BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: labelText asRopedText
]

{ #category : #initialization }
Gt2PharoPackageCoderElement >> initialize [
	super initialize.

	self matchParent.
	self padding: (BlInsets top: 5 left: 6 bottom: 5 right: 6).
]

{ #category : #'api - pharo package coder view model' }
Gt2PharoPackageCoderElement >> onPharoPackageCoderViewModelChanged [
	"Is sent when a new pharoPackageCoderViewModel is assigned to the receiver.
	Note: #onPharoPackageCoderViewModelChanged is sent before #subscribeToPharoPackageCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackageCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self removeChildren.

	self addChildren: {
		self buildPackageLabel.
		self buildParentLink.
		self buildContentTabs }
]

{ #category : #accessing }
Gt2PharoPackageCoderElement >> package [
	<return: #RPackage>

	^ self packageCoder package
]

{ #category : #accessing }
Gt2PharoPackageCoderElement >> packageCoder [
	<return: #GtPharoPackageCoder>

	^ packageCoder
]

{ #category : #'private - instance creation' }
Gt2PharoPackageCoderElement >> packageViewItems [
	^ self pharoPackageCoderViewModel pharoPackageCoder pharoPackage
		realPackageDo: [ :anRPackage |
			| collector context |
			
			collector := GtPhlowViewsCollector new.
			collector fromObject: self packageCoder package.
			collector pragmaName: #gtPackageView.

			context := GtPhlowContext new.
			context packageCoder: self packageCoder.
			collector context: context.

			collector collect ]
		ifAbsent: [ #() ]
]

{ #category : #actions }
Gt2PharoPackageCoderElement >> unloadPackage [
	packageCoder unload.

	self fireEvent: (GtCoderToReplace new coder: GtPharoPackagesCoder forAllPackages)
]
