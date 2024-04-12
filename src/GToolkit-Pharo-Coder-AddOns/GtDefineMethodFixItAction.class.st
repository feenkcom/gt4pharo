Class {
	#name : #GtDefineMethodFixItAction,
	#superclass : #GtFixItAction,
	#instVars : [
		'classOrMetaClass'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #executing }
GtDefineMethodFixItAction >> addCoderAttributeInEditor: aBrTextEditor [
	| position |
	position := self attributePosition.
	(aBrTextEditor text from: position to: position)
		attributes: {(GtPharoMethodExpanderAttribute
					forClass: classOrMetaClass
					andSelector: self selector) isExpanded: true}
]

{ #category : #accessing }
GtDefineMethodFixItAction >> attributePosition [
	^ node isMessage
		ifTrue: [ node selectorParts last stopPosition ]
		ifFalse: [ node stopPosition ]
]

{ #category : #accessing }
GtDefineMethodFixItAction >> classOrMetaClass: anObject [
	classOrMetaClass := anObject
]

{ #category : #private }
GtDefineMethodFixItAction >> compileMethod [
	| refactoring |
	refactoring := self createRefactoring.
	refactoring execute
]

{ #category : #private }
GtDefineMethodFixItAction >> createRefactoring [
	^ RBAddMethodRefactoring
		addMethod: self methodSource
		toClass: classOrMetaClass
		inProtocols: {self targetProtocol}
]

{ #category : #accessing }
GtDefineMethodFixItAction >> description [
	^ 'Create method ' , self selector , ' in class ' , classOrMetaClass name
]

{ #category : #executing }
GtDefineMethodFixItAction >> executeOn: anEditorElement [
	self compileMethod.
	self clearFixItAttributeInEditor: anEditorElement editor.
	self addCoderAttributeInEditor: anEditorElement editor.
]

{ #category : #'gt - extensions' }
GtDefineMethodFixItAction >> gtViewDiffFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		priority: 1;
		stencil: [ | previousContent newContent change |
			previousContent := ''.
			newContent := String
					streamContents: [ :stream | 
						stream
							nextPutAll: '"protocol: ';
							nextPutAll: self targetProtocol;
							nextPut: $";
							cr;
							cr;
							nextPutAll: self createRefactoring gtSource ].

			change := GtDiffBuilder
					computeDifferencesFrom: previousContent
					to: newContent
					using: GtSmaCCDiffSplitter forPharo.
			GtDiffElementWithLabelStencil new
				fromLabelText: 'Current:';
				toLabelText: 'Change:';
				change: change;
				styler: GtCodeDiffRBTextStyler new ];
		actionButtonIcon: BrGlamorousIcons inspect
			label: 'Refactoring'
			tooltip: 'Inspect the refactoring that is executed by this action'
			action: [ :aButton | 
				| newRefactoring |
				newRefactoring := self createRefactoring.
				newRefactoring primitiveExecute.
				aButton phlow spawnObject: newRefactoring model ]
]

{ #category : #'gt - extensions' }
GtDefineMethodFixItAction >> gtViewMethodCodeFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Method Code';
		object: [ self createRefactoring ];
		view: #gtViewMethodCodeFor:
]

{ #category : #accessing }
GtDefineMethodFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineMethodFixItActionElementId
]

{ #category : #private }
GtDefineMethodFixItAction >> methodSource [
	node isLiteral
		ifTrue: [ | selector |
			selector := node literalValue.
			selector numArgs = 0 ifTrue: [ ^ selector ].
			^ String
				streamContents: [ :stream | 
					selector keywords
						keysAndValuesDo: [ :i :part | 
							stream
								nextPutAll: part;
								nextPutAll: ' anObject';
								print: i ] ] ].
	node arguments isEmpty ifTrue: [ ^ node selector ].
	^ String
		streamContents: [ :stream | 
			| variables baseName name index |
			variables := Set new.
			node selectorParts
				with: node arguments
				do: [ :eachSelectorPart :arg | 
					stream
						nextPutAll: eachSelectorPart source;
						space.
					baseName := arg isVariable
							ifTrue: [ arg isSpecialVariable ifTrue: [ 'anObject' ] ifFalse: [ arg variableName ] ]
							ifFalse: [ arg isLiteral
									ifTrue: [ arg literalValue class canonicalArgumentName ]
									ifFalse: [ 'anObject' ] ].
					index := 0.
					name := baseName.
					[ variables includes: name ]
						whileTrue: [ index := index + 1.
							name := baseName , index printString ].
					variables add: name.
					stream
						nextPutAll: name;
						space ] ]
]

{ #category : #accessing }
GtDefineMethodFixItAction >> selector [
	^ node isMessage ifTrue: [ node selector ] ifFalse: [ node literalValue ]
]

{ #category : #private }
GtDefineMethodFixItAction >> targetProtocol [
	^ (sourceCoder protocol ifNil: [ #accessing ])
]
