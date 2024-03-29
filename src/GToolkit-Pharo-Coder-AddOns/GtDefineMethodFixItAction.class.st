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
	refactoring := RBAddMethodRefactoring
		addMethod: self methodSource
		toClass: classOrMetaClass
		inProtocols: {(sourceCoder protocol ifNil: [ #accessing ])}.
	refactoring execute
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
