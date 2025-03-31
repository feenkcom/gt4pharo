"
I hide secret information written in a code, e.g., secret IDs and tokens.
#Example
The following code includes a secret information that should be hidden by default: {{gtExample:GtPharoZincApplicationFormUrlEncodedEntityStylerExamples>>#sourceCode}}
"
Class {
	#name : #GtPharoZincApplicationFormUrlEncodedEntityStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #accessing }
GtPharoZincApplicationFormUrlEncodedEntityStyler >> secretKeys [
	^ #( 'secret' 'token' 'password' )
]

{ #category : #accessing }
GtPharoZincApplicationFormUrlEncodedEntityStyler >> visitKeywordMessage: aMessage [
	super visitKeywordMessage: aMessage.
	aMessage selector = #'at:put:' ifFalse: [ ^ self ].
	(aMessage arguments first isLiteral and: [ 
			aMessage arguments first isString ]) ifFalse: [ ^ self ].
	(aMessage arguments last isLiteral and: [ 
			aMessage arguments last isString ]) ifFalse: [ ^ self ].

	(self secretKeys anySatisfy: [ :eachKey | 
		aMessage arguments first string sameAs:  eachKey]) ifFalse: [ ^ self ].
	
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
