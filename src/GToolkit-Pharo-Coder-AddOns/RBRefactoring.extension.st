Extension { #name : #RBRefactoring }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring >> gtCleanupChanges [
	self model gtCleanupChanges
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring class >> gtComponentRefactoringClassIn: node do: aBlock [
	node isVariable
		ifTrue: [ node methodNode
				nodesDo: [ :each | 
					(each isAssignment and: [ each variable = node ])
						ifTrue: [ self gtComponentRefactoringClassIn: each value do: aBlock ] ] ]
		ifFalse: [ (node isMessage or: [ node isCascade ])
				ifTrue: [ node receiver isVariable
						ifTrue: [ (self class bindingOf: node receiver name) value
								ifNotNil: [ :obj | 
									(obj isBehavior and: [ obj inheritsFrom: RBRefactoring ])
										ifTrue: [ aBlock value: obj ] ] ]
						ifFalse: [ self gtComponentRefactoringClassIn: node receiver do: aBlock ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring class >> gtComponentRefactoringsFor: aView [
	<gtClassView>
	| map children |
	map := self gtComponentRefactoringsMap.
	children := [ :cls | 
		cls withAllSuperclasses
			flatCollectAsSet: [ :each | map at: each ifAbsent: [ #() ] ] ].
	(children value: self) isEmpty ifTrue: [ ^ aView empty ].
	^ aView tree
		title: 'Component refactorings';
		items: [ {{self.
					nil}} ];
		children: [ :each | 
			(children value: each first)
				asSortedCollection: [ :a :b | a first name < b first name ] ];
		itemText: [ :each | each first name ];
		send: [ :each | 
			each last
				ifNotNil: [ (GtPharoMethodCoder forMethod: each last)
						highlighter: each first gtReferences highlighter;
						yourself ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring class >> gtComponentRefactoringsMap [
	| map |
	map := Dictionary new.
	(GtPharoIndex current sendersOf: #performCompositeRefactoring:)
		do: [ :method | 
			method ast
				nodesDo: [ :each | 
					(each isMessage and: [ each selector = #performCompositeRefactoring: ])
						ifTrue: [ self
								gtComponentRefactoringClassIn: each arguments first
								do: [ :cls | 
									(map at: method methodClass ifAbsentPut: [ Set new ])
										add: {cls.
												method} ] ] ] ].
	^ map
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

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBRefactoring >> gtUsesSendOf: aSymbol [
	self model
		allReferencesTo: aSymbol
		do: [ :method | 
			method ast
				nodesDo: [ :node | 
					(node isMessage and: [ node selector = aSymbol and: [ node isUsed ] ])
						ifTrue: [ ^ true ].
					(node isLiteralNode and: [ node value = aSymbol ]) ifTrue: [ ^ true ] ] ].
	^ false
]
