Class {
	#name : #GtDefineParserFixItAction,
	#superclass : #GtFixItVariableNodeAction,
	#category : #'GToolkit-Pharo-Coder-AddOns-FixIt'
}

{ #category : #private }
GtDefineParserFixItAction >> addCreateClassAttributeInEditor: aBrTextEditor [
	| text stencilBlock attribute adornmentAttribute |
	text := aBrTextEditor text.
	stencilBlock := [ | element |
		element := GtCreationFormWidget forParser
				onAccept: [ :cls | 
					element
						enqueueTask: (BlTaskAction new action: [ sourceCoder requestStyleSourceText ]) ].
		element form parser: node name value asString.
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
GtDefineParserFixItAction >> description [
	^ 'Create SmaCC parser ' , self nodeName
]

{ #category : #accessing }
GtDefineParserFixItAction >> executeOn: anEditorElement [
	self clearFixItAttributeInEditor: anEditorElement editor.
	self addCreateClassAttributeInEditor: anEditorElement editor.
]

{ #category : #accessing }
GtDefineParserFixItAction >> id [
	<return: #BlElementId>

	^ GtDefineClassFixItActionElementId
]
