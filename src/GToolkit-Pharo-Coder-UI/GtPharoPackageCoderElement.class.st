Class {
	#name : #GtPharoPackageCoderElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtPharoWithPackageCoderViewModel + TGtWithCoderToolbar',
	#classTraits : 'TGtPharoWithPackageCoderViewModel classTrait + TGtWithCoderToolbar classTrait',
	#instVars : [
		'packageCoder'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Views'
}

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildContentPane [
	self addChildren: {
		self makeLabel.
		self buildPackageLabel.
		self buildParentLink.
		self buildContentTabs }
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildContentTabs [
	<return: #BrTabGroup>
	| contentTabs |
	contentTabs := GtPhlowCompositeView new
		views: self packageViewItems;
		asElementDo: [ :aBrTabGroup | aBrTabGroup ].
	^ contentTabs
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildPackageLabel [
	| packageNameEditor container previewButton unloadButton |
	container := BrHorizontalPane new
			id: #'coder--rename-package-reference-in-method-form';
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
			text: packageCoder package name;
			margin: (BlInsets all: 0);
			addAptitude: (BrGlamorousWithExplicitContextMenuAptitude new 
				handleSubmenu: [ GtCoderPackageTarget menuItemsForObject: self package hostElement: self ]);
			whenKey: BlKeyCombination primaryB
				labelDo: [ :aShortcutEvent | self phlow spawnTool: (GtPackageCoderTool package: self package) ];
			whenKey: BlKeyCombination primaryG
				labelDo: [ :aShortcutEvent | self phlow spawnObject: self package ];
			whenKey: BlKeyCombination primaryR
				labelDo: [ :aShortcutEvent | aShortcutEvent currentTarget switchToEditor ];
			whenKey: BlKeyCombination primaryC
				labelDo: [ :aShortcutEvent | Clipboard clipboardText: self package name asString ].

	previewButton := GtRefactoringsInDropdownPreviewElement new
			beTinySize;
			refactoringsViewModel: (GtRefactoringsViewModel new
					refactoringTitle: 'Rename package';
					yourself);
			visibility: BlVisibility gone;
			margin: (BlInsets left: 5);
			previewContentDo: [ :anElement :aRefactoringsViewModel | 
				aRefactoringsViewModel
					targetName: packageCoder package name;
					refactorings: [ {GtRBRenamePackageRefactoring
								from: packageCoder package name
								to: packageNameEditor text asString} ].

				anElement hFitContentLimited ];
			cancelBlock: [ packageNameEditor text: packageCoder package name ];
			when: GtRefactoringsAppliedEvent
				do: [ :anEvent | anEvent currentTarget hide ].

	packageNameEditor editor
		when: BrTextEditorModifiedEvent
			do: [ :anEvent | 
				anEvent text asString = packageCoder package name
					ifTrue: [ previewButton hide ]
					ifFalse: [ previewButton show ] ];
		when: BrTextEditorTextReplacedEvent
			do: [ :anEvent | 
				anEvent text asString = packageCoder package name
					ifTrue: [ previewButton hide ]
					ifFalse: [ previewButton show ] ].

	unloadButton := GtPreviewChangeButton new
			icon: BrGlamorousVectorIcons remove;
			label: 'Unload';
			changeAction: [ self unloadPackage ];
			changeStencil: [ self buildRemovePackageLabel ].

	container addChild: packageNameEditor.
	container addChild: previewButton.
	container addChild: unloadButton.
	container addChild: self toolbarElement.

	^ container
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildPackageTagsList [
	^ BrSimpleList new
		itemStencil: [ GtPackageTagCardElement new ];
		itemDataBinder: [ :eachTagCard :eachTagCoder | eachTagCard coder: eachTagCoder ];
		items: (packageCoder packageTagsCoder coders asSortedCollection: [ :a :b | a packageTagName < b packageTagName ])
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildParentLink [
	| aLinkContainer |
	aLinkContainer := BrHorizontalPane new
			hMatchParent;
			vFitContent.
	aLinkContainer
		addChild: (BrLabel new
				margin: (BlInsets left: 4);
				beSmallSize;
				aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont
						foreground: self theme button defaultTextColor);
				text: 'In: ').
	aLinkContainer
		addChild: (BrLabel new
				aptitude: (BrGlamorousButtonExteriorAptitude new borderPaint: Color transparent)
						+ BrGlamorousLabelAptitude new glamorousRegularFont;
				text: 'Pharo';
				beSmallSize;
				fitContent;
				when: BlClickEvent
					do: [ :anEvent | 
						| aCoder aCoderEvent aSpace |
						aCoder := GtPharoPackagesCoder forAllPackages.
						anEvent modifiers isAlt
							ifTrue: [ aCoderEvent := GtCoderToReplace new coder: aCoder.
								self fireEvent: aCoderEvent.
								aCoderEvent isConsumed
									ifFalse: [ self phlow spawnObject: aCoderEvent coder ] ]
							ifFalse: [ anEvent modifiers isPrimaryModifier
									ifTrue: [ aSpace := BlSpace new.
										aSpace title: 'Packages'.
										aSpace icon: BrGlamorousVectorIcons emphasizedBrowse.
										aSpace extent: 1200 @ 600.
										aSpace root background: Color transparent.
										aSpace inPager: GtCoderElement forAllPackages.
										aSpace withCommonSettings.
										anEvent target showSpace: aSpace ]
									ifFalse: [ aCoderEvent := GtCoderToSpawn new coder: aCoder.
										self fireEvent: aCoderEvent.
										aCoderEvent isConsumed
											ifFalse: [ self phlow spawnObject: aCoderEvent coder ] ] ] ]).
	^ aLinkContainer
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> buildRemovePackageLabel [
	| labelText classCount extensionCount tagCount |
	classCount := packageCoder package definedClasses size.
	tagCount := packageCoder package tags size.
	extensionCount := packageCoder package extensionMethods size.

	labelText := 'Remove package <1s> with <2p> class<3?:es>, <4p> tag<5?:s> and <6p> extension method<7?:s>'
			expandMacrosWithArguments: {packageCoder package name.
					classCount.
					classCount = 1.
					tagCount.
					tagCount = 1.
					extensionCount.
					extensionCount = 1}.

	^ BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: labelText asRopedText
]

{ #category : #accessing }
GtPharoPackageCoderElement >> coderViewModel: aGtPackageCoder [
	packageCoder := aGtPackageCoder coder.

	self buildContentPane
]

{ #category : #initialization }
GtPharoPackageCoderElement >> initialize [
	super initialize.
	self initializeToolbarElement.

	self padding: (BlInsets top: 5 left: 6 bottom: 5 right: 6).
	self when: BlClickEvent do: [ self requestFocus ].
	self matchParent
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> makeLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
				foreground: Color gray;
				fontSize: 12);
		text: 'Package';
		padding: (BlInsets left: 5)
]

{ #category : #accessing }
GtPharoPackageCoderElement >> package [
	<return: #Package>

	^ self packageCoder package
]

{ #category : #accessing }
GtPharoPackageCoderElement >> packageCoder [
	<return: #GtPharoPackageCoder>

	^ packageCoder
]

{ #category : #'private - ui' }
GtPharoPackageCoderElement >> packageViewItems [
	| collector context |
	collector := GtPhlowViewsCollector new.
	collector fromObject: self packageCoder package.
	collector pragmaName: #gtPackageView.
	context := GtPhlowContext new.
	context packageCoder: self packageCoder.
	collector context: context.
	^ collector collect
]

{ #category : #actions }
GtPharoPackageCoderElement >> unloadPackage [
	packageCoder unload.

	self fireEvent: (GtCoderToReplace new coder: GtPharoPackagesCoder forAllPackages)
]
