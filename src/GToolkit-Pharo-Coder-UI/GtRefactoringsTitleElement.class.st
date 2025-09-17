Class {
	#name : #GtRefactoringsTitleElement,
	#superclass : #GtRefactoringsBasicElement,
	#instVars : [
		'titleElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings New'
}

{ #category : #initialization }
GtRefactoringsTitleElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
GtRefactoringsTitleElement >> initialize [
	super initialize.

	self initializeTitleElement.

	self addChild: titleElement as: #refactoringTitle.

	self addAptitude: (BrLayoutResizerAptitude new hInherit: titleElement).

	self fitContentLimited
]

{ #category : #initialization }
GtRefactoringsTitleElement >> initializeTitleElement [
	titleElement := BrLabel new
			visibility: BlVisibility gone;
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new foreground: self theme button disabledTextColor);
			text: ''
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsTitleElement >> onRefactoringsViewModelChanged [
	super onRefactoringsViewModelChanged.
	self updateElement
]

{ #category : #'accessing - refactorings view model' }
GtRefactoringsTitleElement >> updateElement [
	| aFormatedText |
	aFormatedText := nil.
	self refactoringsViewModel
		refactoringTitleDo: [ :aText | 
			aFormatedText := aText asRopedText glamorousRegularFont.
			self refactoringsViewModel
				targetNameDo: [ :aPreview | 
					aFormatedText
						append: ((' ' , aPreview asString) asRopedText
								glamorousCodeFont;
								foreground: Color gray;
								glamorousCodeTinySize) ] ].

	aFormatedText
		ifNil: [ titleElement
				visibility: BlVisibility gone;
				text: '' ]
		ifNotNil: [ titleElement
				text: aFormatedText;
				visibility: BlVisibility visible ]
]
