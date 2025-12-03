Class {
	#name : #GtCreateClassAction,
	#superclass : #GtCoderViewModelRenameAction,
	#instVars : [
		'variable',
		'package',
		'tag',
		'superclass'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #'instance creation' }
GtCreateClassAction class >> variable: aGtPharoMessageNode textualCoderViewModel: aTextualCoderViewModel [
	^ self new
		variable: aGtPharoMessageNode;
		pharoSourceCoderViewModel: aTextualCoderViewModel;
		yourself
]

{ #category : #'private - attributes' }
GtCreateClassAction >> addRenameAttributes [
	| text index |
	text := self pharoSourceCoderViewModel styledText
			ifNil: [ self pharoSourceCoderViewModel sourceText ].

	index := 1.
	coderAttributes := (originalLocations
			collect: [ :each | 
				| attribute |
				attribute := GtRenameEditorAttribute new
						action: self;
						selectAll: selectAll;
						filter: filter;
						text: (text from: each first to: each last);
						requestInitialFocus: requestInitialFocus;
						coordinateFocus: true.
				index := index + 1.

				self pharoSourceCoderViewModel
					addTextAttribute: attribute
					from: each first
					to: each last ]) asOrderedCollection.

	renameAttributes := coderAttributes
			flatCollect: [ :eachCoderAttribute | eachCoderAttribute textAttributes ].

	originalLocations notEmpty
		ifTrue: [ coderAttributes
				add: (self pharoSourceCoderViewModel
						addTextAttribute: (GtCreateClassExpanderAttribute new
								action: self;
								setPackage: package andTag: tag;
								yourself)
						from: originalLocations first last
						to: originalLocations first last) ]
]

{ #category : #accessing }
GtCreateClassAction >> category [
	^ (package trim , (tag isEmptyOrNil ifTrue: [ '' ] ifFalse: [ '-' , tag trim ]))
		asSymbol
]

{ #category : #initialization }
GtCreateClassAction >> initialize [
	super initialize.
	filter := GtSelectorInputFilter forUnaryMessage.
	self hasRefactoringPreview: true
]

{ #category : #accessing }
GtCreateClassAction >> newClassName [
	^ renameAttributes
		ifNil: [ variable source ]
		ifNotNil: [ renameAttributes first text asString ]
]

{ #category : #accessing }
GtCreateClassAction >> package [
	^ package
]

{ #category : #accessing }
GtCreateClassAction >> package: aSymbol [
	package := aSymbol
]

{ #category : #accessing }
GtCreateClassAction >> superclass [
	^ superclass
]

{ #category : #accessing }
GtCreateClassAction >> superclass: aSymbol [
	superclass := aSymbol
]

{ #category : #accessing }
GtCreateClassAction >> tabAccept: forward [
]

{ #category : #accessing }
GtCreateClassAction >> tag [
	^ tag
]

{ #category : #accessing }
GtCreateClassAction >> tag: aSymbol [
	tag := aSymbol
]

{ #category : #accessing }
GtCreateClassAction >> updateName: blText [
	self announceEvent: #textUpdated
]

{ #category : #accessing }
GtCreateClassAction >> updatePackage: aString [
	package := aString.
	self announceEvent: #categoryUpdated
]

{ #category : #accessing }
GtCreateClassAction >> updatePackageTag: aString [
	tag := aString.
	self announceEvent: #categoryUpdated
]

{ #category : #accessing }
GtCreateClassAction >> updateSuperclass: aString [
	superclass := aString.
	self announceEvent: #superclassUpdated
]

{ #category : #accessing }
GtCreateClassAction >> variable [
	^ variable
]

{ #category : #accessing }
GtCreateClassAction >> variable: aVariable [
	variable := aVariable.
	originalLocations := {aVariable sourceInterval}
]
