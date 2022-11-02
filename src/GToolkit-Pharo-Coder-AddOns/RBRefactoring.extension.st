Extension { #name : #RBRefactoring }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring >> gtCleanupChanges [
	self model gtCleanupChanges
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring >> gtSignalMethodOverwritten: aSelector in: aClass [
	| message |
	message := (aClass directlyDefinesMethod: aSelector)
			ifTrue: [ ' is already defined in ' ]
			ifFalse: [ ' is already defined in the hierarchy of ' ].
	^ GtRefactoringNotification
		signal: aSelector , message , aClass name
		withTag: [ :button | 
			| container selectorButton label |
			container := BrHorizontalPane new.
			container fitContent.
			selectorButton := BrButton new
					aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousCodeFont;
					padding: (BlInsets all: 3);
					label: aSelector asRopedText bold;
					action: [ button phlow
							spawnObject: aSelector gtImplementors
									& (aClass realClass gtMethodsInClass
											includeSuperclass: true;
											includeSubclasses: true;
											yourself) ].
			label := BrLabel new
					aptitude: BrGlamorousLabelAptitude new;
					padding: (BlInsets
							top: 3
							left: 0
							bottom: 3
							right: 3);
					text: message asRopedText glamorousRegularFontAndSize
							, aClass name asRopedText glamorousCodeFont.
			container addChild: selectorButton.
			container addChild: label.
			container ]
]
