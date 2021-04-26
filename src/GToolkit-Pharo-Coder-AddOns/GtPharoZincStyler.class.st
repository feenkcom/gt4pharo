Class {
	#name : #GtPharoZincStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #accessing }
GtPharoZincStyler >> visitKeywordMessage: aMessage [
	super visitKeywordMessage: aMessage.
	(aMessage selector = #'username:password:'
		and: [ aMessage arguments last isLiteral and: [ 
			aMessage arguments last isString ] ] ) ifFalse: [ ^ self ].
	self 
		attribute: (BrTextReplacingAttribute new withCharacter: $*)
		from: aMessage arguments last startPosition + 1
		to: aMessage arguments last stopPosition - 1.
	(text 
		from: aMessage arguments last startPosition + 1
		to: aMessage arguments last stopPosition - 1)
		onCursorEnter: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			(aTextEditor text from: aFromIndex to: aToIndex) 
				clearAttributesOfClass: BrTextReplacingAttribute ] 
		leave: [ :aTextEditor :anEvent :aFromIndex :aToIndex | 
			(aTextEditor text from: aFromIndex to: aToIndex) 
				clearAttributesOfClass: BrTextReplacingAttribute;
				attribute: (BrTextReplacingAttribute new withCharacter: $*) ]
]
