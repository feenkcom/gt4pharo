Class {
	#name : #GtAbstractDefineClassFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #private }
GtAbstractDefineClassFixItAction >> addCreateClassAttributeInEditor: aBrTextEditor [
	| text stencilBlock attribute |
	text := aBrTextEditor text.
	stencilBlock := [ | element |
		element := self formCreationElement.
		sourceCoder package
			ifNotNil: [ :package | element form packageAndTagName packageName: package name ].
		sourceCoder packageTag
			ifNotNil: [ :tag | element form packageAndTagName tagName: tag name ].
		element
			addAptitude: BrShadowAptitude;
			background: Color white;
			margin: (BlInsets all: 10);
			padding: (BlInsets all: 8);
			constraintsDo: [ :c | 
				c textFlow pushLine.
				c horizontal matchParent ].
		element ].

	attribute := BrGlamorousTriangleExpanderTextAttributeV2 new
			beExpandedByDefault;
			stencil: stencilBlock;
			yourself.

	(text from: node name startPosition to: node name stopPosition)
		highlight: (BrGlamorousColors errorBackgroundColor alpha: 0.5).

	text
		attributes: {attribute. attribute expandedAppendingAttribute }
		from: self attributePosition
		to: self attributePosition
]

{ #category : #executing }
GtAbstractDefineClassFixItAction >> basicExecuteOn: anEditorElement [
	BlTaskAction enqueueElement: anEditorElement action: [
		self clearFixItAttributeInEditor: anEditorElement editor.
		self addCreateClassAttributeInEditor: anEditorElement editor. ]
]

{ #category : #accessing }
GtAbstractDefineClassFixItAction >> description [
	^self subclassResponsibility
]

{ #category : #executing }
GtAbstractDefineClassFixItAction >> finishExecuteOn: anEditorElement [
]

{ #category : #private }
GtAbstractDefineClassFixItAction >> formCreationElement [
	self subclassResponsibility
]

{ #category : #accessing }
GtAbstractDefineClassFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineClassFixItActionElementId
]
