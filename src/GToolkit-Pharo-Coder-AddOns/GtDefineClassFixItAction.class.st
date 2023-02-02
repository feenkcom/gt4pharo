Class {
	#name : #GtDefineClassFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #private }
GtDefineClassFixItAction >> addCreateClassAttributeInEditor: aBrTextEditor [
	| text stencilBlock attribute adornmentAttribute |
	text := aBrTextEditor text.
	stencilBlock := [ | element |
		element := GtCreationFormWidget forClass
				onAccept: [ :cls | element inUIProcessDo: [ sourceCoder requestStyleSourceText ] ].
		element form newClassName: node name value asSymbol.
		sourceCoder package
			ifNotNil: [ :package | element form packageAndTagName packageName: package name ].
		sourceCoder packageTag
			ifNotNil: [ :tag | element form packageAndTagName tagName: tag name ].
		element addAptitude: BrShadowAptitude.
		element background: Color white.
		element margin: (BlInsets all: 10).
		element padding: (BlInsets all: 8).
		element
			constraintsDo: [ :c | 
				c textFlow pushLine.
				c horizontal matchParent ].
		element ].
	adornmentAttribute := BrTextAdornmentDynamicAttribute new
			beAppend;
			stencil: stencilBlock.
	attribute := BrGlamorousTriangleExpanderTextAttribute new.
	attribute isExpanded: true.
	attribute createdAttributes: {adornmentAttribute}.
	attribute attributesCreatingBlock: [ adornmentAttribute ].

	(text from: node name startPosition to: node name stopPosition)
		highlight: (BrGlamorousColors errorBackgroundColor alpha: 0.5).

	text
		attributes: {attribute.
				adornmentAttribute}
		from: self attributePosition
		to: self attributePosition
]

{ #category : #accessing }
GtDefineClassFixItAction >> description [
	^ 'Create class ' , self nodeName
]

{ #category : #accessing }
GtDefineClassFixItAction >> executeOn: anEditorElement [
	self clearFixItAttributeInEditor: anEditorElement editor.
	self addCreateClassAttributeInEditor: anEditorElement editor.
]

{ #category : #accessing }
GtDefineClassFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineClassFixItActionElementId
]
