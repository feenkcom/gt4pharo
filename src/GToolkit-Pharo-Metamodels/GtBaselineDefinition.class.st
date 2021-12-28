Class {
	#name : #GtBaselineDefinition,
	#superclass : #GtClassDefinition,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Definitions'
}

{ #category : #initialization }
GtBaselineDefinition >> defaultNewClassName [

	^ #BaselineOfProjectName
]

{ #category : #initialization }
GtBaselineDefinition >> forPackageReference: aPackage [

	| aBaselineName aBaselineMethod aSourceCode |
	aBaselineName := aPackage name select: #isAlphaNumeric.
	
	self name: aBaselineName.
	
	aBaselineMethod := self methods methodNamed: #baseline:.
	
	aSourceCode := self baselineMethodSourceCodeTemplate format: { aPackage name }.
	
	aBaselineMethod sourceCode: aSourceCode.
]

{ #category : #accessing }
GtBaselineDefinition >> name: aSymbol [

	| aFullName |
	aFullName := (aSymbol beginsWith: BaselineOf name)
		  ifTrue: [ aSymbol ]
		  ifFalse: [ (BaselineOf name , aSymbol) asSymbol ].

	super name: aFullName.
	
	self updateCategory.
]

{ #category : #accessing }
GtBaselineDefinition >> originalName [

	| aName |
	aName := super originalName.
	aName ifNil: [ ^ aName ].

	^ (aName beginsWith: BaselineOf name)
		  ifTrue: [ aName ]
		  ifFalse: [ BaselineOf name , aName ]
]

{ #category : #'private - updating' }
GtBaselineDefinition >> updateCategory [

	self category package name: self name.
	self category tag name: ''
]
