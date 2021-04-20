Class {
	#name : #GtPharoCreateBehaviorElement,
	#superclass : #GtCreateElement,
	#instVars : [
		'behaviorBlock'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #accessing }
GtPharoCreateBehaviorElement class >> saveButtonName [
	^ #'creator--save-button'
]

{ #category : #accessing }
GtPharoCreateBehaviorElement >> behaviorBlock: aBlock [
	behaviorBlock := aBlock
]

{ #category : #'private - instance creation' }
GtPharoCreateBehaviorElement >> buildClassLabel [
	^ definition nameEditor asElement
		aptitude: (BrGlamorousEditableLabelAptitude new
				defaultBackground: Color transparent;
				glamorousCodeFont;
				bold;
				fontSize: 18);
		yourself
]

{ #category : #'private - instance creation' }
GtPharoCreateBehaviorElement >> buildDefinitionEditor [
	| theProperties saveButton |
		
	theProperties := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets all: 10).
		
	theProperties addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination arrowUp;
		action: [ :anEvent |
			anEvent currentTarget deepestFocusedChild ifNotNil: [ :aFocusedChild |
				BlFocusFinder new
					up;
					root: anEvent currentTarget;
					referenceElement: aFocusedChild;
					nextFocusDo: [ :aNextFocusElement | aNextFocusElement requestFocus ] ] ]).

	theProperties addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination arrowDown;
		action: [ :anEvent |
			anEvent currentTarget deepestFocusedChild ifNotNil: [ :aFocusedChild |
				BlFocusFinder new
					down;
					root: anEvent currentTarget;
					referenceElement: aFocusedChild;
					nextFocusDo: [ :aNextFocusElement | aNextFocusElement requestFocus ] ] ]).

	saveButton := BrButton new
		icon: BrGlamorousVectorIcons accept;
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude new;
		label: 'Save';
		action: [ self compileBehavior ];
		constraintsDo: [ :c | c grid horizontal span: 2 ];
		containerName: self class saveButtonName;
		disable.

	definition
		when: GtBehaviorChangeEvent
		do: [ :event | saveButton enabled: self isValidForCreation ].

	theProperties addChild: (self buildClassLabel constraintsDo: [ :c | c grid horizontal span: 2 ]).

	self editors do: [ :eachEditor |
		theProperties addChildren: { 
				(self buildSectionLabel: eachEditor title).
				(eachEditor
					aptitude: [ self editableLabelLook ];
					margin: self buttonMargin;
					asElement) } ].

	theProperties addChild: saveButton.

	^ theProperties
]

{ #category : #private }
GtPharoCreateBehaviorElement >> compileBehavior [
	| change |
	
	"before creating a class we should create a proper package + tag"
	definition category isValidForCreation
		ifTrue: [
			GtPharoCodeModifier current
				performRefactoryChange: definition category createPackageChange ].
	
	change := definition createBehaviorChange.
	GtPharoCodeModifier current performRefactoryChange: change.
	
	behaviorBlock notNil
		ifTrue: [ behaviorBlock cull: change definedClass ]
]

{ #category : #private }
GtPharoCreateBehaviorElement >> editors [
	^ definition editors
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forClassDefinition [
	definition := GtClassDefinition forNew.
	self addChild: self buildDefinitionEditor
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forClassName: aSymbol [
	definition name: aSymbol
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forDefinition: aGtBehaviorDefinition [
	definition := aGtBehaviorDefinition.
	self addChild: self buildDefinitionEditor
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forPackage: aPackage [
	definition category package name: aPackage name
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forPackageTag: aPackageTag [
	definition category tag name: aPackageTag name
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forSuperclass: aClass [
	definition superclass name: aClass name
]

{ #category : #initialization }
GtPharoCreateBehaviorElement >> forTraitDefinition [
	definition := GtTraitDefinition forNew.
	self addChild: self buildDefinitionEditor
]

{ #category : #private }
GtPharoCreateBehaviorElement >> isValidForCreation [
	^ definition isValidForCreation
]
