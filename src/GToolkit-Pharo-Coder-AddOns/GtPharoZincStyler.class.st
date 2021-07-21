"
I hide secret information written in a code, e.g., passwords and tokens.
#Examples
##Password
The following code includes apassword that should be hidden by default: {{gtExample:GtPharoZincStylerExamples>>#usernameAndPasswordSourceCode}}
##Bearer
The following code includes apassword that should be hidden by default: {{gtExample: GtPharoZincStylerExamples >> #bearerSourceCode}}
"
Class {
	#name : #GtPharoZincStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Zinc'
}

{ #category : #accessing }
GtPharoZincStyler >> selectors [
	"Note: last argument is considered as a secret information, e.g., password."
	^ #( 'username:password:' 'setBearerAuthentication:' )
]

{ #category : #accessing }
GtPharoZincStyler >> visitKeywordMessage: aMessage [
	super visitKeywordMessage: aMessage.
	((self selectors includes: aMessage selector)
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
